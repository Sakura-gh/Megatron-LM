# Copyright (c) 2023, NVIDIA CORPORATION. All rights reserved.

"""GPT-2 model."""

import torch

from megatron import get_args
from megatron.core import tensor_parallel
from .module import MegatronModule

from .enums import AttnMaskType
from .language_model import parallel_lm_logits
from .language_model import get_language_model

def print_ranks(message, ranks=[0]):
    if torch.distributed.is_initialized():
        local_rank = torch.distributed.get_rank()
        if local_rank in ranks:
            print(f'rank {local_rank}: {message}', flush=True)

def post_language_model_processing(lm_output, labels, logit_weights,
                                   parallel_output,
                                   fp16_lm_cross_entropy):

    # Output. Format [s b h]
    output = parallel_lm_logits(
        lm_output,
        logit_weights,
        parallel_output)

    if labels is None:
        # [s b h] => [b s h]
        return output.transpose(0,1).contiguous()
    else:
        # [b s] => [s b]
        labels = labels.transpose(0,1).contiguous()
        if fp16_lm_cross_entropy:
            assert output.dtype == torch.half
            loss = tensor_parallel.vocab_parallel_cross_entropy(output, labels)
        else:
            loss = tensor_parallel.vocab_parallel_cross_entropy(output.float(), labels)
        
        # [s b] => [b, s]
        loss = loss.transpose(0,1).contiguous()
        return loss

from flash_attn.bert_padding import index_first_axis, pad_input, unpad_input

import torch.nn.functional as F
from megatron.core import mpu
def pad_to_sequence_parallel(unpad_tokens: torch.Tensor):
    """pad the tokens such that the total length is a multiple of sp world size

    Args:
        unpad_tokens: (total_nnz, ...). Tokens after removing padding

    Returns:

    """
    total_nnz = unpad_tokens.shape[0]
    sp_world_size = mpu.get_tensor_model_parallel_world_size()

    if total_nnz % sp_world_size == 0:
        pad_size = 0
    else:
        pad_size = sp_world_size - total_nnz % sp_world_size

    if pad_size > 0:
        if unpad_tokens.ndim == 1:
            unpad_tokens = F.pad(unpad_tokens, (0, pad_size))
        elif unpad_tokens.ndim == 2:
            unpad_tokens = F.pad(unpad_tokens, (0, 0, 0, pad_size))
        else:
            raise NotImplementedError(f'Padding dim {unpad_tokens.ndim()} is not supported')

    return unpad_tokens

class GPTModel(MegatronModule):
    """GPT-2 Language model."""

    def __init__(self,
                 config,
                 num_tokentypes=0,
                 parallel_output=True,
                 pre_process=True,
                 post_process=True):
        args = get_args()
        self.args = args
        super().__init__(config=config, share_embeddings_and_output_weights=not args.untie_embeddings_and_output_weights)

        self.parallel_output = parallel_output
        self.pre_process = pre_process
        self.post_process = post_process
        self.fp16_lm_cross_entropy = args.fp16_lm_cross_entropy
        self.untie_embeddings_and_output_weights = args.untie_embeddings_and_output_weights
        self.sequence_packing = args.sequence_packing
        self.sequence_parallel = args.sequence_parallel
        self.language_model, self._language_model_key = get_language_model(
            config=config,
            num_tokentypes=num_tokentypes,
            add_pooler=False,
            encoder_attn_mask_type=AttnMaskType.causal,
            pre_process=self.pre_process,
            post_process=self.post_process)
        
        if not args.untie_embeddings_and_output_weights:
            self.initialize_word_embeddings()

    def set_input_tensor(self, input_tensor):
        """See megatron.model.transformer.set_input_tensor()"""
        self.language_model.set_input_tensor(input_tensor)

    def forward(self, input_ids, position_ids, attention_mask,
                retriever_input_ids=None,
                retriever_position_ids=None,
                retriever_attn_mask=None,
                labels=None, tokentype_ids=None, inference_params=None):

        if self.sequence_packing:
            batch_size, sequence_length = input_ids.shape
            # sequence packing
            # remove padding here: (batch_size, seq_len) -> (total_nnz, 1)
            input_ids, indices, cu_seqlens, max_seqlen_in_batch = unpad_input(input_ids.unsqueeze(dim=-1),
                                                                              attention_mask)                                                                         
            position_ids, _, _, _ = unpad_input(position_ids.unsqueeze(dim=-1), attention_mask)
            
            # pad input_ids to multiple of tp for all tp ranks
            # TODO: for better performance, the sp padding should be removed at each layer. Not sure the performance gap
            if self.sequence_parallel:
                # (total_nnz, 1) -> (total_nnz_padded, 1)
                input_ids = pad_to_sequence_parallel(input_ids)
                position_ids = pad_to_sequence_parallel(position_ids)

            # (total_nnz_padded, 1) -> (1, total_nnz_padded)
            input_ids = input_ids.transpose(0, 1).contiguous()
            position_ids = position_ids.transpose(0, 1).contiguous()
            # sequence packing
        else:
            sequence_length, indices, cu_seqlens, max_seqlen_in_batch = None, None, None, None

        # (1, total_nnz_padded) -> (1, total_nnz_padded//tp) -> (1, total_nnz_padded//tp, hidden_size) -> (total_nnz_padded//tp, 1, hidden_size)
        lm_output = self.language_model(
            input_ids,
            position_ids,
            attention_mask,
            # for flash-attn sequence packing
            sequence_length=sequence_length,
            indices=indices,
            cu_seqlens=cu_seqlens,
            max_seqlen_in_batch=max_seqlen_in_batch,
            # for flash-attn sequence packing
            retriever_input_ids=retriever_input_ids,
            retriever_position_ids=retriever_position_ids,
            retriever_attn_mask=retriever_attn_mask,
            inference_params=inference_params)

        if self.post_process:
            if self.sequence_packing:
                # remove padding from sequence parallel
                # (total_nnz_padded//tp, 1, hidden_size) -> (total_nnz, 1, hidden_size)
                if self.sequence_parallel:
                    lm_output = tensor_parallel.gather_from_sequence_parallel_region(lm_output)
                    self.args.sequence_parallel = False # workaround: avoid gather again in post process
                    totol_nnz = cu_seqlens[-1]
                    lm_output = lm_output[:totol_nnz]

                # lm_output: (total_nnz, 1, hidden_size) -> (total_nnz, hidden_size)
                lm_output = torch.squeeze(lm_output, dim=1) # remove the artificial batch dimension
                # (total_nnz, hidden_size) -> (batch_size, seq_len, hidden_size)
                lm_output = pad_input(lm_output, indices, batch_size, sequence_length)
                # (batch_size, seq_len, hidden_size) -> (seq_len, batch_size, hidden_size)
                lm_output = lm_output.transpose(0, 1).contiguous()
            return post_language_model_processing(
                lm_output, labels,
                self.language_model.output_layer.weight if self.untie_embeddings_and_output_weights else self.shared_embedding_or_output_weight(),
                self.parallel_output,
                self.fp16_lm_cross_entropy)
        else:
            return lm_output

    def state_dict_for_save_checkpoint(self, prefix='', keep_vars=False):

        state_dict_ = {}
        state_dict_[self._language_model_key] \
            = self.language_model.state_dict_for_save_checkpoint(
                prefix=prefix, keep_vars=keep_vars)
        # Save word_embeddings.
        if self.post_process and not self.pre_process and not self.untie_embeddings_and_output_weights:
            state_dict_[self._word_embeddings_for_head_key] \
                = self.word_embeddings.state_dict(prefix=prefix,
                                                  keep_vars=keep_vars)
        return state_dict_

    def load_state_dict(self, state_dict, strict=True):
        """Customized load."""

        # Load word_embeddings.
        if self.post_process and not self.pre_process and not self.untie_embeddings_and_output_weights:
            self.word_embeddings.load_state_dict(
                state_dict[self._word_embeddings_for_head_key], strict=strict)
        if self._language_model_key in state_dict:
            state_dict = state_dict[self._language_model_key]
        self.language_model.load_state_dict(state_dict, strict=strict)

# Copyright (c) 2023, NVIDIA CORPORATION. All rights reserved.

"""GPT-2 model."""

import torch

from megatron import get_args
from megatron.core import tensor_parallel
from .module import MegatronModule

from .enums import AttnMaskType
from .language_model import parallel_lm_logits
from .language_model import get_language_model
from .utils import init_method_normal
from .utils import scaled_init_method_normal

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

class GPTModel(MegatronModule):
    """GPT-2 Language model."""

    def __init__(self,
                 num_tokentypes=0,
                 parallel_output=True,
                 pre_process=True,
                 post_process=True):
        args = get_args()
        super(GPTModel, self).__init__(share_word_embeddings=not args.untie_embeddings_and_output_weights)

        self.parallel_output = parallel_output
        self.pre_process = pre_process
        self.post_process = post_process
        self.fp16_lm_cross_entropy = args.fp16_lm_cross_entropy
        self.untie_embeddings_and_output_weights = args.untie_embeddings_and_output_weights

        self.language_model, self._language_model_key = get_language_model(
            num_tokentypes=num_tokentypes,
            add_pooler=False,
            encoder_attn_mask_type=AttnMaskType.causal,
            init_method=init_method_normal(args.init_method_std),
            scaled_init_method=scaled_init_method_normal(args.init_method_std,
                                                         args.num_layers),
            pre_process=self.pre_process,
            post_process=self.post_process)
        
        if not args.untie_embeddings_and_output_weights:
            self.initialize_word_embeddings(init_method_normal)

    def set_input_tensor(self, input_tensor):
        """See megatron.model.transformer.set_input_tensor()"""
        self.language_model.set_input_tensor(input_tensor)

    def forward(self, input_ids, position_ids, attention_mask,
                retriever_input_ids=None,
                retriever_position_ids=None,
                retriever_attn_mask=None,
                labels=None, tokentype_ids=None, inference_params=None):
        batch_size, sequence_length = input_ids.shape
        # sequence packing
        # remove padding here: (batch_size, seq_len) -> (total_nnz, 1) -> (1, total_nnz)
        # print_ranks(f'before remove padding: input_ids shape = {input_ids.shape}, attention mask shape = {attention_mask.shape}')
        input_ids, indices, cu_seqlens, max_seqlen_in_batch = unpad_input(input_ids.unsqueeze(dim=-1),
                                                                          attention_mask)
        # print_ranks(f'after remove padding: input_ids shape = {input_ids.shape}, attention mask shape = {attention_mask.shape}')                                                                          
        position_ids, _, _, _ = unpad_input(position_ids.unsqueeze(dim=-1), attention_mask)
        input_ids = input_ids.transpose(0, 1).contiguous()
        position_ids = position_ids.transpose(0, 1).contiguous()
        # sequence packing

        # print_ranks(f'in gpt_model before language_model: input_ids.shape = {input_ids.shape}, position_ids.shape = {position_ids.shape}')
        # (1, total_nnz) -> (1, total_nnz, hidden_size) -> (total_nnz, 1, hidden_size)
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
        # print_ranks(f'in gpt_model after language_model: input_ids.shape = {input_ids.shape}, position_ids.shape = {position_ids.shape}')

        if self.post_process:
            # label: (batch_size, seq_len)
            # lm_output: (total_nnz, 1, hidden_size) -> (total_nnz, hidden_size) -> (batch_size, seq_len, hidden_size)
            lm_output = torch.squeeze(lm_output, dim=1) # remove the artificial batch dimension
            lm_output = pad_input(lm_output, indices, batch_size, sequence_length)
            # (batch_size, seq_len, hidden_size) -> (seq_len, batch_size, hidden_size)
            lm_output = lm_output.transpose(0, 1).contiguous()
            # print_ranks(f'in gpt_model before loss: lm_output.shape={lm_output.shape}, labels.shape={labels.shape}\n')
            return post_language_model_processing(
                lm_output, labels,
                self.language_model.output_layer.weight if self.untie_embeddings_and_output_weights else self.word_embeddings_weight(),
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

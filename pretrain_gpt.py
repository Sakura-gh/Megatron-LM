# Copyright (c) 2023, NVIDIA CORPORATION.  All rights reserved.

"""Pretrain GPT"""

import torch
from functools import partial
from megatron import get_args
from megatron import print_rank_0
from megatron import get_timers
from megatron import get_tokenizer
from megatron.core import mpu
from megatron.core import tensor_parallel
from megatron.core.enums import ModelType
from megatron.data.gpt_dataset import build_train_valid_test_datasets
from megatron.model import GPTModel
from megatron.training import pretrain
from megatron.utils import get_ltor_masks_and_position_ids
from megatron.utils import average_losses_across_data_parallel_group
from gpt_seq_dataset import GPTJsonDataset, get_mask_and_position_ids
from megatron.model.gpt_model import print_ranks

def model_provider(pre_process=True, post_process=True):
    """Build the model."""

    print_rank_0('building GPT model ...')
    model = GPTModel(
        num_tokentypes=0,
        parallel_output=True,
        pre_process=pre_process,
        post_process=post_process
    )
    return model

statistics = {
    'packing_seq_len': {
        '128': 0,
        '256': 0,
        '512': 0,
        '1024': 0,
        '2048': 0,
        '4096': 0,
        '8192': 0,
        '16384': 0,
        '>16k': 0
    },
    'real_seq_len': {
        '128': 0,
        '256': 0,
        '512': 0,
        '1024': 0,
        '2048': 0,
        '4096': 0,
        '8192': 0,
        '16384': 0,
        '>16k': 0
    }    
}

def update_statistics(seq_len, attr='packing_seq_len'):
    if seq_len <= 128:
        statistics[attr]['128'] += 1
    elif seq_len <= 256:
        statistics[attr]['256'] += 1
    elif seq_len <= 512:
        statistics[attr]['512'] += 1
    elif seq_len <= 1024:
        statistics[attr]['1024'] += 1
    elif seq_len <= 2048:
        statistics[attr]['2048'] += 1
    elif seq_len <= 4096:
        statistics[attr]['4096'] += 1
    elif seq_len <= 8192:
        statistics[attr]['8192'] += 1
    elif seq_len <= 16384:
        statistics[attr]['16384'] += 1
    else:
        statistics[attr]['>16k'] += 1

def get_batch(data_iterator):
    """Generate a batch"""
    args = get_args()
    tokenizer = get_tokenizer()

    # Items and their type.
    # keys = ['text']
    # datatype = torch.int64

    # Broadcast data.
    if data_iterator is not None:
        data = next(data_iterator)
        # data = data.cuda()
    else:
        data = None
    # data_b = tensor_parallel.broadcast_data(keys, data, datatype)

    datatype = torch.int64
    data = tensor_parallel.broadcast_data(data, datatype)

    # Unpack.
    # tokens_ = data_b['text'].long()
    tokens_ = data.long()
    labels = tokens_[:, 1:].contiguous()
    tokens = tokens_[:, :-1].contiguous()

    # print(f'tokens = {tokens}\nargs.reset_position_ids={args.reset_position_ids}, args.reset_attention_mask={args.reset_attention_mask}')

    # # Get the masks and postition ids.
    # attention_mask, loss_mask, position_ids = get_ltor_masks_and_position_ids(
    #     tokens,
    #     tokenizer.eod,
    #     args.reset_position_ids,
    #     args.reset_attention_mask,
    #     args.eod_mask_loss)

    attention_mask, position_ids = get_mask_and_position_ids(tokens, tokenizer.pad)
    attention_mask = attention_mask.cuda()
    position_ids = position_ids.cuda()
    loss_mask = torch.ones(tokens.size(), dtype=torch.float).cuda()

    # statistics for analysis
    packing_seq_len = attention_mask.eq(True).sum().item()
    update_statistics(packing_seq_len, 'packing_seq_len')

    real_seq_len_list = attention_mask.eq(True).sum(dim=1).tolist()
    for real_seq_len in real_seq_len_list:
        update_statistics(real_seq_len, 'real_seq_len')

    return tokens, labels, loss_mask, attention_mask, position_ids

def loss_func(loss_mask, output_tensor):
    losses = output_tensor.float()
    loss_mask = loss_mask.view(-1).float()
    loss = torch.sum(losses.view(-1) * loss_mask) / loss_mask.sum()

    # Reduce loss for logging.
    averaged_loss = average_losses_across_data_parallel_group([loss])

    return loss, {'lm loss': averaged_loss[0]}


def forward_step(data_iterator, model):
    """Forward step."""
    args = get_args()
    timers = get_timers()

    # Get the batch.
    timers('batch-generator', log_level=2).start()
    tokens, labels, loss_mask, attention_mask, position_ids = get_batch(
        data_iterator)
    timers('batch-generator').stop()

    output_tensor = model(tokens, position_ids, attention_mask,
                          labels=labels)

    return output_tensor, partial(loss_func, loss_mask)


def train_valid_test_datasets_provider(train_val_test_num_samples):
    """Build train, valid, and test datasets."""
    args = get_args()

    print_rank_0('> building train, validation, and test datasets '
                 'for GPT ...')
    train_ds, valid_ds, test_ds = build_train_valid_test_datasets(
        data_prefix=args.data_path,
        data_impl=args.data_impl,
        splits_string=args.split,
        train_valid_test_num_samples=train_val_test_num_samples,
        seq_length=args.seq_length,
        seed=args.seed,
        skip_warmup=(not args.mmap_warmup),
        train_data_prefix=args.train_data_path,
        valid_data_prefix=args.valid_data_path,
        test_data_prefix=args.test_data_path,
        data_cache_path=args.data_cache_path)
    print_rank_0("> finished creating GPT datasets ...")

    return train_ds, valid_ds, test_ds

def train_dataset_provider():
    """Build train dataset."""
    args = get_args()
    train_dataset = GPTJsonDataset(
        json_file=args.json_file,
        key=args.json_key,
        max_seq_len=args.seq_length,
        vocab_file=args.vocab_file,
        merge_file=args.merge_file)
    
    return train_dataset



if __name__ == "__main__":

    # pretrain(train_valid_test_datasets_provider,
    #          model_provider,
    #          ModelType.encoder_or_decoder,
    #          forward_step,
    #          args_defaults={'tokenizer_type': 'GPT2BPETokenizer'})
    pretrain(train_dataset_provider,
             model_provider,
             ModelType.encoder_or_decoder,
             forward_step,
             args_defaults={'tokenizer_type': 'GPT2BPETokenizer'})
    print_ranks(f'{statistics}', [0,1,2,3,4,5,6,7,8])

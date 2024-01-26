import os
import json
import pickle
import time
from tqdm import tqdm
from types import SimpleNamespace

import torch
from torch.utils.data import Dataset, DataLoader
from megatron.tokenizer import build_tokenizer

class Encoder(object):
    def __init__(self, args):
        self.args = args
        self.tokenizer = build_tokenizer(self.args)

    def pad_id(self):
        return self.tokenizer.pad

    def encode(self, json_line):
        data = json.loads(json_line)
        doc = data[self.args.key] # key: content for web, text for wiki
        assert self.args.tokenizer_type == 'GPT2BPETokenizer', 'Now only support GPT2BPETokenizer!'
        doc_ids = self.tokenizer.tokenize(doc)
        if len(doc_ids) > self.args.max_seq_len:
            doc_ids = doc_ids[:self.args.max_seq_len]
        elif len(doc_ids) < self.args.max_seq_len:
            doc_ids += [self.tokenizer.pad] * (self.args.max_seq_len - len(doc_ids))
        
        return doc_ids

class GPTJsonDataset(Dataset):
    def __init__(self, json_file, key, max_seq_len, vocab_file, merge_file):
        args = {
            'key': key,
            'max_seq_len': max_seq_len,
            'rank': 0,
            'make_vocab_size_divisible_by': 128,
            'tensor_model_parallel_size': 1,
            'vocab_extra_ids': 0,
            'tokenizer_type': 'GPT2BPETokenizer',
            'vocab_file': vocab_file,
            'merge_file': merge_file,
        }
        args = SimpleNamespace(**args)
        self.encoder = Encoder(args)
        self.data = []
        # read exists cache here
        cache_folder = json_file.split('.')[0]
        cache_path = cache_folder + f'/cache_key={key}_seqlen={max_seq_len}.pkl'
        if os.path.exists(cache_path):
            print(f'Loading exists cache from {cache_path} ...')
            with open(cache_path, 'rb') as f:
                self.data = pickle.load(f)
            return

        # tokenize data from json file
        print(f'Building dataset begin ...')
        start_time = time.time()
        with open(json_file, 'r') as f:
            for json_line in tqdm(f.readlines()):
                doc_ids = self.encoder.encode(json_line)
                self.data.append(doc_ids)
        end_time = time.time()
        print(f'Building dataset end, time cost: {end_time - start_time}s')
        
        # save cache
        print(f'Saving cache to {cache_path} begin ...')
        start_time = time.time()
        if not os.path.exists(cache_folder):
            os.makedirs(cache_folder)
        with open(cache_path, 'wb') as f:
            pickle.dump(self.data, f)
        end_time = time.time()
        print(f'Saving cache end, time cost: {end_time - start_time}s')

    
    def __len__(self):
        return len(self.data)

    def __getitem__(self, idx):
        tokens = torch.tensor(self.data[idx])
        return tokens

if __name__ == '__main__':
    test_dataset = GPTJsonDataset(
        json_file='/home/gehao/megatron/Megatron-LM-23.05/data/web/refinedweb0.json',
        key='content',
        max_seq_len=1024,
        vocab_file='/home/gehao/megatron/Megatron-LM-23.05/data/vocab.json',
        merge_file='/home/gehao/megatron/Megatron-LM-23.05/data/merges.txt')
    test_dataloader = DataLoader(test_dataset, batch_size=8, shuffle=True)
    for idx, tokens in enumerate(test_dataloader):
        if idx > 4:
            break
        print(f'batch {idx}: tokens = {tokens}')
import argparse
import os

# model_size: [num_layers, hidden_size, num_attn_heads]
model_configs = {
    '3b': [32, 2560, 32],
    '7b': [32, 4096, 32],
    '13b': [40, 5120, 40]
}

# num_gpus: [...]
parallel_strategies = {
    '8': [
        [8, 1, 1],
        [4, 2, 1],
        [4, 1, 2],
        [2, 2, 2],
        [2, 4, 1],
        [2, 1, 4],
        [1, 4, 2],
        [1, 2, 4],
        [1, 8, 1],
        [1, 1, 8]
    ],
    '16': [
        [16, 1, 1],
        [8, 2, 1],
        [8, 1, 2],
        [4, 4, 1],
        [4, 1, 4],
        [4, 2, 2],
        [2, 8, 1],
        [2, 1, 8],
        [2, 4, 2],
        [2, 2, 4],
        [1, 16, 1],
        [1, 1, 16],
        [1, 8, 2],
        [1, 2, 8],
        [1, 4, 4]
    ]
}

tokens = 128 * 1024 # 128k
seq_lens = [512, 1024, 2048, 4096, 8192, 16384]
num_micro_batches = [2, 4, 8]
num_gpus = 8
script_file = f'benchmark/benchmark_tokens_{num_gpus}gpus.sh'
model_type = '7b'
model_config_str = ' '.join(str(c) for c in model_configs[model_type])

with open(script_file, 'w') as f:
    for seq_len in seq_lens:
        f.write(f'# {model_type}, {seq_len}\n')
        gbs = tokens // seq_len
        for parallel_strategy in parallel_strategies[str(num_gpus)]:
            parallel_strategy_str = ' '.join(str(s) for s in parallel_strategy)
            for num_micro_batch in num_micro_batches:
                mbs = gbs // num_micro_batch // parallel_strategy[0]
                if mbs <= 1:
                    continue
                f.write(f'echo \"{model_type}, {seq_len}: dp={parallel_strategy[0]}, tp={parallel_strategy[1]}, pp={parallel_strategy[2]}, mbs={mbs}, gbs={gbs}, num micro batch={num_micro_batch}\"\n')
                f.write(f'bash benchmark/test_padding.sh {parallel_strategy_str} {model_config_str} {seq_len} {mbs} {gbs}\n\n')


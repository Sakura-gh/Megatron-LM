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

def generate_benchmark_scripts(args):
    model_size = args.model_size
    gbs = args.gbs
    num_gpus = args.num_gpus

    assert model_size in model_configs.keys(), f'model_size {model_size} must in {list(model_configs.keys())}!'
    model_config = model_configs[model_size]
    assert str(num_gpus) in parallel_strategies.keys(), f'num_gpus {num_gpus} must in {list(parallel_strategies.keys())}!'
    parallel_strategy = parallel_strategies[str(num_gpus)]
    
    pack_types = ['packing', 'padding']
    seq_lens = [4096, 8192, 16384]
    mbs_range = [32, 16, 8, 4, 2, 1]

    script_folder = f'benchmark/scripts/gpus{num_gpus}/{model_size}'
    log_folder = f'benchmark/logs/gpus{num_gpus}/{model_size}'
    if not os.path.exists(script_folder):
        os.makedirs(script_folder)
    if not os.path.exists(log_folder):
        os.makedirs(log_folder)
    
    script_files = []
    log_files = []

    model_config_str = ' '.join(str(c) for c in model_config)
    for pack_type in pack_types:
        base_script = f'benchmark/test_{pack_type}.sh'
        for seq_len in seq_lens:
            script_file = f'{script_folder}/{seq_len//1024}k_{pack_type}_gbs{gbs}.sh'
            log_file = f'{log_folder}/{seq_len//1024}k_{pack_type}_gbs{gbs}.log'
            script_files.append(script_file)
            log_files.append(log_file)
            with open(script_file, 'w') as f:
                for used_strategy in parallel_strategy:
                    used_strategy_str = ' '.join(str(s) for s in used_strategy)
                    for mbs in mbs_range:
                        f.write(f'echo \"{model_size}, {seq_len//1024}k, gbs={gbs}: dp={used_strategy[0]}, tp={used_strategy[1]}, pp={used_strategy[2]}, mbs={mbs}\"\n')
                        f.write(f'timeout 1h bash {base_script} {used_strategy_str} {model_config_str} {seq_len} {mbs} {gbs}\n')
                        # f.write('ps -aux | grep torchrun | awk \'{print $2}\' | xargs kill -9\n')
                        # f.write('ps -aux | grep pretrain_gpt.py | awk \'{print $2}\' | xargs kill -9\n')
                        f.write('sleep 30\n\n')

                    f.write('# ---\n\n')
    
    pack_pad_script_file = f'{script_folder}/benchmark_pack_pad_gbs{gbs}.sh'
    with open(pack_pad_script_file, 'w') as f:
        for i, script_file in enumerate(script_files):
            log_file = log_files[i]
            f.write(f'bash {script_file} 2>&1 | tee {log_file}\n\n')

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--model-size', type=str, help='model_size: 3b, 7b, 13b')
    parser.add_argument('--gbs', type=int, help='global batch size')
    parser.add_argument('--num-gpus', type=int, default=8, help='num of gpus')

    # python3 benchmark/generate_benckmark_scripts.py --model-size 7b --gbs 512 --num-gpus 8
    args = parser.parse_args()
    generate_benchmark_scripts(args)
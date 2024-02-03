# Benchmark Usage

1. generate bash script for packing/padding test

~~~python
python3 benchmark/generate_benckmark_scripts.py --model-size 7b --gbs 512 --num-gpus 8
python3 benchmark/generate_benckmark_scripts.py --model-size 7b --gbs 512 --num-gpus 16
...
~~~

the scripts and logs file will auto generated under benchmark folder,

2. modify `test_packing.sh` / `test_padding.sh` for single node or multi node

2.1 dataset should be prepared

- refinedweb0.json: json format dataset
- vocab.json
- merges.txt

2.2 distribuetd config: for multi-node

~~~bash
# Change for multinode config: node 0
MASTER_ADDR=10.213.19.15
MASTER_PORT=60075
NNODES=2
NODE_RANK=0
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
~~~

~~~bash
# Change for multinode config: node 1
MASTER_ADDR=10.213.19.15
MASTER_PORT=60075
NNODES=2
NODE_RANK=1
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
~~~

3. torchrun auto-kill mechanism for multi node

create `kill.sh` for node-0 and node-1:

~~~bash
# node-0
ps -aux | grep pretrain_gpt.py | awk '{print $2}' | xargs kill -9
sleep 10
ps -aux | grep torchrun | awk '{print $2}' | xargs kill -9
echo "worker-0 kill done."
~~~

~~~bash
# node-1
ps -aux | grep pretrain_gpt.py | awk '{print $2}' | xargs kill -9
sleep 10
ps -aux | grep torchrun | awk '{print $2}' | xargs kill -9
echo "worker-1 kill done."
~~~

modify `Megatron-LM/pretrain_gpt.py`, replace the `kill.sh` path

~~~python
if __name__ == "__main__":
    try:
        pretrain(train_dataset_provider,
                model_provider,
                ModelType.encoder_or_decoder,
                forward_step,
                args_defaults={'tokenizer_type': 'GPT2BPETokenizer'})
        print_ranks(f'{statistics}', [0,1,2,3,4,5,6,7,8])
    except torch.cuda.OutOfMemoryError as e:
        rank = torch.distributed.get_rank()
        print(f'rank {rank} catch {e}')
        ### need replace here!!!
        kill_sh = '/opt/tiger/kill.sh'
        ### need replace here!!!
        os.system(f"ssh worker-1 bash {kill_sh}")
        os.system(f"bash {kill_sh}")
        raise e
~~~

4. run the script

~~~bash
tmux new -s baseline
cd Megatron-LM
bash benchmark/scripts/gpus16/7b/benchmark_pack_pad_gbs512.sh 2>&1 | tee gpus16_7b_gbs512.log
# detach
~~~
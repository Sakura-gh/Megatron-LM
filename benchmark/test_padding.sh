#!/bin/bash

# export CUDA_DEVICE_MAX_CONNECTIONS=1
# export NCCL_DEBUG=VERSION

export CUDA_DEVICE_MAX_CONNECTIONS=1
export NCCL_NVLS_ENABLE=0
export NCCL_DEBUG=WARN
export NCCL_SOCKET_IFNAME=bond0
export GLOO_SOCKET_IFNAME=bond0
export NCCL_IB_DISABLE=0
export NCCL_IB_HCA=mlx5_0,mlx5_1,mlx5_2,mlx5_5,mlx5_6,mlx5_7,mlx5_8,mlx5_11
export NCCL_NET_GDR_READ=1
export NCCL_IB_GID_INDEX=3
export NCCL_NET_GDR_LEVEL=2
export NCCL_IB_QPS_PER_CONNECTION=4
export NCCL_IB_TC=160
export NCCL_IB_TIMEOUT=22
export NCCL_PXN_DISABLE=0

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MEGATRON_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/../ && pwd )"
export PYTHONPATH=$MEGATRON_HOME:$PYTHONPATH

GPUS_PER_NODE=8 # 3d
# Change for multinode config
MASTER_ADDR=localhost
MASTER_PORT=60075
NNODES=1
NODE_RANK=0
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))

#hostfile="${MEGATRON_HOME}/two_nodes.txt"
LOCAL_IP=$(ifconfig bond0 | grep 'inet ' | awk '{print $2}' | cut -d':' -f2)
#NNODES=$(cat ${hostfile} | wc -l)
echo "LOCAL_IP = $LOCAL_IP, NODE_RANK = $NODE_RANK"
#LOCAL_RANK=$(grep -n "\b$LOCAL_IP\b" ${hostfile} | cut -d ':' -f1)
#NODE_RANK=$(($LOCAL_RANK - 1))
#WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))

#ROOT_FOLDER=/home/gehao/megatron/Megatron-LM
ROOT_FOLDER=${MEGATRON_HOME}
JSON_FILE=${ROOT_FOLDER}/data/web/refinedweb0.json
JSON_KEY=content
VOCAB_FILE=${ROOT_FOLDER}/data/vocab.json
MERGE_FILE=${ROOT_FOLDER}/data/merges.txt
DATA_PATH=${ROOT_FOLDER}/data/web/refinedweb0_content_document


DISTRIBUTED_ARGS="
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --node_rank $NODE_RANK \
    --master_addr $MASTER_ADDR \
    --master_port $MASTER_PORT \
    --max-restarts 0 --monitor-interval 5
"
# bash examples/test.sh 2 2 2 24 768 12 128 2 8 100
D_P=${1:-1}
M_P=${2:-1}
P_P=${3:-1}

echo "DP=${D_P}, MP=${M_P}, PP=${P_P}"

if [ ${D_P} -ne $(($WORLD_SIZE/$M_P/$P_P)) ]; then
  echo "DP must equal to $(($WORLD_SIZE/$M_P/$P_P))!"
  exit 1
fi

NUM_LAYERS=${4:-32}
HIDDEN_SIZE=${5:-4096}
NUM_HEADS=${6:-32}
SEQ_LEN=${7:-8192}

MICRO_BATCH_SIZE=${8:-4}
GLOBAL_BATCH_SIZE=${9:-16}
TRAIN_ITERS=${10:-100}

GPT_ARGS="
    --tensor-model-parallel-size $M_P \
    --pipeline-model-parallel-size $P_P \
    --num-layers $NUM_LAYERS \
    --hidden-size $HIDDEN_SIZE \
    --num-attention-heads $NUM_HEADS \
    --seq-length $SEQ_LEN \
    --max-position-embeddings $SEQ_LEN \
    --micro-batch-size $MICRO_BATCH_SIZE \
    --global-batch-size $GLOBAL_BATCH_SIZE \
    --lr 0.00015 \
    --train-iters $TRAIN_ITERS \
    --lr-decay-iters 320000 \
    --lr-decay-style cosine \
    --min-lr 1.0e-5 \
    --weight-decay 1e-2 \
    --lr-warmup-fraction .01 \
    --bf16 \
    --use-flash-attn \
    --use-distributed-optimizer \
    --no-masked-softmax-fusion \
    --no-bias-gelu-fusion \
    --no-bias-dropout-fusion \
    --no-gradient-accumulation-fusion \
    --no-async-tensor-model-parallel-allreduce
"
    # --no-masked-softmax-fusion \
    # --no-bias-gelu-fusion \
    # --no-bias-dropout-fusion \
    # --no-gradient-accumulation-fusion \
    # --bf16 \
    # --use-distributed-optimizer \
    # --sequence-parallel \
    # --clip-grad 1.0 \
    # --fp16

DATA_ARGS="
    --data-path $DATA_PATH \
    --json-file $JSON_FILE \
    --json-key $JSON_KEY \
    --vocab-file $VOCAB_FILE \
    --merge-file $MERGE_FILE \
    --data-impl mmap \
    --split 949,50,1
"

OUTPUT_ARGS="
    --log-interval 10 \
    --save-interval 1000 \
    --eval-interval 1000 \
    --eval-iters 10 \
    --timing-log-level 2
"

# TORCHRUN pretrain_gpt.py \
torchrun $DISTRIBUTED_ARGS pretrain_gpt.py \
    $GPT_ARGS \
    $DATA_ARGS \
    $OUTPUT_ARGS \
    --distributed-backend nccl

# LOG_FOLDER=test
# mkdir -p ${LOG_FOLDER}
# LOGFILE=${LOG_FOLDER}/megatron_lm_perf_gpt_pretrain_gpus${GPUS_PER_NODE}_dp${D_P}_mp${M_P}_pp${P_P}_mbs${MICRO_BATCH_SIZE}_gbs${GLOBAL_BATCH_SIZE}_iters${TRAIN_ITERS}.log


# echo "Writting log to ${LOGFILE}"     

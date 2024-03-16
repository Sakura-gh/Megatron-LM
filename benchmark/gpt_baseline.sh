#!/bin/bash

export NCCL_DEBUG=VERSION

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
export NCCL_SOCKET_NTHREADS=8

ROOT_FOLDER=/data/nolan/develop/bak/ht/hot_switch/gh/Megatron-LM/data
JSON_FILE=${ROOT_FOLDER}/web/refinedweb0.json
JSON_KEY=content
VOCAB_FILE=${ROOT_FOLDER}/vocab.json
MERGE_FILE=${ROOT_FOLDER}/merges.txt
DATA_PATH=${ROOT_FOLDER}/web/refinedweb0_content_document

# bash benchmark/gpt_baseline.sh 7b 4096 2 2 2 512 1 pack hostfile_49

MODEL=${1:-'7b'}
SEQ_LEN=${2:-4096}
if [ "${MODEL}" = "7b" ]; then
	NUM_LAYERS=32
	HIDDEN_SIZE=4096
	NUM_HEADS=32
elif [ "${MODEL}" = "13b" ]; then
	NUM_LAYERS=40
	HIDDEN_SIZE=5120
	NUM_HEADS=40
elif [ "${MODEL}" = "30b" ]; then
	NUM_LAYERS=60
	HIDDEN_SIZE=6672
	NUM_HEADS=48
else
	echo the model should be 7b/13b/30b for test.
	exit 0
fi

D_P=${3:-1}
M_P=${4:-1}
P_P=${5:-1}

GLOBAL_BATCH_SIZE=${6:-8}
MICRO_BATCH_SIZE=${7:-2}
PACK=${8:-'pack'}
SP=${9:-'nosp'}
HOSTFILE=${10:-'hostfile_49_50'}
TRAIN_ITERS=${11:-32}


LOCAL_IP=$(ifconfig bond0 | grep 'inet ' | awk '{print $2}' | cut -d':' -f2)
MASTER_ADDR=$(cat $HOSTFILE | head -n 1 | awk '{print $1}')
MASTER_PORT=60066

NNODES=$(cat ${HOSTFILE} | wc -l)
LOCAL_RANK=$(grep -n "\b$LOCAL_IP\b" ${HOSTFILE} | cut -d ':' -f1)
NODE_RANK=$(($LOCAL_RANK - 1))
GPUS_PER_NODE=$( cat $HOSTFILE | head -n 1 | awk -F 'slots=' '{print $2}' )
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))

echo local_ip = $LOCAL_IP, master_ip = $MASTER_ADDR, nodes_num = $NNODES, gpus_num = $WORLD_SIZE, node_rank = $NODE_RANK

echo use gpt ${MODEL} model, gpu_num=${WORLD_SIZE}, seq_len = ${SEQ_LEN}, DP=${D_P}, MP=${M_P}, PP=${P_P}, GBS=${GLOBAL_BATCH_SIZE}, MBS=${MICRO_BATCH_SIZE}

if [ ${D_P} -ne $(($WORLD_SIZE/$M_P/$P_P)) ]; then
  echo "DP must equal to $(($WORLD_SIZE/$M_P/$P_P))!"
  exit 1
fi


DISTRIBUTED_ARGS="
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --node_rank $NODE_RANK \
    --master_addr $MASTER_ADDR \
    --master_port $MASTER_PORT
"

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

if [ "${PACK}" = "pack" ]; then
echo use sequence-packing
GPT_ARGS="${GPT_ARGS} \
    --sequence-packing"
fi

if [ "${SP}" = "sp" ]; then
echo use sequence parallel
export CUDA_DEVICE_MAX_CONNECTIONS=1
GPT_ARGS="${GPT_ARGS} \
    --sequence-parallel"
fi

DATA_ARGS="
    --data-path $DATA_PATH \
    --json-file $JSON_FILE \
    --json-key $JSON_KEY \
    --vocab-file $VOCAB_FILE \
    --merge-file $MERGE_FILE \
    --split 949,50,1
"

OUTPUT_ARGS="
    --log-interval 10 \
    --save-interval 1000 \
    --eval-interval 1000 \
    --eval-iters 10 \
    --timing-log-level 2
"

LOG_FOLDER=logs/gpt
mkdir -p ${LOG_FOLDER}
LOGFILE=${LOG_FOLDER}/gpt_megatron_gpus${WORLD_SIZE}_${MODEL}_seqlen${SEQ_LEN}_gbs${GLOBAL_BATCH_SIZE}_mbs${MICRO_BATCH_SIZE}_dp${D_P}_tp${M_P}_pp${P_P}_${PACK}_${SP}_node${NODE_RANK}.log

# TORCHRUN pretrain_gpt.py \
torchrun $DISTRIBUTED_ARGS pretrain_gpt.py \
    $GPT_ARGS \
    $LLAMA_ARGS \
    $DATA_ARGS \
    $OUTPUT_ARGS \
    --distributed-backend nccl 2>&1 | tee $LOGFILE


#PWD=$( pwd )
#pdsh -R ssh -w 10.64.24.[49-50] "cd ${PWD}; torchrun ${DISTRIBUTED_ARGS} pretrain_gpt.py ${GPT_ARGS} ${LLAMA_ARGS} ${DATA_ARGS} ${OUTPUT_ARGS} --distributed-backend nccl" 2>&1 | tee $LOGFILE

echo "Writting log to ${LOGFILE}..."

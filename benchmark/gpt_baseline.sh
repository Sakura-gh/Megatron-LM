#!/bin/bash

# export CUDA_DEVICE_MAX_CONNECTIONS=1
export NCCL_DEBUG=VERSION

ROOT_FOLDER=/opt/tiger/test/data
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
	HIDDEN_SIZE=6656
	NUM_HEADS=52
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
HOSTFILE=${9:-'hostfile_49_50'}
TRAIN_ITERS=${10:-52}

local_ip=$(cat $HOSTFILE | head -n 1 | awk '{print $1}')
ip_num=$( cat $HOSTFILE | wc -l )
gpus_per_ip=$( cat $HOSTFILE | head -n 1 | awk -F 'slots=' '{print $2}' )

echo local_ip = $local_ip, ip_num = $ip_num, gpus_per_ip = $gpus_per_ip

GPUS_PER_NODE=$gpus_per_ip
# Change for multinode config
MASTER_ADDR=$local_ip
MASTER_PORT=60066
NNODES=$ip_num
NODE_RANK=0
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))

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
LOGFILE=${LOG_FOLDER}/gpt_megatron_gpus${NUM_GPUS}_${MODEL}_seqlen${SEQ_LEN}_gbs${GLOBAL_BATCH_SIZE}_mbs${MICRO_BATCH_SIZE}_dp${D_P}_tp${M_P}_pp${P_P}_${PACK}.log

# TORCHRUN pretrain_gpt.py \
torchrun $DISTRIBUTED_ARGS pretrain_gpt.py \
    $GPT_ARGS \
    $LLAMA_ARGS \
    $DATA_ARGS \
    $OUTPUT_ARGS \
    --distributed-backend nccl 2>&1 | tee $LOGFILE

echo "Writting log to ${LOGFILE}..."
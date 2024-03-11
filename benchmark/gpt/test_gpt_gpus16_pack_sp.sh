HOSTFILE=${1:-'hostfile_49_50'}

# packing, sp

# 7b

# 16k

bash benchmark/gpt_baseline.sh 7b 16384 1 8 2 512 8 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 16384 2 4 2 512 4 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 16384 1 4 4 512 8 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 16384 2 2 2 512 4 pack sp $HOSTFILE

# 8k

bash benchmark/gpt_baseline.sh 7b 8192 2 4 2 512 8 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 8192 4 2 2 512 4 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 8192 2 2 4 512 8 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 8192 2 8 1 512 8 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 8192 4 4 1 512 4 pack sp $HOSTFILE

# 4k

bash benchmark/gpt_baseline.sh 7b 4096 2 4 2 512 16 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 4096 4 2 2 512 8 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 4096 4 4 1 512 8 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 4096 2 2 4 512 16 pack sp $HOSTFILE

# 13b

# 16k

bash benchmark/gpt_baseline.sh 13b 16384 1 4 4 512 4 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 16384 2 2 4 512 2 pack sp $HOSTFILE

# 8k 

bash benchmark/gpt_baseline.sh 13b 8192 2 2 4 512 4 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 8192 2 4 2 512 2 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 8192 2 8 1 512 2 pack sp $HOSTFILE

# 4k

bash benchmark/gpt_baseline.sh 13b 4096 2 4 2 512 8 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 4096 2 2 4 512 8 pack sp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 4096 2 8 1 512 4 pack sp $HOSTFILE



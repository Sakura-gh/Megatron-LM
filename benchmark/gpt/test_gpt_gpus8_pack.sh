HOSTFILE=${1:-'hostfile_49'}

# packing

# 7b

# 16k
bash benchmark/gpt_baseline.sh 7b 16384 1 2 4 512 4 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 16384 1 2 4 512 2 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 16384 1 4 2 512 2 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 16384 1 8 1 512 2 pack nosp $HOSTFILE

# 8k

bash benchmark/gpt_baseline.sh 7b 8192 1 4 2 512 8 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 8192 1 2 4 512 8 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 8192 4 1 2 512 4 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 8192 4 1 2 512 2 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 8192 2 1 4 512 4 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 8192 2 2 2 512 2 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 8192 1 8 1 512 4 pack nosp $HOSTFILE


# 4k

bash benchmark/gpt_baseline.sh 7b 4096 1 4 2 512 16 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 4096 2 2 2 512 8 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 4096 2 4 1 512 8 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 4096 4 1 2 512 4 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 4096 4 1 2 512 2 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 7b 4096 1 4 2 512 8 pack nosp $HOSTFILE

# 13b

# 8k

bash benchmark/gpt_baseline.sh 13b 8192 1 2 4 512 2 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 8192 1 1 8 512 2 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 8192 1 4 2 512 1 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 8192 1 8 1 512 1 pack nosp $HOSTFILE

# 4k

bash benchmark/gpt_baseline.sh 13b 4096 1 2 4 512 4 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 4096 1 4 2 512 4 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 4096 1 8 1 512 4 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 4096 2 2 2 512 2 pack nosp $HOSTFILE

bash benchmark/gpt_baseline.sh 13b 4096 4 2 1 512 1 pack nosp $HOSTFILE
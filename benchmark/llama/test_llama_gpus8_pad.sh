HOSTFILE=${1:-'hostfile_51'}

# padding

# 7b

# 16k
# no-sp: oom all

# sp:
bash benchmark/llama_baseline.sh 7b 16384 2 4 1 512 1 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 16384 1 4 2 512 1 pad sp $HOSTFILE


# 8k
# no-sp
bash benchmark/llama_baseline.sh 7b 8192 2 1 4 512 1 pad nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 1 1 8 512 1 pad nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 4 2 1 512 1 pad nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 2 2 2 512 1 pad nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 1 2 4 512 1 pad nosp $HOSTFILE

# sp
bash benchmark/llama_baseline.sh 7b 8192 2 2 2 512 2 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 2 2 2 512 1 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 1 2 4 512 2 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 1 2 4 512 1 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 4 2 1 512 1 pad sp $HOSTFILE

# 4k
# no-sp
bash benchmark/llama_baseline.sh 7b 4096 4 1 2 512 1 pad nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 2 1 4 512 2 pad nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 2 2 2 512 2 pad nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 1 2 4 512 2 pad nosp $HOSTFILE

# sp
bash benchmark/llama_baseline.sh 7b 4096 4 1 2 512 2 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 4 1 2 512 1 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 2 2 2 512 4 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 2 2 2 512 2 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 1 2 4 512 4 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 1 2 4 512 2 pad sp $HOSTFILE

# 13b 

# 8k
# no-sp
bash benchmark/llama_baseline.sh 13b 8192 1 4 2 512 1 pad nosp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 8192 1 8 1 512 1 pad nosp $HOSTFILE

# sp
bash benchmark/llama_baseline.sh 13b 8192 1 2 4 512 1 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 8192 2 4 1 512 1 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 8192 1 4 2 512 1 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 8192 1 8 1 512 1 pad sp $HOSTFILE

# 4k
# no-sp
bash benchmark/llama_baseline.sh 13b 4096 1 1 8 512 1 pad nosp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 2 2 2 512 1 pad nosp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 1 2 4 512 1 pad nosp $HOSTFILE

# sp
bash benchmark/llama_baseline.sh 13b 4096 1 2 4 512 2 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 2 2 2 512 2 pad sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 2 2 2 512 1 pad sp $HOSTFILE
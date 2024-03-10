HOSTFILE=${1:-'hostfile_52'}

# packing

# 7b

# 16k
# no-sp: 
bash benchmark/llama_baseline.sh 7b 16384 1 2 4 512 2 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 16384 1 2 4 512 1 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 16384 1 4 2 512 1 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 16384 1 8 1 512 1 pack nosp $HOSTFILE

# sp:
bash benchmark/llama_baseline.sh 7b 16384 2 4 1 512 1 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 16384 1 4 2 512 1 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 16384 1 4 2 512 1 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 16384 1 8 1 512 1 pack sp $HOSTFILE


# 8k
# no-sp
bash benchmark/llama_baseline.sh 7b 8192 1 4 2 512 4 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 1 2 4 512 4 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 4 1 2 512 2 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 4 1 2 512 1 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 2 1 4 512 2 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 2 2 2 512 1 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 1 8 1 512 2 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 4 2 1 512 1 pack nosp $HOSTFILE

# sp
bash benchmark/llama_baseline.sh 7b 8192 1 4 2 512 4 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 1 2 4 512 4 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 2 2 2 512 1 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 1 8 1 512 2 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 8192 4 2 1 512 1 pack sp $HOSTFILE

# 4k
# no-sp
bash benchmark/llama_baseline.sh 7b 4096 1 4 2 512 8 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 2 2 2 512 4 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 2 4 1 512 4 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 4 1 2 512 2 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 4 1 2 512 1 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 1 4 2 512 4 pack nosp $HOSTFILE


# sp
bash benchmark/llama_baseline.sh 7b 4096 1 4 2 512 8 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 2 2 2 512 4 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 2 4 1 512 4 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 7b 4096 1 4 2 512 4 pack sp $HOSTFILE

# 13b 

# 8k
# no-sp
bash benchmark/llama_baseline.sh 13b 8192 1 2 4 512 1 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 8192 1 1 8 512 1 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 8192 1 4 2 512 1 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 8192 1 8 1 512 1 pack nosp $HOSTFILE

# sp
bash benchmark/llama_baseline.sh 13b 8192 1 2 4 512 1 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 8192 2 4 1 512 1 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 8192 1 4 2 512 1 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 8192 1 8 1 512 1 pack sp $HOSTFILE

# 4k
# no-sp
bash benchmark/llama_baseline.sh 13b 4096 1 2 4 512 2 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 1 4 2 512 2 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 1 8 1 512 2 pack nosp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 2 2 2 512 1 pack nosp $HOSTFILE

# sp
bash benchmark/llama_baseline.sh 13b 4096 1 2 4 512 2 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 1 4 2 512 2 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 1 8 1 512 2 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 2 2 2 512 2 pack sp $HOSTFILE

bash benchmark/llama_baseline.sh 13b 4096 2 2 2 512 1 pack sp $HOSTFILE
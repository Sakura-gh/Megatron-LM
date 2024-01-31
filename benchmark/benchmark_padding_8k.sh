echo "7b, 8k, gbs=512: dp=8, tp=1, pp=1, mbs=8"
bash benchmark/test_padding.sh 8 1 1 32 4096 32 8192 8 512

echo "7b, 8k, gbs=512: dp=8, tp=1, pp=1, mbs=4"
bash benchmark/test_padding.sh 8 1 1 32 4096 32 8192 4 512

echo "7b, 8k, gbs=512: dp=8, tp=1, pp=1, mbs=2"
bash benchmark/test_padding.sh 8 1 1 32 4096 32 8192 2 512

echo "7b, 8k, gbs=512: dp=8, tp=1, pp=1, mbs=1"
bash benchmark/test_padding.sh 8 1 1 32 4096 32 8192 1 512

# ---

echo "7b, 8k, gbs=512: dp=4, tp=2, pp=1, mbs=8"
bash benchmark/test_padding.sh 4 2 1 32 4096 32 8192 8 512

echo "7b, 8k, gbs=512: dp=4, tp=2, pp=1, mbs=4"
bash benchmark/test_padding.sh 4 2 1 32 4096 32 8192 4 512

echo "7b, 8k, gbs=512: dp=4, tp=2, pp=1, mbs=2"
bash benchmark/test_padding.sh 4 2 1 32 4096 32 8192 2 512

echo "7b, 8k, gbs=512: dp=4, tp=2, pp=1, mbs=1"
bash benchmark/test_padding.sh 4 2 1 32 4096 32 8192 1 512

# ---

echo "7b, 8k, gbs=512: dp=4, tp=1, pp=2, mbs=8"
bash benchmark/test_padding.sh 4 1 2 32 4096 32 8192 8 512

echo "7b, 8k, gbs=512: dp=4, tp=1, pp=2, mbs=4"
bash benchmark/test_padding.sh 4 1 2 32 4096 32 8192 4 512

echo "7b, 8k, gbs=512: dp=4, tp=1, pp=2, mbs=2"
bash benchmark/test_padding.sh 4 1 2 32 4096 32 8192 2 512

echo "7b, 8k, gbs=512: dp=4, tp=1, pp=2, mbs=1"
bash benchmark/test_padding.sh 4 1 2 32 4096 32 8192 1 512

# ---

echo "7b, 8k, gbs=512: dp=2, tp=2, pp=2, mbs=8"
bash benchmark/test_padding.sh 2 2 2 32 4096 32 8192 8 512

echo "7b, 8k, gbs=512: dp=2, tp=2, pp=2, mbs=4"
bash benchmark/test_padding.sh 2 2 2 32 4096 32 8192 4 512

echo "7b, 8k, gbs=512: dp=2, tp=2, pp=2, mbs=2"
bash benchmark/test_padding.sh 2 2 2 32 4096 32 8192 2 512

# ---

echo "7b, 8k, gbs=512: dp=2, tp=4, pp=1, mbs=16"
bash benchmark/test_padding.sh 2 4 1 32 4096 32 8192 16 512

echo "7b, 8k, gbs=512: dp=2, tp=4, pp=1, mbs=8"
bash benchmark/test_padding.sh 2 4 1 32 4096 32 8192 8 512

echo "7b, 8k, gbs=512: dp=2, tp=4, pp=1, mbs=4"
bash benchmark/test_padding.sh 2 4 1 32 4096 32 8192 4 512

echo "7b, 8k, gbs=512: dp=2, tp=4, pp=1, mbs=2"
bash benchmark/test_padding.sh 2 4 1 32 4096 32 8192 2 512

# ---

echo "7b, 8k, gbs=512: dp=2, tp=1, pp=4, mbs=16"
bash benchmark/test_padding.sh 2 1 4 32 4096 32 8192 16 512

echo "7b, 8k, gbs=512: dp=2, tp=1, pp=4, mbs=8"
bash benchmark/test_padding.sh 2 1 4 32 4096 32 8192 8 512

echo "7b, 8k, gbs=512: dp=2, tp=1, pp=4, mbs=4"
bash benchmark/test_padding.sh 2 1 4 32 4096 32 8192 4 512

echo "7b, 8k, gbs=512: dp=2, tp=1, pp=4, mbs=2"
bash benchmark/test_padding.sh 2 1 4 32 4096 32 8192 2 512

# --- 

echo "7b, 8k, gbs=512: dp=1, tp=4, pp=2, mbs=32"
bash benchmark/test_padding.sh 1 4 2 32 4096 32 8192 32 512

echo "7b, 8k, gbs=512: dp=1, tp=4, pp=2, mbs=16"
bash benchmark/test_padding.sh 1 4 2 32 4096 32 8192 16 512

echo "7b, 8k, gbs=512: dp=1, tp=4, pp=2, mbs=8"
bash benchmark/test_padding.sh 1 4 2 32 4096 32 8192 8 512

echo "7b, 8k, gbs=512: dp=1, tp=4, pp=2, mbs=4"
bash benchmark/test_padding.sh 1 4 2 32 4096 32 8192 4 512

echo "7b, 8k, gbs=512: dp=1, tp=4, pp=2, mbs=2"
bash benchmark/test_padding.sh 1 4 2 32 4096 32 8192 2 512

# --- 

echo "7b, 8k, gbs=512: dp=1, tp=2, pp=4, mbs=32"
bash benchmark/test_padding.sh 1 2 4 32 4096 32 8192 32 512

echo "7b, 8k, gbs=512: dp=1, tp=2, pp=4, mbs=16"
bash benchmark/test_padding.sh 1 2 4 32 4096 32 8192 16 512

echo "7b, 8k, gbs=512: dp=1, tp=2, pp=4, mbs=8"
bash benchmark/test_padding.sh 1 2 4 32 4096 32 8192 8 512

echo "7b, 8k, gbs=512: dp=1, tp=2, pp=4, mbs=4"
bash benchmark/test_padding.sh 1 2 4 32 4096 32 8192 4 512

echo "7b, 8k, gbs=512: dp=1, tp=2, pp=4, mbs=2"
bash benchmark/test_padding.sh 1 2 4 32 4096 32 8192 2 512

# ---

echo "7b, 8k, gbs=512: dp=1, tp=8, pp=1, mbs=32"
bash benchmark/test_padding.sh 1 8 1 32 4096 32 8192 32 512

echo "7b, 8k, gbs=512: dp=1, tp=8, pp=1, mbs=16"
bash benchmark/test_padding.sh 1 8 1 32 4096 32 8192 16 512

echo "7b, 8k, gbs=512: dp=1, tp=8, pp=1, mbs=8"
bash benchmark/test_padding.sh 1 8 1 32 4096 32 8192 8 512

echo "7b, 8k, gbs=512: dp=1, tp=8, pp=1, mbs=4"
bash benchmark/test_padding.sh 1 8 1 32 4096 32 8192 4 512

echo "7b, 8k, gbs=512: dp=1, tp=8, pp=1, mbs=2"
bash benchmark/test_padding.sh 1 8 1 32 4096 32 8192 2 512

# --- 

echo "7b, 8k, gbs=512: dp=1, tp=1, pp=8, mbs=32"
bash benchmark/test_padding.sh 1 1 8 32 4096 32 8192 32 512

echo "7b, 8k, gbs=512: dp=1, tp=1, pp=8, mbs=16"
bash benchmark/test_padding.sh 1 1 8 32 4096 32 8192 16 512

echo "7b, 8k, gbs=512: dp=1, tp=1, pp=8, mbs=8"
bash benchmark/test_padding.sh 1 1 8 32 4096 32 8192 8 512

echo "7b, 8k, gbs=512: dp=1, tp=1, pp=8, mbs=4"
bash benchmark/test_padding.sh 1 1 8 32 4096 32 8192 4 512

echo "7b, 8k, gbs=512: dp=1, tp=1, pp=8, mbs=2"
bash benchmark/test_padding.sh 1 1 8 32 4096 32 8192 2 512

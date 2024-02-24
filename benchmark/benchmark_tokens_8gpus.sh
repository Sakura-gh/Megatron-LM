
# 7b, 512
echo "7b, 512: dp=8, tp=1, pp=1, mbs=16, gbs=256, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 512 16 256

echo "7b, 512: dp=8, tp=1, pp=1, mbs=8, gbs=256, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 512 8 256

echo "7b, 512: dp=8, tp=1, pp=1, mbs=4, gbs=256, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 512 4 256

echo "7b, 512: dp=8, tp=1, pp=1, mbs=2, gbs=256, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 512 2 256

echo "7b, 512: dp=4, tp=2, pp=1, mbs=32, gbs=256, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 512 32 256

echo "7b, 512: dp=4, tp=2, pp=1, mbs=16, gbs=256, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 512 16 256

echo "7b, 512: dp=4, tp=2, pp=1, mbs=8, gbs=256, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 512 8 256

echo "7b, 512: dp=4, tp=2, pp=1, mbs=4, gbs=256, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 512 4 256

echo "7b, 512: dp=4, tp=1, pp=2, mbs=32, gbs=256, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 512 32 256

echo "7b, 512: dp=4, tp=1, pp=2, mbs=16, gbs=256, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 512 16 256

echo "7b, 512: dp=4, tp=1, pp=2, mbs=8, gbs=256, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 512 8 256

echo "7b, 512: dp=4, tp=1, pp=2, mbs=4, gbs=256, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 512 4 256

echo "7b, 512: dp=2, tp=2, pp=2, mbs=64, gbs=256, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 512 64 256

echo "7b, 512: dp=2, tp=2, pp=2, mbs=32, gbs=256, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 512 32 256

echo "7b, 512: dp=2, tp=2, pp=2, mbs=16, gbs=256, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 512 16 256

echo "7b, 512: dp=2, tp=2, pp=2, mbs=8, gbs=256, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 512 8 256

echo "7b, 512: dp=2, tp=4, pp=1, mbs=64, gbs=256, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 512 64 256

echo "7b, 512: dp=2, tp=4, pp=1, mbs=32, gbs=256, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 512 32 256

echo "7b, 512: dp=2, tp=4, pp=1, mbs=16, gbs=256, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 512 16 256

echo "7b, 512: dp=2, tp=4, pp=1, mbs=8, gbs=256, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 512 8 256

echo "7b, 512: dp=2, tp=1, pp=4, mbs=64, gbs=256, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 512 64 256

echo "7b, 512: dp=2, tp=1, pp=4, mbs=32, gbs=256, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 512 32 256

echo "7b, 512: dp=2, tp=1, pp=4, mbs=16, gbs=256, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 512 16 256

echo "7b, 512: dp=2, tp=1, pp=4, mbs=8, gbs=256, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 512 8 256

echo "7b, 512: dp=1, tp=4, pp=2, mbs=128, gbs=256, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 512 128 256

echo "7b, 512: dp=1, tp=4, pp=2, mbs=64, gbs=256, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 512 64 256

echo "7b, 512: dp=1, tp=4, pp=2, mbs=32, gbs=256, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 512 32 256

echo "7b, 512: dp=1, tp=4, pp=2, mbs=16, gbs=256, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 512 16 256

echo "7b, 512: dp=1, tp=2, pp=4, mbs=128, gbs=256, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 512 128 256

echo "7b, 512: dp=1, tp=2, pp=4, mbs=64, gbs=256, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 512 64 256

echo "7b, 512: dp=1, tp=2, pp=4, mbs=32, gbs=256, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 512 32 256

echo "7b, 512: dp=1, tp=2, pp=4, mbs=16, gbs=256, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 512 16 256

echo "7b, 512: dp=1, tp=8, pp=1, mbs=128, gbs=256, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 512 128 256

echo "7b, 512: dp=1, tp=8, pp=1, mbs=64, gbs=256, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 512 64 256

echo "7b, 512: dp=1, tp=8, pp=1, mbs=32, gbs=256, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 512 32 256

echo "7b, 512: dp=1, tp=8, pp=1, mbs=16, gbs=256, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 512 16 256

echo "7b, 512: dp=1, tp=1, pp=8, mbs=128, gbs=256, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 512 128 256

echo "7b, 512: dp=1, tp=1, pp=8, mbs=64, gbs=256, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 512 64 256

echo "7b, 512: dp=1, tp=1, pp=8, mbs=32, gbs=256, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 512 32 256

echo "7b, 512: dp=1, tp=1, pp=8, mbs=16, gbs=256, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 512 16 256

# 7b, 1024
echo "7b, 1024: dp=8, tp=1, pp=1, mbs=8, gbs=128, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 1024 8 128

echo "7b, 1024: dp=8, tp=1, pp=1, mbs=4, gbs=128, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 1024 4 128

echo "7b, 1024: dp=8, tp=1, pp=1, mbs=2, gbs=128, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 1024 2 128

echo "7b, 1024: dp=8, tp=1, pp=1, mbs=1, gbs=128, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 1024 1 128

echo "7b, 1024: dp=4, tp=2, pp=1, mbs=16, gbs=128, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 1024 16 128

echo "7b, 1024: dp=4, tp=2, pp=1, mbs=8, gbs=128, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 1024 8 128

echo "7b, 1024: dp=4, tp=2, pp=1, mbs=4, gbs=128, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 1024 4 128

echo "7b, 1024: dp=4, tp=2, pp=1, mbs=2, gbs=128, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 1024 2 128

echo "7b, 1024: dp=4, tp=1, pp=2, mbs=16, gbs=128, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 1024 16 128

echo "7b, 1024: dp=4, tp=1, pp=2, mbs=8, gbs=128, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 1024 8 128

echo "7b, 1024: dp=4, tp=1, pp=2, mbs=4, gbs=128, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 1024 4 128

echo "7b, 1024: dp=4, tp=1, pp=2, mbs=2, gbs=128, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 1024 2 128

echo "7b, 1024: dp=2, tp=2, pp=2, mbs=32, gbs=128, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 1024 32 128

echo "7b, 1024: dp=2, tp=2, pp=2, mbs=16, gbs=128, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 1024 16 128

echo "7b, 1024: dp=2, tp=2, pp=2, mbs=8, gbs=128, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 1024 8 128

echo "7b, 1024: dp=2, tp=2, pp=2, mbs=4, gbs=128, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 1024 4 128

echo "7b, 1024: dp=2, tp=4, pp=1, mbs=32, gbs=128, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 1024 32 128

echo "7b, 1024: dp=2, tp=4, pp=1, mbs=16, gbs=128, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 1024 16 128

echo "7b, 1024: dp=2, tp=4, pp=1, mbs=8, gbs=128, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 1024 8 128

echo "7b, 1024: dp=2, tp=4, pp=1, mbs=4, gbs=128, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 1024 4 128

echo "7b, 1024: dp=2, tp=1, pp=4, mbs=32, gbs=128, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 1024 32 128

echo "7b, 1024: dp=2, tp=1, pp=4, mbs=16, gbs=128, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 1024 16 128

echo "7b, 1024: dp=2, tp=1, pp=4, mbs=8, gbs=128, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 1024 8 128

echo "7b, 1024: dp=2, tp=1, pp=4, mbs=4, gbs=128, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 1024 4 128

echo "7b, 1024: dp=1, tp=4, pp=2, mbs=64, gbs=128, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 1024 64 128

echo "7b, 1024: dp=1, tp=4, pp=2, mbs=32, gbs=128, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 1024 32 128

echo "7b, 1024: dp=1, tp=4, pp=2, mbs=16, gbs=128, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 1024 16 128

echo "7b, 1024: dp=1, tp=4, pp=2, mbs=8, gbs=128, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 1024 8 128

echo "7b, 1024: dp=1, tp=2, pp=4, mbs=64, gbs=128, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 1024 64 128

echo "7b, 1024: dp=1, tp=2, pp=4, mbs=32, gbs=128, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 1024 32 128

echo "7b, 1024: dp=1, tp=2, pp=4, mbs=16, gbs=128, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 1024 16 128

echo "7b, 1024: dp=1, tp=2, pp=4, mbs=8, gbs=128, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 1024 8 128

echo "7b, 1024: dp=1, tp=8, pp=1, mbs=64, gbs=128, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 1024 64 128

echo "7b, 1024: dp=1, tp=8, pp=1, mbs=32, gbs=128, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 1024 32 128

echo "7b, 1024: dp=1, tp=8, pp=1, mbs=16, gbs=128, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 1024 16 128

echo "7b, 1024: dp=1, tp=8, pp=1, mbs=8, gbs=128, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 1024 8 128

echo "7b, 1024: dp=1, tp=1, pp=8, mbs=64, gbs=128, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 1024 64 128

echo "7b, 1024: dp=1, tp=1, pp=8, mbs=32, gbs=128, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 1024 32 128

echo "7b, 1024: dp=1, tp=1, pp=8, mbs=16, gbs=128, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 1024 16 128

echo "7b, 1024: dp=1, tp=1, pp=8, mbs=8, gbs=128, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 1024 8 128

# 7b, 2048
echo "7b, 2048: dp=8, tp=1, pp=1, mbs=4, gbs=64, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 2048 4 64

echo "7b, 2048: dp=8, tp=1, pp=1, mbs=2, gbs=64, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 2048 2 64

echo "7b, 2048: dp=8, tp=1, pp=1, mbs=1, gbs=64, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 2048 1 64

echo "7b, 2048: dp=4, tp=2, pp=1, mbs=8, gbs=64, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 2048 8 64

echo "7b, 2048: dp=4, tp=2, pp=1, mbs=4, gbs=64, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 2048 4 64

echo "7b, 2048: dp=4, tp=2, pp=1, mbs=2, gbs=64, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 2048 2 64

echo "7b, 2048: dp=4, tp=2, pp=1, mbs=1, gbs=64, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 2048 1 64

echo "7b, 2048: dp=4, tp=1, pp=2, mbs=8, gbs=64, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 2048 8 64

echo "7b, 2048: dp=4, tp=1, pp=2, mbs=4, gbs=64, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 2048 4 64

echo "7b, 2048: dp=4, tp=1, pp=2, mbs=2, gbs=64, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 2048 2 64

echo "7b, 2048: dp=4, tp=1, pp=2, mbs=1, gbs=64, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 2048 1 64

echo "7b, 2048: dp=2, tp=2, pp=2, mbs=16, gbs=64, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 2048 16 64

echo "7b, 2048: dp=2, tp=2, pp=2, mbs=8, gbs=64, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 2048 8 64

echo "7b, 2048: dp=2, tp=2, pp=2, mbs=4, gbs=64, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 2048 4 64

echo "7b, 2048: dp=2, tp=2, pp=2, mbs=2, gbs=64, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 2048 2 64

echo "7b, 2048: dp=2, tp=4, pp=1, mbs=16, gbs=64, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 2048 16 64

echo "7b, 2048: dp=2, tp=4, pp=1, mbs=8, gbs=64, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 2048 8 64

echo "7b, 2048: dp=2, tp=4, pp=1, mbs=4, gbs=64, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 2048 4 64

echo "7b, 2048: dp=2, tp=4, pp=1, mbs=2, gbs=64, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 2048 2 64

echo "7b, 2048: dp=2, tp=1, pp=4, mbs=16, gbs=64, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 2048 16 64

echo "7b, 2048: dp=2, tp=1, pp=4, mbs=8, gbs=64, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 2048 8 64

echo "7b, 2048: dp=2, tp=1, pp=4, mbs=4, gbs=64, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 2048 4 64

echo "7b, 2048: dp=2, tp=1, pp=4, mbs=2, gbs=64, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 2048 2 64

echo "7b, 2048: dp=1, tp=4, pp=2, mbs=32, gbs=64, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 2048 32 64

echo "7b, 2048: dp=1, tp=4, pp=2, mbs=16, gbs=64, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 2048 16 64

echo "7b, 2048: dp=1, tp=4, pp=2, mbs=8, gbs=64, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 2048 8 64

echo "7b, 2048: dp=1, tp=4, pp=2, mbs=4, gbs=64, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 2048 4 64

echo "7b, 2048: dp=1, tp=2, pp=4, mbs=32, gbs=64, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 2048 32 64

echo "7b, 2048: dp=1, tp=2, pp=4, mbs=16, gbs=64, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 2048 16 64

echo "7b, 2048: dp=1, tp=2, pp=4, mbs=8, gbs=64, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 2048 8 64

echo "7b, 2048: dp=1, tp=2, pp=4, mbs=4, gbs=64, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 2048 4 64

echo "7b, 2048: dp=1, tp=8, pp=1, mbs=32, gbs=64, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 2048 32 64

echo "7b, 2048: dp=1, tp=8, pp=1, mbs=16, gbs=64, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 2048 16 64

echo "7b, 2048: dp=1, tp=8, pp=1, mbs=8, gbs=64, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 2048 8 64

echo "7b, 2048: dp=1, tp=8, pp=1, mbs=4, gbs=64, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 2048 4 64

echo "7b, 2048: dp=1, tp=1, pp=8, mbs=32, gbs=64, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 2048 32 64

echo "7b, 2048: dp=1, tp=1, pp=8, mbs=16, gbs=64, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 2048 16 64

echo "7b, 2048: dp=1, tp=1, pp=8, mbs=8, gbs=64, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 2048 8 64

echo "7b, 2048: dp=1, tp=1, pp=8, mbs=4, gbs=64, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 2048 4 64

# 7b, 4096
echo "7b, 4096: dp=8, tp=1, pp=1, mbs=2, gbs=32, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 4096 2 32

echo "7b, 4096: dp=8, tp=1, pp=1, mbs=1, gbs=32, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 4096 1 32

echo "7b, 4096: dp=4, tp=2, pp=1, mbs=4, gbs=32, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 4096 4 32

echo "7b, 4096: dp=4, tp=2, pp=1, mbs=2, gbs=32, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 4096 2 32

echo "7b, 4096: dp=4, tp=2, pp=1, mbs=1, gbs=32, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 4096 1 32

echo "7b, 4096: dp=4, tp=1, pp=2, mbs=4, gbs=32, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 4096 4 32

echo "7b, 4096: dp=4, tp=1, pp=2, mbs=2, gbs=32, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 4096 2 32

echo "7b, 4096: dp=4, tp=1, pp=2, mbs=1, gbs=32, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 4096 1 32

echo "7b, 4096: dp=2, tp=2, pp=2, mbs=8, gbs=32, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 4096 8 32

echo "7b, 4096: dp=2, tp=2, pp=2, mbs=4, gbs=32, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 4096 4 32

echo "7b, 4096: dp=2, tp=2, pp=2, mbs=2, gbs=32, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 4096 2 32

echo "7b, 4096: dp=2, tp=2, pp=2, mbs=1, gbs=32, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 4096 1 32

echo "7b, 4096: dp=2, tp=4, pp=1, mbs=8, gbs=32, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 4096 8 32

echo "7b, 4096: dp=2, tp=4, pp=1, mbs=4, gbs=32, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 4096 4 32

echo "7b, 4096: dp=2, tp=4, pp=1, mbs=2, gbs=32, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 4096 2 32

echo "7b, 4096: dp=2, tp=4, pp=1, mbs=1, gbs=32, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 4096 1 32

echo "7b, 4096: dp=2, tp=1, pp=4, mbs=8, gbs=32, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 4096 8 32

echo "7b, 4096: dp=2, tp=1, pp=4, mbs=4, gbs=32, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 4096 4 32

echo "7b, 4096: dp=2, tp=1, pp=4, mbs=2, gbs=32, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 4096 2 32

echo "7b, 4096: dp=2, tp=1, pp=4, mbs=1, gbs=32, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 4096 1 32

echo "7b, 4096: dp=1, tp=4, pp=2, mbs=16, gbs=32, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 4096 16 32

echo "7b, 4096: dp=1, tp=4, pp=2, mbs=8, gbs=32, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 4096 8 32

echo "7b, 4096: dp=1, tp=4, pp=2, mbs=4, gbs=32, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 4096 4 32

echo "7b, 4096: dp=1, tp=4, pp=2, mbs=2, gbs=32, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 4096 2 32

echo "7b, 4096: dp=1, tp=2, pp=4, mbs=16, gbs=32, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 4096 16 32

echo "7b, 4096: dp=1, tp=2, pp=4, mbs=8, gbs=32, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 4096 8 32

echo "7b, 4096: dp=1, tp=2, pp=4, mbs=4, gbs=32, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 4096 4 32

echo "7b, 4096: dp=1, tp=2, pp=4, mbs=2, gbs=32, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 4096 2 32

echo "7b, 4096: dp=1, tp=8, pp=1, mbs=16, gbs=32, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 4096 16 32

echo "7b, 4096: dp=1, tp=8, pp=1, mbs=8, gbs=32, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 4096 8 32

echo "7b, 4096: dp=1, tp=8, pp=1, mbs=4, gbs=32, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 4096 4 32

echo "7b, 4096: dp=1, tp=8, pp=1, mbs=2, gbs=32, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 4096 2 32

echo "7b, 4096: dp=1, tp=1, pp=8, mbs=16, gbs=32, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 4096 16 32

echo "7b, 4096: dp=1, tp=1, pp=8, mbs=8, gbs=32, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 4096 8 32

echo "7b, 4096: dp=1, tp=1, pp=8, mbs=4, gbs=32, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 4096 4 32

echo "7b, 4096: dp=1, tp=1, pp=8, mbs=2, gbs=32, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 4096 2 32

# 7b, 8192
echo "7b, 8192: dp=8, tp=1, pp=1, mbs=1, gbs=16, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 8 1 1 32 4096 32 8192 1 16

echo "7b, 8192: dp=4, tp=2, pp=1, mbs=2, gbs=16, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 8192 2 16

echo "7b, 8192: dp=4, tp=2, pp=1, mbs=1, gbs=16, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 8192 1 16

echo "7b, 8192: dp=4, tp=1, pp=2, mbs=2, gbs=16, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 8192 2 16

echo "7b, 8192: dp=4, tp=1, pp=2, mbs=1, gbs=16, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 8192 1 16

echo "7b, 8192: dp=2, tp=2, pp=2, mbs=4, gbs=16, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 8192 4 16

echo "7b, 8192: dp=2, tp=2, pp=2, mbs=2, gbs=16, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 8192 2 16

echo "7b, 8192: dp=2, tp=2, pp=2, mbs=1, gbs=16, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 8192 1 16

echo "7b, 8192: dp=2, tp=4, pp=1, mbs=4, gbs=16, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 8192 4 16

echo "7b, 8192: dp=2, tp=4, pp=1, mbs=2, gbs=16, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 8192 2 16

echo "7b, 8192: dp=2, tp=4, pp=1, mbs=1, gbs=16, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 8192 1 16

echo "7b, 8192: dp=2, tp=1, pp=4, mbs=4, gbs=16, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 8192 4 16

echo "7b, 8192: dp=2, tp=1, pp=4, mbs=2, gbs=16, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 8192 2 16

echo "7b, 8192: dp=2, tp=1, pp=4, mbs=1, gbs=16, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 8192 1 16

echo "7b, 8192: dp=1, tp=4, pp=2, mbs=8, gbs=16, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 8192 8 16

echo "7b, 8192: dp=1, tp=4, pp=2, mbs=4, gbs=16, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 8192 4 16

echo "7b, 8192: dp=1, tp=4, pp=2, mbs=2, gbs=16, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 8192 2 16

echo "7b, 8192: dp=1, tp=4, pp=2, mbs=1, gbs=16, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 8192 1 16

echo "7b, 8192: dp=1, tp=2, pp=4, mbs=8, gbs=16, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 8192 8 16

echo "7b, 8192: dp=1, tp=2, pp=4, mbs=4, gbs=16, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 8192 4 16

echo "7b, 8192: dp=1, tp=2, pp=4, mbs=2, gbs=16, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 8192 2 16

echo "7b, 8192: dp=1, tp=2, pp=4, mbs=1, gbs=16, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 8192 1 16

echo "7b, 8192: dp=1, tp=8, pp=1, mbs=8, gbs=16, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 8192 8 16

echo "7b, 8192: dp=1, tp=8, pp=1, mbs=4, gbs=16, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 8192 4 16

echo "7b, 8192: dp=1, tp=8, pp=1, mbs=2, gbs=16, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 8192 2 16

echo "7b, 8192: dp=1, tp=8, pp=1, mbs=1, gbs=16, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 8192 1 16

echo "7b, 8192: dp=1, tp=1, pp=8, mbs=8, gbs=16, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 8192 8 16

echo "7b, 8192: dp=1, tp=1, pp=8, mbs=4, gbs=16, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 8192 4 16

echo "7b, 8192: dp=1, tp=1, pp=8, mbs=2, gbs=16, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 8192 2 16

echo "7b, 8192: dp=1, tp=1, pp=8, mbs=1, gbs=16, num micro batch=16"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 8192 1 16

# 7b, 16384
echo "7b, 16384: dp=4, tp=2, pp=1, mbs=1, gbs=8, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 2 1 32 4096 32 16384 1 8

echo "7b, 16384: dp=4, tp=1, pp=2, mbs=1, gbs=8, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 4 1 2 32 4096 32 16384 1 8

echo "7b, 16384: dp=2, tp=2, pp=2, mbs=2, gbs=8, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 16384 2 8

echo "7b, 16384: dp=2, tp=2, pp=2, mbs=1, gbs=8, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 2 2 32 4096 32 16384 1 8

echo "7b, 16384: dp=2, tp=4, pp=1, mbs=2, gbs=8, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 16384 2 8

echo "7b, 16384: dp=2, tp=4, pp=1, mbs=1, gbs=8, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 4 1 32 4096 32 16384 1 8

echo "7b, 16384: dp=2, tp=1, pp=4, mbs=2, gbs=8, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 16384 2 8

echo "7b, 16384: dp=2, tp=1, pp=4, mbs=1, gbs=8, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 2 1 4 32 4096 32 16384 1 8

echo "7b, 16384: dp=1, tp=4, pp=2, mbs=4, gbs=8, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 16384 4 8

echo "7b, 16384: dp=1, tp=4, pp=2, mbs=2, gbs=8, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 16384 2 8

echo "7b, 16384: dp=1, tp=4, pp=2, mbs=1, gbs=8, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 4 2 32 4096 32 16384 1 8

echo "7b, 16384: dp=1, tp=2, pp=4, mbs=4, gbs=8, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 16384 4 8

echo "7b, 16384: dp=1, tp=2, pp=4, mbs=2, gbs=8, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 16384 2 8

echo "7b, 16384: dp=1, tp=2, pp=4, mbs=1, gbs=8, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 2 4 32 4096 32 16384 1 8

echo "7b, 16384: dp=1, tp=8, pp=1, mbs=4, gbs=8, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 16384 4 8

echo "7b, 16384: dp=1, tp=8, pp=1, mbs=2, gbs=8, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 16384 2 8

echo "7b, 16384: dp=1, tp=8, pp=1, mbs=1, gbs=8, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 8 1 32 4096 32 16384 1 8

echo "7b, 16384: dp=1, tp=1, pp=8, mbs=4, gbs=8, num micro batch=2"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 16384 4 8

echo "7b, 16384: dp=1, tp=1, pp=8, mbs=2, gbs=8, num micro batch=4"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 16384 2 8

echo "7b, 16384: dp=1, tp=1, pp=8, mbs=1, gbs=8, num micro batch=8"
timeout 20m bash benchmark/test_padding.sh 1 1 8 32 4096 32 16384 1 8



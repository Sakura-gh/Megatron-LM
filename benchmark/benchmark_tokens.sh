# 7b, 512
echo "7b, 512: dp16, mbs=8, gbs=256, num micro batch=2"
bash examples/test.sh 16 1 1 32 4096 32 512 8 256

echo "7b, 512: dp8, tp2, mbs=16, gbs=256, num micro batch=2"
bash examples/test.sh 8 2 1 32 4096 32 512 16 256

echo "7b, 512: dp8, tp2, mbs=8, gbs=256, num micro batch=4"
bash examples/test.sh 8 2 1 32 4096 32 512 8 256

echo "7b, 512: dp8, pp2, mbs=16, gbs=256, num micro batch=2"
bash examples/test.sh 8 1 2 32 4096 32 512 16 256

echo "7b, 512: dp8, pp2, mbs=8, gbs=256, num micro batch=4"
bash examples/test.sh 8 1 2 32 4096 32 512 8 256

echo "7b, 512: dp8, pp2, mbs=4, gbs=256, num micro batch=8"
bash examples/test.sh 8 1 2 32 4096 32 512 4 256

echo "7b, 512: dp8, pp2, mbs=2, gbs=256, num micro batch=8"
bash examples/test.sh 8 1 2 32 4096 32 512 2 256

echo "7b, 512: dp4, tp4, mbs=32, gbs=256, num micro batch=2"
bash examples/test.sh 4 4 1 32 4096 32 512 32 256

echo "7b, 512: dp4, tp4, mbs=16, gbs=256, num micro batch=4"
bash examples/test.sh 4 4 1 32 4096 32 512 16 256

echo "7b, 512: dp4, tp2, pp2, mbs=32, gbs=256, num micro batch=2"
bash examples/test.sh 4 2 2 32 4096 32 512 32 256

echo "7b, 512: dp4, tp2, pp2, mbs=16, gbs=256, num micro batch=4"
bash examples/test.sh 4 2 2 32 4096 32 512 16 256

echo "7b, 512: dp4, tp2, pp2, mbs=8, gbs=256, num micro batch=8"
bash examples/test.sh 4 2 2 32 4096 32 512 8 256

echo "7b, 512: dp4, tp2, pp2, mbs=4, gbs=256, num micro batch=8"
bash examples/test.sh 4 2 2 32 4096 32 512 4 256

# 7b, 1k
echo "7b, 1k: dp16, mbs=4, gbs=128, num micro batch=2"
bash examples/test.sh 16 1 1 32 4096 32 1024 4 128

echo "7b, 1k: dp8, tp2, mbs=8, gbs=128, num micro batch=2"
bash examples/test.sh 8 2 1 32 4096 32 1024 8 128

echo "7b, 1k: dp8, tp2, mbs=4, gbs=128, num micro batch=4"
bash examples/test.sh 8 2 1 32 4096 32 1024 4 128

echo "7b, 1k: dp8, pp2, mbs=8, gbs=128, num micro batch=2"
bash examples/test.sh 8 1 2 32 4096 32 1024 8 128

echo "7b, 1k: dp8, pp2, mbs=4, gbs=128, num micro batch=4"
bash examples/test.sh 8 1 2 32 4096 32 1024 4 128

echo "7b, 1k: dp8, pp2, mbs=2, gbs=128, num micro batch=8"
bash examples/test.sh 8 1 2 32 4096 32 1024 2 128

echo "7b, 1k: dp4, tp4, mbs=16, gbs=128, num micro batch=2"
bash examples/test.sh 4 4 1 32 4096 32 1024 16 128

echo "7b, 1k: dp4, tp4, mbs=8, gbs=128, num micro batch=4"
bash examples/test.sh 4 4 1 32 4096 32 1024 8 128

echo "7b, 1k: dp4, tp2, pp2, mbs=16, gbs=128, num micro batch=2"
bash examples/test.sh 4 2 2 32 4096 32 1024 16 128

echo "7b, 1k: dp4, tp2, pp2, mbs=8, gbs=128, num micro batch=4"
bash examples/test.sh 4 2 2 32 4096 32 1024 8 128

echo "7b, 1k: dp4, tp2, pp2, mbs=4, gbs=128, num micro batch=8"
bash examples/test.sh 4 2 2 32 4096 32 1024 4 128

echo "7b, 1k: dp4, tp2, pp2, mbs=2, gbs=128, num micro batch=8"
bash examples/test.sh 4 2 2 32 4096 32 1024 2 128

# 7b, 2k
echo "7b, 2k: dp16, mbs=2, gbs=64, num micro batch=2"
bash examples/test.sh 16 1 1 32 4096 32 2048 2 64

echo "7b, 2k: dp8, tp2, mbs=4, gbs=64, num micro batch=2"
bash examples/test.sh 8 2 1 32 4096 32 2048 4 64

echo "7b, 2k: dp8, tp2, mbs=2, gbs=64, num micro batch=4"
bash examples/test.sh 8 2 1 32 4096 32 2048 2 64

echo "7b, 2k: dp8, pp2, mbs=4, gbs=64, num micro batch=2"
bash examples/test.sh 8 1 2 32 4096 32 2048 4 64

echo "7b, 2k: dp8, pp2, mbs=2, gbs=64, num micro batch=4"
bash examples/test.sh 8 1 2 32 4096 32 2048 2 64

echo "7b, 2k: dp4, tp4, mbs=8, gbs=64, num micro batch=2"
bash examples/test.sh 4 4 1 32 4096 32 2048 8 64

echo "7b, 2k: dp4, tp4, mbs=4, gbs=64, num micro batch=4"
bash examples/test.sh 4 4 1 32 4096 32 2048 4 64

echo "7b, 2k: dp4, tp2, pp2, mbs=8, gbs=64, num micro batch=2"
bash examples/test.sh 4 2 2 32 4096 32 2048 8 64

echo "7b, 2k: dp4, tp2, pp2, mbs=4, gbs=64, num micro batch=4"
bash examples/test.sh 4 2 2 32 4096 32 2048 4 64

echo "7b, 2k: dp4, tp2, pp2, mbs=2, gbs=64, num micro batch=8"
bash examples/test.sh 4 2 2 32 4096 32 2048 2 64

# 7b, 4k
echo "7b, 4k: dp16, mbs=1, gbs=32, num micro batch=2"
bash examples/test.sh 16 1 1 32 4096 32 4096 1 32

echo "7b, 4k: dp8, tp2, mbs=2, gbs=32, num micro batch=2"
bash examples/test.sh 8 2 1 32 4096 32 4096 2 32

echo "7b, 4k: dp8, tp2, mbs=1, gbs=32, num micro batch=4"
bash examples/test.sh 8 2 1 32 4096 32 4096 1 32

echo "7b, 4k: dp8, pp2, mbs=2, gbs=32, num micro batch=2"
bash examples/test.sh 8 1 2 32 4096 32 4096 2 32

echo "7b, 4k: dp8, pp2, mbs=1, gbs=32, num micro batch=4"
bash examples/test.sh 8 1 2 32 4096 32 4096 1 32

echo "7b, 4k: dp4, tp4, mbs=4, gbs=32, num micro batch=2"
bash examples/test.sh 4 4 1 32 4096 32 4096 4 32

echo "7b, 4k: dp4, tp4, mbs=2, gbs=32, num micro batch=4"
bash examples/test.sh 4 4 1 32 4096 32 4096 2 32

echo "7b, 4k: dp4, tp2, pp2, mbs=4, gbs=32, num micro batch=2"
bash examples/test.sh 4 2 2 32 4096 32 4096 4 32

echo "7b, 4k: dp4, tp2, pp2, mbs=2, gbs=32, num micro batch=4"
bash examples/test.sh 4 2 2 32 4096 32 4096 2 32

echo "7b, 4k: dp4, tp2, pp2, mbs=1, gbs=32, num micro batch=8"
bash examples/test.sh 4 2 2 32 4096 32 4096 1 32

# 7b, 8k
echo "7b, 8k: dp8, tp2, mbs=1, gbs=16, num micro batch=2"
bash examples/test.sh 8 2 1 32 4096 32 8192 1 16

echo "7b, 8k: dp8, pp2, mbs=1, gbs=16, num micro batch=2"
bash examples/test.sh 8 1 2 32 4096 32 8192 1 16

echo "7b, 8k: dp4, tp4, mbs=2, gbs=16, num micro batch=2"
bash examples/test.sh 4 4 1 32 4096 32 8192 2 16

echo "7b, 8k: dp4, tp4, mbs=1, gbs=16, num micro batch=4"
bash examples/test.sh 4 4 1 32 4096 32 8192 1 16

echo "7b, 8k: dp4, tp2, pp2, mbs=2, gbs=16, num micro batch=2"
bash examples/test.sh 4 2 2 32 4096 32 8192 2 16

echo "7b, 8k: dp4, tp2, pp2, mbs=1, gbs=16, num micro batch=4"
bash examples/test.sh 4 2 2 32 4096 32 8192 1 16

# 7b, 16k
# echo "7b, 16k: dp8, tp2, mbs=1, gbs=8, num micro batch=1"
# bash examples/test.sh 8 2 1 32 4096 32 16384 1 8

echo "7b, 16k: dp8, pp2, mbs=1, gbs=8, num micro batch=1, 不完整的pp, gpipe?"
bash examples/test.sh 8 1 2 32 4096 32 16384 1 8

echo "7b, 16k: dp4, tp4, mbs=1, gbs=8, num micro batch=2"
bash examples/test.sh 4 4 1 32 4096 32 16384 1 8

echo "7b, 16k: dp4, tp2, pp2, mbs=1, gbs=8, num micro batch=2"
bash examples/test.sh 4 2 2 32 4096 32 16384 1 8

echo "7b, 16k: dp2, tp8, mbs=1, gbs=8, num micro batch=4"
bash examples/test.sh 2 8 1 32 4096 32 16384 1 8

echo "7b, 16k: tp8, pp2, mbs=1, gbs=8, num micro batch=8"
bash examples/test.sh 1 8 2 32 4096 32 16384 1 8

echo "7b, 16k: dp2, tp2, pp4, mbs=1, gbs=8, num micro batch=4"
bash examples/test.sh 2 2 4 32 4096 32 16384 1 8



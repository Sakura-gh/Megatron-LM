ps -aux | grep pretrain_gpt.py | awk '{print $2}' | xargs kill -9
sleep 10
ps -aux | grep torchrun | awk '{print $2}' | xargs kill -9
echo "worker-0 kill done."

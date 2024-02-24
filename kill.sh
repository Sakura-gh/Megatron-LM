#!/bin/bash

LOCAL_IP=$(ifconfig bond0 | grep 'inet ' | awk '{print $2}' | cut -d':' -f2)
#sleep 3
echo "*** Kill processes on $LOCAL_IP"
#pkill -9 torchrun
#pkill -9 pretrain_gpt
#pkill -9 torchrun
#pkill -9 pretrain_gpt
ps -aux | grep pretrain_gpt | awk '{print $2}' | xargs kill -9
sleep 1
ps -aux | grep torchrun | awk '{print $2}' | xargs kill -9
sleep 1
ps -aux | grep pretrain_gpt | awk '{print $2}' | xargs kill -9
sleep 1
ps -aux | grep torchrun | awk '{print $2}' | xargs kill -9
sleep 1
echo "$LOCAL_IP kill done."


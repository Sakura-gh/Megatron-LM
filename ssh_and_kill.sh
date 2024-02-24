#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
hostfile="${SCRIPT_DIR}/two_nodes.txt"
kill_sh="${SCRIPT_DIR}/kill.sh"
LOCAL_IP=$(ifconfig bond0 | grep 'inet ' | awk '{print $2}' | cut -d':' -f2)
while IFS= read -r line; do
    if [ $LOCAL_IP != $line ]; then
	echo "Kill on $line via ${kill_sh}"
	ssh $line "bash ${kill_sh} 2>&1"
    fi
done < $hostfile


#!/bin/bash

if [ ! -f ./.env ]; then
    echo "please run ./create_test_env.sh"
    exit 1
fi

source ./.env

activate_script="./testenv/bin/activate"
if [ ! -f $activate_script ]; then
    echo "please run ./create_test_env.sh"
    exit 1
fi

source $activate_script

git_root=`git rev-parse --show-toplevel`

cd $git_root/test/integ



if [ -z "$1" ]; then
    pytest 
else
    pytest $1
fi

# kill any stray xmrig processes that have not respected our kills
xmrigs=`ps aux | grep xmrig | grep -v grep | grep $test_build_dir`
if [ -z "$xmrigs" ]; then
    echo "killing xmrigs"
    echo $xmrigs
fi
for pid in `ps aux | grep xmrig | grep -v grep | grep $test_build_dir | awk '{print $2}'`; do
    kill $pid
done

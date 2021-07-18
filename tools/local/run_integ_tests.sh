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
echo $1
if [ -z "$1" ]; then
    pytest
else
    pytest $1
fi
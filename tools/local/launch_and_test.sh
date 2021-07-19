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

./launch.sh

if [ $? -ne 0 ]; then
    echo "Launch script failed see above!!"
    exit 1
fi

./run_integ_tests.sh

./kill_all_test_env_processes.sh
#!/usr/bin/env python

import subprocess
from testlib.util import load_env, get_env_file

def test_env():
    env_dict = load_env(get_env_file())
    config_items = [
        "monerod_ip",
        "monerod_rpc_port",
        "wallet_rpc_ip",
        "wallet_rpc_port",
        "wallet_file",
        "wallet_password",
        "test_pool_port",
        "test_pool_webui_port",
        "test_pool_wallet_address",
        "test_pool_fee_wallet_address",
        "test_build_dir"
    ]
    for key in config_items:
        if key not in env_dict.keys():
            print("Missing {}".format(key))
            assert False
    assert True
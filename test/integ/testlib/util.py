#!/usr/bin/env python

from os.path import exists
from subprocess import Popen, PIPE

def load_env(env_file):
    print(env_file)
    content = ""
    env_dict = {}
    if exists(env_file):
        with open(env_file, 'r') as fh:
            content = fh.read()
    for line in content.splitlines():
        k, v = line.split("=")
        v = v.replace('"','')
        print("{}: {}".format(k, v))
        env_dict[k] = v
    return env_dict

def get_env_file():
    proc = Popen("git rev-parse --show-toplevel", stdout=PIPE, shell=True)
    (git_root, err) = proc.communicate()
    git_root = str(git_root, 'utf-8')
    git_root = git_root.strip('\n')
    env_file = "{}/tools/local/.env".format(git_root)
    return env_file
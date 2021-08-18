#!/bin/bash

# 用于本地开发

path=`pwd`

ln -sf ${path}/fnode.sh /usr/local/bin/fnode

chmod 777 /usr/local/bin/fnode

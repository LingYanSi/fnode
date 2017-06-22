#!/bin/bash

# 用于本地开发

path=`pwd` 

ln -sf ${path}/inode.sh /usr/local/bin/inode

chmod 777 /usr/local/bin/inode

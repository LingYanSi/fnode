#!/bin/bash

path=`pwd`

echo $path

ln -sf ${path}/inode.sh /usr/local/bin/inode

chmod 777 /usr/local/bin/inode

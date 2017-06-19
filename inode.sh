#!/bin/bash

# 待补充 使用use i default
# node镜像
mirror=https://npm.taobao.org/mirrors/node

# 获取平台 转小写
os=`uname | awk '{print tolower($0)}'`

# 定义node文件夹
nodeDir=~/me/node

mkdir -p $nodeDir

cd $nodeDir

# 获取当前路径
path=`pwd`

lnNode(){
    if [ -d $1 ]; then
        # 软连
        ln -sf ${path}/${1}/bin/npm /usr/local/bin/npm
        ln -sf ${path}/${1}/bin/node /usr/local/bin/node
        echo "node已切换到${1}版本"
    fi
}

if [ "$1" == "use" ]; then
    # 使用. ./bash.sh执行shell文件，命令会在一个sub-shell环境内执行
    # 执行完毕后alias并不会被保存，如果想让命令被保存，则必须要把命令保存在 ~/.bashrc | ~/.zshrc | ~/.profile内
    #

    if [ -z $2 ]; then
        echo "版本号不能为空"
        exit
    fi

    # 查找指定最新版本node
    v=`inode ls | grep v$2 | awk 'END {print}'`

    # 判断有没有在本地找到
    if [ -z $v ]; then
        echo "本地未安装 v$2 版本node"

        # 查找线上指定最新最新版本node
        lastV=`curl $mirror | grep -Eo '>v([0-9]\.?)+' | grep v$2 | grep -Eo '[0-9].+' | awk 'END {print}' `
        if [ $lastV ]; then
            # 是否安装
            echo "是否安装 v$lastV 版本node: y/n"
            read yes
            if [ "$yes" == "y" ]; then
                inode i $lastV
            fi
        else
            echo "v$2 版本node未发布过"
        fi
        exit
    fi

    version=$v

    lnNode $version

    # alias node=${path}/${version}/bin/node
    # alias npm=${path}/${version}/bin/npm

    # 让alias生效
    # echo "alias node=${path}/${version}/bin/node" >> ~/.zshrc
    # echo "alias npm=${path}/${version}/bin/npm" >> ~/.zshrc

elif [[ "$1" == "i" || "$1" == "install" ]]; then
    v=$2
    # 判断是否指定了版本号，如果没有指定则去下载最新版本node
    v=`curl $mirror | grep -Eo '>v([0-9]\.?)+' | grep v$v  | grep -Eo '[0-9].+' | awk 'END {print}' `

    if [ -z $v ]; then
        echo "找不到${2}版本node"
        exit
    fi
    
    version="v$v"

    downloadUrl="${mirror}/${version}/node-${version}-${os}-x64.tar.gz"

    echo "$version --> $downloadUrl"

    # 获取压缩文件名
    untarname=$(echo $downloadUrl | grep -Eo 'node-.+')
    # 解压后文件吗
    filename=$(echo $untarname | sed -E 's/\.tar.+//')

    version=`echo $filename | grep -Eo 'v([0-9]\.?)+'`

    # 下载
    wget $downloadUrl

    # 解压
    tar -xzvf $untarname

    if [ -d $version ]; then
        echo "移除已存在${version}文件夹"
        rm -r $version
    fi
    # 修改文件名
    mv -f $filename $version

    # 软连接
    lnNode $version

    # 删除压缩包
    rm $untarname
    # https://npm.taobao.org/mirrors/node/v8.1.0/node-v8.1.0-darwin-x64.tar.gz

elif [ "$1" == "default" ]; then
    echo "设置系统默认node:"
    inode use $2

elif [ "$1" == "ls" ]; then
    echo "node已安装版本:"
    ls $nodeDir

elif [ "$1" == "lsr" ]; then
    echo "node已发布版本 >"
    curl $mirror | grep -Eo '>v([0-9]\.?)+' | grep -Eo '[0-9].+'

elif [[ "$1" == "un" || "$1" == "uninstall" ]]; then
    # 指定了版本号，就移除指定版本号
    if [[ $2 && "$2" == "all" ]]; then
        rm -r $path
        exit
    fi

    if [ -d "v$2" ]; then
        rm -r "v$2" && echo "v$2 node已卸载"

        # 卸载后，把node切换最新版本
        v=`inode ls | grep -Eo '[0-9].+' | awk 'END {print}'`
        inode use $v
    else
        echo "版本号为空，或者$2版本不存在"
    fi

elif [[ "$1" == "--help" || -z $1 ]]; then
    echo "inode 一个轻量级node版本管理器"
    echo "use version     使用指定版本node"
    echo "i   version     安装指定版本node"
    echo "un  version     卸载指定版本node"
    echo "ls  version     查看已安装node"
    echo "lsr version     查看已发布node"
fi

exit

# wget -O /usr/local/bin/inode http://172.16.24.200:8964/shell/inode

# curl http://172.16.24.200:8964/shell/inode-install.sh | bash

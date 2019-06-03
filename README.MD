# inode
轻量级node版本管理器

## 安装
```bash
curl https://lingyansi.github.io/inode/inode-install.sh | bash
```

## 使用
- inode i 8         安装node 8最新版本
- inode use 8       使用node 8最新版本
- inode un 8.1.2    卸载8.1.2版本
- inode ls          查看本地所有版本
- inode lsr         查看已发布的所有版本

## 多平台
支持mac、linux

## 常见问题

配置PATH
有些linux服务器因为 `/user/local/bin` 不在path里面，导致找不到inode命令，可以通过`vim ~/.bash_profile`来新增PATH
```
PATH=$PATH:/user/local/bin
```

安装完node后，使用npm安装后会发现另一个问题，安装的全部包找不到命令，是因为npm全局安装包存放的位置不在PATH内
```
touch ~/.npmrc
```

prefix用来指定全局安装包的位置
```npmrc
prefix=/usr/local
registry=https://registry.npm.taobao.org/
phantomjs_cdnurl=http://cnpmjs.org/downloads
sass_binary_site=https://npm.taobao.org/mirrors/node-sass/
```

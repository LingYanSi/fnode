# fnode
轻量级node版本管理器

## 安装
```bash
curl https://lingyansi.github.io/fnode/fnode-install.sh | bash
```

## 使用
- `fnode i 20`         安装node 20最新版本
- `fnode i 20 --origin`  使用官方源安装node 20最新版本
- `fnode use 20`       使用node20最新版本
- `fnode un 20.1.2`    卸载20.1.2版本
- `fnode ls`          查看本地所有版本
- `fnode lsr`         查看已发布的所有版本

## 多平台
支持mac、linux

## 常见问题

fnode被安装在`/usr/local/bin`下，如果安装后找不到fnode命令，可以通过`vim ~/.bash_profile`来新增PATH
```
PATH=$PATH:/usr/local/bin
```

设置npmrc `vim ~/.npmrc`，指定全局安装包的位置
```npmrc
prefix=/usr/local
```

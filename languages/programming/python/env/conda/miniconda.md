# Miniconda

## 安装

建议安装最新版本，且不要使用 `root` 用户来安装。

```sh
# 下载
$ wget -P ~/Downloads/ https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh

# 校验，校验地址：https://repo.continuum.io/miniconda/
$ md5sum ~/Downloads/Miniconda3-latest-Linux-x86_64.sh
bec6203dbb2f53011e974e9bf4d46e93  /home/yin/Downloads/Miniconda3-latest-Linux-x86_64.sh

# 安装
$ bash ~/Downloads/Miniconda3-latest-Linux-x86_64.sh
```

## 其他

Miniconda 默认的虚拟环境为 `root`。如果希望把 Miniconda 转变为 Anaconda，只需要在相应的环境安装 `anaconda` 包即可。

```sh
# 虚拟环境
$ conda info --env
root        *  /usr/local

# 修改 root 环境下 python 的版本
$ conda install python=3.5

# 安装 anaconda 包
$ conda install anaconda

# 升级 conda
$ conda update conda
```
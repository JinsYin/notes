# Anaconda

## 安装使用

* Linux 安装

（不建议使用 root 用户来安装，通常安装最新版本）

```bash
# 下载
$ conda_version=5.1.0
$ wget -O /tmp/anaconda3.sh https://repo.continuum.io/archive/Anaconda3-${conda_version}-Linux-x86_64.sh

# 校验，校验地址：https://docs.anaconda.com/anaconda/install/hashes/Anaconda3-$(conda_version)-Linux-x86_64.sh-hash
$ md5sum /tmp/anaconda3.sh
966406059cf7ed89cc82eb475ba506e5  Anaconda3-5.1.0-Linux-x86_64.sh

# 安装
$ chmod +x /tmp/anaconda3.sh && /tmp/anaconda3.sh

# 验证
$ anaconda --version
anaconda Command line client (version 1.6.9)
```


## 虚拟环境

```bash
# 创建虚拟环境
$ conda create -n py27 python=2.7 ipykernel
$ conda create -n py35 python=3.5 ipykernel
$ conda create -n py36 python=3.6 ipykernel

source activate py27
conda install notebook ipykernel
ipython kernel install --user
```
# Anaconda

## 安装

建议安装最新版本，且不要使用 `root` 用户来安装。

```sh
# 下载
$ anaconda_version=5.1.0
$ wget -P ~/Downloads/ https://repo.continuum.io/archive/Anaconda3-${anaconda_version}-Linux-x86_64.sh

# 校验，校验地址：https://docs.anaconda.com/anaconda/install/hashes/Anaconda3-${anaconda_version}-Linux-x86_64.sh-hash
$ md5sum ~/Downloads/Anaconda3-${anaconda_version}-Linux-x86_64.sh
966406059cf7ed89cc82eb475ba506e5  /home/yin/Downloads/Anaconda3-5.1.0-Linux-x86_64.sh

# 安装
$ bash ~/Downloads/Anaconda3-${anaconda_version}-Linux-x86_64.sh
```

安装过程会提示是否添加 Anaconda 的执行环境，如果安装完成后无法执行 `anaconda` 命令，可以进行如下操作：

```sh
$ echo 'export PATH="~/anaconda3/bin:$PATH"' >> ~/.bashrc # $PATH 的顺序一定要在 anaconda 之后
$ source ~/.bashrc # 立即生效

# 查看版本
$ anaconda --version && conda --version
anaconda Command line client (version 1.6.9)
conda 4.4.10
```

## 检查

Anaconda 除了会安装一些用于数据分析的 Python 依赖包（路径：`~/anaconda3/lib/python3.6/site-packages`）外，还会安装一些二进制程序（路径：`~/anaconda3/bin`），如：`python`、`pip`、`jupyter`、`anaconda-navigator` 等等。

```sh
$ which python
/home/yin/anaconda3/bin/python

$ which pip
/home/yin/anaconda3/bin/pip

$ pip --version
pip 9.0.1 from /home/yin/anaconda3/lib/python3.6/site-packages (python 3.6)
```

## 卸载

```sh
# 该模块用于在卸载 Anaconda 时删除配置文件，最新的 Anaconda 已默认安装该模块
$ conda install anaconda-clean

# 删除配置文件 ~/.conda 并自动备份
$ anaconda-clean

# 删除 Anaconda 目录
$ rm -rf ~/.anaconda3

# 最后移除 .bashrc 中为 Anaconda 添加的 PATH
$ vi ~/.bashrc
```

## 升级

升级 `anaconda` 包可以获取最新的软件包。下面以 `base` 虚拟环境为例：

```sh
# 先升级 conda 工具
$ conda update conda

# 升级完 conda 后，再更新 anaconda 软件包
$ conda update anaconda
```

## 参考

* [How To Install the Anaconda Python Distribution on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-the-anaconda-python-distribution-on-ubuntu-16-04)

# Conda 虚拟环境

conda 默认的虚拟环境为 `bash`，该环境的路径为：`~/anaconda3`，其他虚拟环境的路径为 `~/anaconda3/envs/<env>`。

```sh
# 查看所有虚拟环境（* 表示当前所在的环境）
$ conda env list # or: conda info --env
base                  *  /home/yin/anaconda3

# 创建虚拟环境（该环境包含 2.7 中最新版本的 python 和最新版本的 numpy）
$ conda create --name python2.7 python=2.7 numpy
```

另外，我当前安装的 Anaconda 使用的 Python 版本为 `3.6`，如果希望默认的 `base` 环境使用 Python `3.5`，可以直接在默认环境下安装想要的 Python 版本：

```sh
# base 环境
$ conda install python=3.5
```

* 切换虚拟环境（命令行）

进入 `python2.7` 环境：

```sh
# Linux & Mac
$ source activate python2.7

# Windows
$ activate python2.7
```

回到默认的 `base` 环境：

```sh
# Linux & Mac（Linux 下执行 'source ~/.bashrc' 也会退回到 base 虚拟环境）
$ source deactivate # or: source deactivate python2.7

# Windows
$ deactivate
```

上面的命令太难记了，试图简化一下（Linux）：

```sh
$ vi ~/.bashrc
alias condaenv='source activate'
alias condaexit='source deactivate'

# 立即生效
$ source ~/.bashrc

# 进入虚拟环境
$ condaenv python2.7

# 退出虚拟环境
$ condaexit
```

* 切换虚拟环境（PyCharm IDE）

`File` -> `Settings` -> `Project` -> `Project Interpreter`

* 删除虚拟环境

```sh
$ conda env remove --name python2.7

# 还可以通过删除该环境下所有的包来实现
$ conda remove --name python2.7 --all
```

## 完美应用

这种方式不仅会安装指定版本的 Python，还会基于指定的 Python 版本来安装 Anaconda 中所有的包。

```sh
% conda create -n python2.7 python=2.7 anaconda
% conda create -n python3.5 python=3.5 anaconda
```

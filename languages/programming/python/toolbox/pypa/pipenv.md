# Pipenv

Pipenv 是 python.org 官方推荐的 Python 打包工具，它会自动为你的项目创建和管理一个虚拟环境，并在安装/卸载软件包时从你的 `Pipfile` 中添加/删除软件包。


## 特点


## 安装

* ubuntu 17.10

```sh
# 不支持 ubuntu 14.04
$ apt-get install software-properties-common python-software-properties
$ add-apt-repository ppa:pypa/ppa
$ apt-get update
$ apt-get install pipenv
```

* pip

```sh
#
$ pip --version
pip 9.0.1 from /usr/local/lib/python2.7/dist-packages (python 2.7)

$ pip install pipenv

$ pipenv --version
pipenv, version 11.1.3
```

## Pipfile

Pipfile是社区拟定的依赖管理文件，用于替代过于简陋的 pip 的 requirements.txt 文件。


## 用法

```sh
# 激活并进入虚拟环境（使用 exit 退出）
$ pipenv shell

# 显示虚拟环境
$ pipenv --venv
/home/yin/.local/share/virtualenvs/pipenvtest-dZqycsbZ

# 显示 Python 解释器路径
$ pipenv --py
/home/yin/.local/share/virtualenvs/pipenvtest-dZqycsbZ/bin/python

# 更新 Pipfile.lock
$ pipenv lock
```

```sh
$ pipenv --two

pipenv instal requests

cat Pipfile

pipenv lock

cat Pipfile.lock

pipenv lock -r

pipenv shell

pip freeze

exit
```

## 参考

* [Python 新利器之 pipenv](https://www.jianshu.com/p/00af447f0005)
* [使用 pipenv 管理你的项目](https://zhuanlan.zhihu.com/p/32913361)

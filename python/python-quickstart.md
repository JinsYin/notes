# Python 快速入门

## 命令行交互

```bash
root@node:~$ python
Python 3.5.3 (default, Aug 22 2017, 20:36:50) 
[GCC 4.8.4] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 
>>> 100 + 200
3000
>>> 
>>> print("hello, world")
hello, world
>>>
>>> # 退出
>>> exit()
```

## HelloWold

```bash
$ # 设置运行环境时，一般不直接指定 python 路径，因为各个系统的路径可能不一样
$ vi hello.py
#!/usr/bin/env python3
# coding: utf-8
print("Hello, world")
$
$ # 运行方式一
$ python hello.py
Hello, world
$
$ # 运行方式二
$ chmod +x hello.py
$ ./hello.py
```

## **Pip、Setuptools、Easy_install、**PyPI

* **pip**

Pip是一个 python 包管理器。

* **pypi**

PyPi（Python Package Index）

* **setuptools**

```bash
$ apt-get install python-setuptools
```

* **easy_install**

easy_install 是 setuptools 包自带的一个命令，所以 easy_install 实际上是调用 setuptools 来安装 python 包。

```bash
$ # 安装模块
$ easy_install pylab
```

## **Wheel、Egg**

打包工具



## **Virtualenv、Pyenv、Conda**

* **Virtualenv**

```bash
$ pip install virtualenv
```

* **pyenv**

```bash
$ 
```


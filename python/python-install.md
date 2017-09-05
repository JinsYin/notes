# Python 安装

以 Ubuntu 14.04 为例。

## 安装 Python

* **使用内置源安装 python2**

```bash
$ # 通常，默认安装了 python 2.7
$ python --version
Python 2.7.6

$ # 安装
$ apt-get install python
```

* **使用内置源安装 python3**

```bash
$ # 通常，默认安装了 python 3.4
$ python3 --version
Python 3.4.3

$ # 安装
$ apt-get install python3
```

* **编译安装**

```bash
$ # 会自动安装 python 和 pip
$ wget https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tgz
$ tar xzf Python-3.5.3.tgz
$ cd Python-3.5.3
$ ./configure
$ make install

$ # 安装路径
$ ll /usr/local/bin/python*
$ ll /usr/local/bin/pip*

$ # 重新建立软连接
$ rm /usr/bin/python && ln -s /usr/local/bin/python3.5 /usr/bin/python
$ rm /usr/bin/pip3 && ln -s /usr/local/bin/pip3 /usr/bin/pip3
```

## 安装 pip

* **使用内置源 python-pip**

```bash
$ # 通常，默认安装了 python-pip（python2.7）
$ pip --version
pip 9.0.1 from /usr/local/lib/python2.7/dist-packages (python 2.7)

$ # 安装
$ apt-get install python-pip

$ # 升级
$ pip install --upgrade pip
```

* **使用内置源 python3-pip**

```bash
$ # 安装
$ apt-get install python3-pip

$ pip --version
pip 9.0.1 from /usr/local/lib/python3.4/site-packages (python 3.4)

$ # 升级
$ pip3 install --upgrade pip
```






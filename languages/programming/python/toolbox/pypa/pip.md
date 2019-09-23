# Pip - 安装 Python 包的工具

## Pip 与 Python 的关系

简单概括：不同版本的 Python 需要安装对应版本的 Pip，比如：`python2.7` 需要安装 `pip2.7`，`python3.5` 需要安装 `pip3.5`。也就是说，Pip 是由 Python 来管理的，而不是由 Pip 来管理 Python；Pip 无法管理 Python 的多版本环境问题，仅用于安装 Python 依赖包。

## 安装

* CentOS

```sh
$ yum install -y python-pip

# 更新
$ pip install --upgrade pip
```

* Ubuntu

```sh
$ apt-get install python-pip

# 更新
$ pip install --upgrade pip
```

## 命令

```sh
# 查看已安装的软件包
$ pip freeze
```

## 项目依赖

* pip freeze

```sh
# 导出依赖
$ pip freeze > requirements.txt

# 安装依赖
$ pip install -r requirements.txt
```

* pipreqs

`pip freeze` 保存的是当前环境中使用 `pip install` 安装的所有软件包及依赖，这会包含一些当前项目没有使用到的软件包。而 `pipreqs` 是根据项目代码的导入情况来生成依赖文件。

```sh
$ pip install pipreqs

$ pipreqs /home/project/location
Successfully saved requirements file in /home/project/location/requirements.txt
```

## 参考

* [Document - pip](https://pip.pypa.io/)

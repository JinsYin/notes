# PyPI · 发布 Python 包

PyPI（Python Package Index）是 Python 的软件存储库。

## 项目目录

一个项目理论上可以包含多个软件包（子包），而最终发布的是整个项目，也就是我们常说的 _Python包_（可能包含多个子包）。

项目名称可以任意命名，软件包名甚至也可以与著名软件包（如 numpy）同名，但是安装这样的 _Python包_ 后会导致其中的软件包覆盖本地同名的软件包。所以，**建议一个项目只包含一个软件包，且项目名称与软件包名相同**。

* 测试方案

```sh
pynamespace          # 项目名称
├── subpkg_a         # 软件包名
│   └── __init__.py
├── subpkg_b         # 软件包名
│   └── __init__.py
├── LICENSE
├── README.md
└── setup.cfg
└── setup.py
```

* 推荐方案

```sh
pythonx             # 项目名称
├── pythonx         # 软件包名
│   └── __init__.py
├── LICENSE
├── README.md
└── setup.cfg
└── setup.py
```

## 项目文件

### setup.py

```python
import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="pythonx",
    version="0.0.1",
    author="Jins Yin",
    author_email="jinsyin@gmail.com",
    description="Python X",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/jinsyin/x/tree/master/pythonx",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
)
```

setup() 参数描述：

* **name**             - 项目名称，即 _Python包_ 的名称，必须在 PyPI 上是唯一的，可通过 `pip search <name>` 来预检
* **version**          -
* **long_description** - 项目详细描述
* **license**          - 项目详细描述

### setup.cfg

```ini
[metadata]
license_files = LICENSE

[bdist_wheel]
universal = 1
```

### README.md

```markdown
# PythonX
```

### LICENSE

前往 [choosealicense.com](https://choosealicense.com/) 选择一个 license ，将内容复制粘贴到该文件。

## 打包项目

支持两种打包方式（两者共存是，pip 优先选择 wheel）：

* sdist（Source Distributions）- 即源码包
* wheel                       - 采用预编译格式，安装速度更快

```sh
# 安装最新版本的 setuptools 和 wheel
$ python3 -m pip install --user --upgrade setuptools
```

```sh
$ python3 setup.py sdist bdist_wheel
```

```sh
├── build
│   ├── bdist.linux-x86_64
│   └── lib
│       └── pythonx
│           └── __init__.py
├── dist
│   ├── pythonx-0.0.1-py2.py3-none-any.whl
│   └── pythonx-0.0.1.tar.gz
├── LICENSE
├── pythonx
│   └── __init__.py
├── pythonx.egg-info
│   ├── dependency_links.txt
│   ├── PKG-INFO
│   ├── SOURCES.txt
│   └── top_level.txt
├── README.md
├── setup.cfg
└── setup.py

```

## 注册账号

### 测试账号

* 前往 [PyPI 测试版注册页面](https://test.pypi.org/manage/projects/) 注册账号
* 验证注册邮箱

### 正式账号

* 前往 [PyPI 注册页面](https://pypi.org/account/register) 注册账号
* 验证注册邮箱
* 本机配置 PyPI 访问地址和账号

```ini
$ vi ~/.pypirc
[distutils]
index-servers = pypi

[pypi]
username:<username>
password:<password># 可选
```

## 上传项目

```sh
$ python3 -m twine upload --repository-url https://test.pypi.org/legacy/ dist/*

python3 -m twine upload dist/*
```

## 使用

* 安装

```sh
$ pip install pythonx
```

* 测试

```py
$ python

>>> import x, y

>>> x.name
X

>>> y.name
Y
```

## 更新

更新项目后需要修改版本（version）才能上传，上传完成后使用 `pip install --upgrade pythonx` 更新本地库。

## 参考

* [Python Packaging User Guide](https://packaging.python.org/)
* [Packaging Python Projects](https://packaging.python.org/tutorials/packaging-projects/)
* [A sample Python project](https://github.com/pypa/sampleproject)
* [Requests: HTTP for Humans™](https://github.com/kennethreitz/requests)
* [Packaging namespace packages](https://packaging.python.org/guides/packaging-namespace-packages/)
* [Packaging History](https://www.pypa.io/en/latest/history/#packaging-history)

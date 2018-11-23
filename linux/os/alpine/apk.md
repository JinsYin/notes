# Alpine apk 包管理器

## 在线安装包

> https://pkgs.alpinelinux.org/packages

## apk 命令

* 安装

```bash
$ apk add --update bash
$ apk add --no-cache bash
```

* 卸载

```bash
$ apk del --no-cache bash
$ apk del --no-cache --purge bash
```

* 查看已安装或可用的包

```bash
$ apk info
$ apk info -vv # 显示版本等信息
```

## 常用安装包

* bash

```bash
$ apk add --no-cache bash
```

* ps

```bash
$ apk add --no-cache procps
```

* sdk

alpine-sdk 包含大量的 alpine 基础依赖包。

```bash
$ apk add --no-cache alpine-sdk
```

* openjdk

```bash
$ apk add --no-cache openjdk8
$ EXPORT JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
```

* python 2

```bash
# build-base linux-headers pcre-dev 是一些基础包，对于某些 Python 依赖包有用
$ apk add --no-cache build-base linux-headers pcre-dev python python-dev

# 安装 pip （3.5 及以上版本）
$ apk add --no-cache py2-pip

# 安装 pip （3.5 以下版本）
$ apk add --no-cache py-pip

# 升级 pip
$ pip install --upgrade pip
```

* python 3

```bash
# 安装 python3 默认会自动安装好 pip3
$ apk add --no-cache build-base linux-headers pcre-dev python3 python3-dev
$ ln -s /usr/bin/python3 /usr/bin/python
$ ln -s /usr/bin/pip3 /usr/bin/pip
```
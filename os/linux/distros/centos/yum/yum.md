# Yum 命令

谨慎使用 **yum update**，该命令不仅会升级软件包，还会升级内核，从而可能导致系统无法正常启动。

## 用法

```sh
yum [options] [command] [package ...]
```

| 子命令                              | 说明                 |
| ----------------------------------- | -------------------- |
| `install package1 [package2] [...]` | 安装一个或多个软件包 |

## Update 与 Upgrade

```sh
$ yum update  # 更新包/源，且升级内核（谨慎使用）
$ yum upgrade # 更新包，不升级内核

# 从指定 repo 中更新
$ yum --disablerepo="*" --enablerepo="repoA" update
```

* 设置 yum update 不升级内核

```sh
$ # 方法一： 在 /etc/yum.conf 中的 [main] 的最后添加
exclude=kernel*
exclude=centos-release* # redhat-release*
```

```sh
$ # 方法二
$ yum --exclude=kernel* --exclude=centos-release* update
```

## 列出所有的 repository

```sh
$ yum repolist

$ yum repolist all
```

## 开启 epel repository

* epel

```sh
$ yum install -y epel-release

# or
$ rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

* elrepo

```sh
$ rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

$ rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
```

## 清除缓存

`yum` 默认保留下载的包和包数据文件，所以在以后的操作中不会重新下载。

```sh
$ # 清除所有缓存的包
$ yum clean packages
$
$ # 清除所有缓存的包数据文件
$ yum clean headers
$
$ # 清除所有缓存（不要乱来）
$ yum clean all
```

> https://www.centos.org/docs/5/html/yum/sn-yum-maintenance.html

## 刷新缓存

如果添加了 repo 到 /etc/yum.repos.d，可以使用以下命令来刷新缓存、更新 repo。

```sh
$ yum makecache

$ yum makecache fast
```

## 查询已安装的包

```sh
$ rpm -qa | grep docker
```

## 查看软件包信息

```sh
$ yum info docker
```

## 列出所有软件版本

```sh
$ yum list docker --showduplicate
```

## 安装

* 源安装

```sh
$ # 安装最新版本
$ yum install docker
$
$ # 安装指定版本
$ yum install docker-1.12.6
```

* 本地安装

```sh
$ yum localinstall -y /tmp/docker-1.12.6.rpm
```

## 插件

* fastestmirror

使用最快的 mirror

```sh
$ yum install yum-plugin-fastestmirror
```

* protectbase

```sh
$ yum install yum-plugin-protectbase
```

* yum-config-manager

```sh
$ yum install yum-utils
```

> https://www.centos.org/docs/5/html/yum/sn-yum-maintenance.html

## 代理

> https://www.centos.org/docs/5/html/yum/sn-yum-proxy-server.html

## 命令

> https://docs.oracle.com/cd/E37670_01/E37355/html/ol_creating_yum_repo.html
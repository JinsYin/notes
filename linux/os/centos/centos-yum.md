# CentOS yum 命令

## yum update 与 yum upgrade

```bash
$ yum update  # 更新包/源，且升级内核（谨慎使用）
$ yum upgrade # 更新包，不升级内核
$
$ # 从指定 repo 中更新
$ yum --disablerepo="*" --enablerepo="repoA" update
```

* 设置 yum update 不升级内核

```bash
$ # 方法一： 在 /etc/yum.conf 中的 [main] 的最后添加
exclude=kernel* 
exclude=centos-release* # redhat-release*
```

```bash
$ # 方法二
$ yum --exclude=kernel* --exclude=centos-release* update
```


## 列出所有的　repository

```bash
$ yum repolist
```

## 开启 epel 的源

```bash
$ yum install epel-release
```


## 清除缓存

`yum` 默认保留下载的包和包数据文件，所以在以后的操作中不会重新下载。

```bash
$ # 清除所有缓存的包
$ yum clean packages
$
$　# 清除所有缓存的包数据文件
$ yum clean headers
$
$ # 清除所有缓存
$ yum clean all
```

> https://www.centos.org/docs/5/html/yum/sn-yum-maintenance.html

## 刷新缓存

如果添加了 repo 到 /etc/yum.repos.d，可以使用以下命令来刷新缓存。

```bash
$ yum makecache

$ yum makecache fast
```



## 查询已安装的包

```bash
$ rpm -qa | grep docker
```


## 查看软件包信息

```bash
$ yum info docker
```


## 列出所有软件版本

```bash
$ yum list docker --showduplicate
```


## 安装

* 源安装

```bash
$ # 安装最新版本
$ yum install docker
$
$ # 安装指定版本
$ yum install docker-1.12.6
```

* 本地安装

```bash
$ yum localinstall -y /tmp/docker-1.12.6.rpm
```


## 插件

* fastestmirror

使用最快的 mirror

```bash
$ yum install yum-plugin-fastestmirror
```

* protectbase

```bash
$ yum install yum-plugin-protectbase
```

* yum-config-manager

```bash
$ yum install yum-utils
```

> https://www.centos.org/docs/5/html/yum/sn-yum-maintenance.html


## 代理

> https://www.centos.org/docs/5/html/yum/sn-yum-proxy-server.html
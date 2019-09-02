# Docker 环境

Docker 要求 Linux 内核版本大于等于 `3.10`，如果存储驱动（`--storage-driver`）需要使用 `overlay2`，内核需要大于等于 4.0。

如果选择 Kubernetes 作为容器编排建议 docker 版本选择 `1.12.6 `，如果选择 Docker swarm 作为容器编排建议 docker 版本选择 `1.13.1`。

## CentOS (7.2, 7.3)

* **内置源**

目前内置源提供的最高版本是 `1.12.6`。

```sh
$ # 查看版本
$ yum list docker --showduplicate | sort -nr

$ # 安装指定版本
$ yum install -y docker-1.12.6*

$ # 开机自启动
$ systemctl enable docker.service && systemctl start docker.service
```

* **官方源（推荐）**

从 Docker `1.13.1`（CentOS） 开始 ，默认使用 `overlay`、`overlay2` 作为 `storage-driver`（如果内核支持的话），之前的版本默认使用的是 `devicemapper`。

```sh
$ # 移除非官方的 Docker 包
$ yum remove -y docker docker-common container-selinux docker-selinux

$ # 需要使用 yum-config-manager 来添加源
$ yum install -y yum-utils

$ # 添加稳定的官方源
$ yum-config-manager --add-repo \
    https://docs.docker.com/v1.13/engine/installation/linux/repo_files/centos/docker.repo

$ # 更新包索引
$ yum makecache fast

$ # 查看版本
$ yum list docker-engine --showduplicates | sort -nr

$ # 安装指定版本（docker-engine-selinux 是 docker-engine 的依赖包，所以先安装并指定相同的版本）
$ yum install -y docker-engine-selinux-1.12.6* docker-engine-1.12.6*

$ # 检查
$ rpm -qa | grep docker
docker-engine-selinux-1.12.6-1.el7.centos.noarch
docker-engine-1.12.6-1.el7.centos.x86_64

$ # 修改 docker.service 并重启 docker
$ cp ops/systemd/docker.service /usr/lib/systemd/system/docker.service
$ systemctl daemon-reload
$ systemctl enable docker.service && systemctl restart docker.service
```

## Ubuntu

```sh
$ sudo apt-get update
$ sudo apt-get install apt-transport-https ca-certificates
```

```sh
$ sudo apt-key adv \
--keyserver hkp://ha.pool.sks-keyservers.net:80 \
--recv-keys 58118E89F3A912897C070ADBF76221572C52609D
```

* **14.04**

```sh
$ echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
```

* **16.04**

```sh
$ deb "https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
```

> 也可以使用 [deb 安装包](https://apt.dockerproject.org/repo/pool/main/d/docker-engine/) 来安装。

```sh
$ sudo apt-get update
$ sudo apt-cache policy docker-engine
$ sudo apt-get install -y docker-engine=1.12.6*
```

## 安装 docker-compose
```sh
$ wget -O /usr/local/bin/docker-compose http://github.com/docker/compose/releases/download/1.9.0/docker-compose-`uname -s`-`uname -m`
```

## 验证
```
$ docker info
$ docker-compose version
```

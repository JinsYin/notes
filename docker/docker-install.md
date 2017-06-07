# Docker 环境

docker 要求 linux 内核大于等于 3.10（uname -r），如果存储驱动需要使用 overlay2，内核需要大于等于 4.0。

## CentOS (7.2, 7.3)

```bash
# 查看版本
$ yum list docker --showduplicate
```

```bash
# 使用 centos 内置源安装 docker 
$ yum install -y docker-1.12.6
```
> 不使用 docker 官方源的原因是国内的*墙*会导致安装失败。

```bash
$ systemctl start docker.service # 运行
$ systemctl enable docker.service # 开机
```

## Ubuntu (14.04， 16.04)

```bash
# 添加 docker 源
$ echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
```

```bash
# 查看版本
$ sudo apt-get policy docker-engine
```

```bash
# 安装指定版本
$ sudo apt-get install docker-engine=1.12.6-0~ubuntu-trusty
```

> 也可以使用 [deb 安装包](https://apt.dockerproject.org/repo/pool/main/d/docker-engine/) 来安装。

```bash
$ service docker restart
```

## 安装 docker-compose
```bash
$ wget -O /usr/local/bin/docker-compose http://github.com/docker/compose/releases/download/1.9.0/docker-compose-`uname -s`-`uname -m`
```

## 验证
```
$ docker info
$ docker-compose version
```

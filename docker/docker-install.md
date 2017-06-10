# 安装 docker

docker 要求 linux 内核版本大于等于 3.10 （uname -r）。docker 版本： 1.12.6 。

## CentOS (7.2, 7.3)

- 使用 centos 内置源安装 docker (1.12.6)
```bash	
$ yum list docker --showduplicate
$ yum install -y docker-1.12.6
```
> 不使用 docker 官方源的原因是国内的*墙*会导致安装失败。

- 安装 docker-compose (1.9.0)
```bash
$ wget -O /usr/local/bin/docker-compose http://github.com/docker/compose/releases/download/1.9.0/docker-compose-`uname -s`-`uname -m`
```

## Ubuntu

```bash
$ sudo apt-get update
$ sudo apt-get install apt-transport-https ca-certificates
```

```bash
$ sudo apt-key adv \
--keyserver hkp://ha.pool.sks-keyservers.net:80 \
--recv-keys 58118E89F3A912897C070ADBF76221572C52609D
```

14.04
```bash
$ echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
```

16.04
```bash
$ deb "https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
```

```bash
$ sudo apt-get update
$ sudo apt-cache policy docker-engine
$ sudo apt-get install -y docker-engine=1.12.6*
```

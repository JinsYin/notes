# 安装 docker

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

## Ubuntu (14.04)

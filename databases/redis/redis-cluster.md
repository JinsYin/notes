# Redis 主机集群搭建

## 安装、运行（master 和 slave）

```sh
$ sudo add-apt-repository ppa:chris-lea/redis-server
$ sudo apt-get update
$ sudo apt-get install redis-server -y
```

## 测试（master 和 slave）

1000 个请求，10 个并发，5个管道（pipeline）

```sh
$ redis-benchmark -q -n 1000 -c 10 -P 5
```

## 配置 master

设置 keepalive timer：

```sh
$ sed -i -r 's/tcp-keepalive.*/tcp-keepalive 60/g' /etc/redis/redis.conf
```

允许所有机器连接：

```sh
$ sed -i -r 's/bind\s+127.0.0.1/# bind 127.0.0.1/g' /etc/redis/redis.conf
```

设置密码

```sh
$ sed -i -r 's|#\s+requirepass.*|requirepass 123456|g' /etc/redis/redis.conf| grep requirepass
```

其他

```sh
$ sed -i -r 's/#\s+maxmemory-policy.*/maxmemory-policy noeviction/g' /etc/redis/redis.conf
$ sed -i -r 's/appendonly\s+no/appendonly yes/g' /etc/redis/redis.conf
$ sed -i -r 's/appendfilename.*/appendfilename "redis-staging-ao.aof"/g' /etc/redis/redis.conf | grep appendfilename
```

重启

```sh
$ sudo service redis-server restart
```

远程试一试

```sh
$ redis-cli -h 192.168.1.* -p 6379 -a 123456
```

## 配置 slave

```sh
$ # 允许所有机器连接
$ sed -i -r 's/bind\s+127.0.0.1/# bind 127.0.0.1/g' /etc/redis/redis.conf
$
$ # 设置密码
$ sed -i -r 's|#\s+requirepass.*|requirepass 123456|g' /etc/redis/redis.conf| grep requirepass
$
$ # 设置 master (192.168.1.220 为 master ip, 6379为 master port)
$ sed -i -r 's/#\s+slaveof.*/slaveof 192.168.1.220 6379/g' /etc/redis/redis.conf
$
$ # 设置 master 密码
$ sed -i -r 's/#\s+masterauth.*/masterauth 123456/g' /etc/redis/redis.conf
$
$ # 重启
$ sudo service redis-server restart
```

```sh
# 在 master 上连接 slave
$ redis-cli -h 192.168.1.* -p 6379
$
$ # 关闭slave与master的连接
> INFO (# Replication)
> SLAVEOF NO ONE
> INFO (# Replication)
>
> # 重新连接到master
> SLAVEOF your_redis_master_ip 6379
```

## 作者

本文档由 `尹仁强` 创建，由 `王若凡` 参与整理。

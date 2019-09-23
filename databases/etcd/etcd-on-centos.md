# Etcd On CentOS 集群搭建

## 角色分配

| ETCD_NAME | Hostname  | IP Address     |
| --------- | --------- | ---------      |
| etcd100   | Host100   | 172.28.128.100 |
| etcd101   | Host101   | 172.28.128.101 |
| etcd102   | Host102   | 172.28.128.102 |

## 系统环境

* Centos 7.3.1611
* Kernel 3.10.0-514.26.2
* Etcd 2.3.7

## 安装

```sh
# 版本
$ export ETCD_VERSION=2.3.7

$ yum list etcd --showduplicates

$ yum install -y etcd-${ETCD_VERSION}
```

## 单机

* 启动

```sh
$ systemctl start etcd.service
```

* 默认配置

```sh
$ vi /usr/lib/systemd/system/etcd.service
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
WorkingDirectory=/var/lib/etcd/
EnvironmentFile=-/etc/etcd/etcd.conf
User=etcd
# set GOMAXPROCS to number of processors
ExecStart=/bin/bash -c "GOMAXPROCS=$(nproc) /usr/bin/etcd --name=\"${ETCD_NAME}\" --data-dir=\"${ETCD_DATA_DIR}\" --listen-client-urls=\"${ETCD_LISTEN_CLIENT_URLS}\""
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```

* 测试

```sh
$ etcdctl set foo bar

$ etcdctl get foo

$ etcdctl rm /foo
```

测试完成后：

```sh
# 停止服务
$ systemctl stop etcd.service

# 删除数据
$ rm -rf /var/lib/etcd/*
```

## 集群

* Token

```sh
$ uuidgen
f0834740-74dc-43c2-9fde-4b8e5c7aa3df
```

* Host100

```sh
$ cat /etc/etcd/etcd.conf
ETCD_NAME=etcd100
ETCD_DATA_DIR="/var/lib/etcd/etcd100"
ETCD_LISTEN_CLIENT_URLS="http://172.28.128.100:2379"
ETCD_LISTEN_PEER_URLS="http://172.28.128.100:2380"
ETCD_ADVERTISE_CLIENT_URLS="http://172.28.128.100:2379"
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://172.28.128.100:2380"
ETCD_INITIAL_CLUSTER="etcd100=http://172.28.128.100:2380,etcd101=http://172.28.128.101:2380,etcd102=http://172.28.128.102:2380"
ETCD_INITIAL_CLUSTER_TOKEN="f0834740-74dc-43c2-9fde-4b8e5c7aa3df"
ETCD_INITIAL_CLUSTER_STATE="new"
```

* Host101

```sh
$ cat /etc/etcd/etcd.conf
ETCD_NAME=etcd101
ETCD_DATA_DIR="/var/lib/etcd/etcd101"
ETCD_LISTEN_CLIENT_URLS="http://172.28.128.101:2379"
ETCD_LISTEN_PEER_URLS="http://172.28.128.101:2380"
ETCD_ADVERTISE_CLIENT_URLS="http://172.28.128.101:2379"
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://172.28.128.101:2380"
ETCD_INITIAL_CLUSTER="etcd100=http://172.28.128.100:2380,etcd101=http://172.28.128.101:2380,etcd102=http://172.28.128.102:2380"
ETCD_INITIAL_CLUSTER_TOKEN="f0834740-74dc-43c2-9fde-4b8e5c7aa3df"
ETCD_INITIAL_CLUSTER_STATE="new"
```

* Host102

```sh
$ cat /etc/etcd/etcd.conf
ETCD_NAME=etcd102
ETCD_DATA_DIR="/var/lib/etcd/etcd102"
ETCD_LISTEN_CLIENT_URLS="http://172.28.128.102:2379"
ETCD_LISTEN_PEER_URLS="http://172.28.128.102:2380"
ETCD_ADVERTISE_CLIENT_URLS="http://172.28.128.102:2379"
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://172.28.128.102:2380"
ETCD_INITIAL_CLUSTER="etcd100=http://172.28.128.100:2380,etcd101=http://172.28.128.101:2380,etcd102=http://172.28.128.102:2380"
ETCD_INITIAL_CLUSTER_TOKEN="f0834740-74dc-43c2-9fde-4b8e5c7aa3df"
ETCD_INITIAL_CLUSTER_STATE="new"
```

* etcd.service

`/usr/lib/systemd/system/etcd.service` 可以不用修改，它会自动引入 `/etc/etcd/etcd.conf` 中的环境变量作为 `/usr/bin/etcd` 的参数。

* 启动

```sh
$ systemctl start etcd.service

$ systemctl enable etcd.service
```

* 测试

```sh
# 查看集群健康状态
$ etcdctl cluster-health

$ # 查看集群成员
$ etcdctl member list

# 远程访问
$ etcdctl --endpoints http://172.28.128.100:2379,http://172.28.128.101:2379,172.28.128.102:2379 cluster-health

# URL
$ curl http://172.28.128.100:2379/v2/members
```

* 添加节点

| ETCD_NAME | Hostname  | IP Address     |
| --------- | --------- | ---------      |
| etcd103   | Host103   | 172.28.128.103 |

在已存在的集群上注册新节点：

```sh
$ etcdctl --endpoints http://172.28.128.100:2379,http://172.28.128.101:2379,172.28.128.102:2379 member add etcd103 http://10.0.1.4:2380
$
$ etcdctl --endpoints http://172.28.128.100:2379,http://172.28.128.101:2379,172.28.128.102:2379 member list
```

修改配置，其中 Cluster State 为 `existing`，另外不需要 Token：

```sh
$ cat /etc/etcd/etcd.conf
ETCD_NAME="etcd103"
ETCD_DATA_DIR="/var/lib/etcd/etcd103"
ETCD_LISTEN_CLIENT_URLS="http://172.28.128.103:2379"
ETCD_LISTEN_PEER_URLS="http://172.28.128.103:2380"
ETCD_ADVERTISE_CLIENT_URLS="http://172.28.128.103:2379"
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://172.28.128.103:2380"
ETCD_INITIAL_CLUSTER="etcd100=http://172.28.128.100:2380,etcd101=http://172.28.128.101:2380,etcd102=http://172.28.128.102:2380,etcd103=http://172.28.128.103:2380"
ETCD_INITIAL_CLUSTER_STATE=existing
```

* 移除节点

```sh
# 获取节点 ID
$ etcdctl member list

# 移除
$ etcdctl member remove 1609b5a3a078c227
```

## 错误整理

（使用 `journalctl -xe` 查看错误日志）

由于事先测试了一下 etcd 单机版，所以在部署集群的时候该节点始终无法正常启动，需要 `所有 etcd 节点` 都删除 `/var/lib/etcd/etcdX` 目录然后再重启服务，需要注意的是所有节点都删除。另外，如果你也遇见了没有权限的问题，可以 `chown -R etcd:etcd /var/lib/etcd`。

## 参考

* [Clustering Guide](https://coreos.com/etcd/docs/2.3.7/clustering.html)

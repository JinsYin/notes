# 安装 Cassandra

## 环境

* CentOS 7.4

| IP             | DataCenter:RACK |
| -------------- | --------------- |
| 192.168.10.200 | DCHK:R1         |
| 192.168.10.201 | DCHK:R2         |
| 192.168.10.202 | DCHK:R3         |

## 要求

```sh
$ python --version
Python 2.7.5

$ java -version
openjdk version "1.8.0_171"
OpenJDK Runtime Environment (build 1.8.0_171-b10)
OpenJDK 64-Bit Server VM (build 25.171-b10, mixed mode)
```

```sh
# 先关闭防火墙，否则节点之间可能无法相互发现
$ systemctl stop firewalld
$ systemctl disable firewalld
```

## 准备数据盘

* 分区

如果 Cassandra 存储盘大于 2T，需要使用 `parted` 来分区，否则使用 `fdisk`。

```sh
$ parted /dev/sdb

# 创建 GPT 分区表
mklabel gpt

# 将整个磁盘创建一个分区（有对齐分区：从第 2048 个扇区开始）
mkpart primary xfs 2048s 100%

quit
```

* 格式化分区

```sh
mkfs -xfs /dev/sdb1
```

* 挂载存储盘

```sh
$ mkdir -p /data/cassandra

# 手动挂载
$ mount /dev/sdb1 /data/cassandra

# 设置软连接
$ ln -s /data/cassandra /var/lib/cassandra

# 开机自动挂载（必须使用 UUID，不能使用盘符，因为重启后可能发送改变）
$ blkid | grep /dev/sdb1 # 查看分区的 UUID
/dev/sdb1: UUID="b9eb1854-9cb3-446e-8d25-3b94ce051801" TYPE="xfs" PARTLABEL="primary" PARTUUID="17c66ee5-7fdb-4d9e-bb71-020e71fe5363"

$ vi /etc/fstab
UUID=b9eb1854-9cb3-446e-8d25-3b94ce051801 /data/cassandra xfs defaults 0 0
```

## CentOS

```sh
# 选择的是 Cassandra 3.0
$ vi /etc/yum.repos.d/cassandra.repo
[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/30x/ # 30x
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.apache.org/dist/cassandra/KEYS
```

```sh
# 安装 3.0.x 中的指定版本
$ yum install -y cassandra-3.0.16*

# 安装 3.0.x 中的最新版本
$ yum install -y cassandra
```

## Debian/Ubuntu

```sh
# 30x
echo "deb http://www.apache.org/dist/cassandra/debian 30x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -

sudo apt-get update

# 安装 3.0.x 中的最新版本
sudo apt-get install cassandra
```

## 配置

```sh
# 如果因某些原因启动过 Cassandra（如配置错误），必须先删除其数据
$ systemctl stop cassandra
$ rm -rf /var/lib/cassandra/data/system/*
```

```yaml
$ vi /etc/cassandra/conf/cassandra.yaml
cluster_name: 'HKCassandra'

# 一个集群一般 2 ~ 3 个 seed 节点即可，我这里设置为 3 个，以后添加节点还是保持这 3 个 seed
seed_provider:
    - class_name: org.apache.cassandra.locator.SimpleSeedProvider
      parameters:
      - seeds: "192.168.10.200,192.168.10.201,192.168.10.202"

listen_address: 192.168.10.20x # custom

# 单网卡 start #
rpc_address: 192.168.10.20x # custom
# 单网卡 end #

# 多网卡 start #
rpc_address: 0.0.0.0
broadcast_rpc_address: 192.168.10.20x
# 多网卡 end #

rpc_address: 0.0.0.0

#endpoint_snitch: SimpleSnitch
endpoint_snitch: GossipingPropertyFileSnitch
```

```yaml
# 如果 snitch 类型选择 PropertyFileSnitch，则通过该文件设置好节点的拓扑结构
$ vi /etc/cassandra/conf/cassandra-topology.properties
# Cassandra Node IP=Data Center:Rack
192.168.10.200=DCHK:R1
192.168.10.201=DCHK:R2
192.168.10.202=DCHK:R3

# default for unknown nodes
default=DCHK:R1
```

```yaml
# 如果 snitch 类型选择 GossipingPropertyFileSnitch，上面的 cassandra-topology.properties 文件可写可不写，
# 如果写了该文件会先加载它再通过 Gossiping 协议进行探测其他 seed 节点，没写的话直接通过 Gossiping 协议进行探测
# 实际上，GossipingPropertyFileSnitch 是对 PropertyFileSnitch 的一种向后兼容
# 192.168.10.201 节点所属的 Data Center 和 RACK
$ vi /etc/cassandra/conf/cassandra-rackdc.properties
dc=DCHK
rack=R2
```

如果重新创建改变了存储目录：

```sh
$ rm -rf /var/lib/cassandra

$ ln -s /data/cassandra /var/lib/cassandra

# 改变权限
$ chown cassandra:cassandra /var/lib/cassandra
```

## 启动

```sh
systemctl daemon-reload

systemctl start cassandra
systemctl status cassandra

systemctl enable cassandra
```

查看日志：

```sh
# 状态日志
$ systemctl status cassandra

# 进程启动日志
$ tail -f /var/log/cassandra/cassandra.log
```

## 状态

```sh
$ nodetool status
Datacenter: DCHK
================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address         Load       Tokens       Owns (effective)  Host ID                               Rack
UN  192.168.10.200  108.02 KB  256          65.4%             4c42d803-d256-4863-8c7c-e1ab353c5bbe  R2
UN  192.168.10.201  114.37 KB  256          66.8%             8e5ddf0d-377b-44e6-87e4-4540c7096f23  R2
UN  192.168.10.202  108.64 KB  256          67.8%             c9709cfe-c755-4073-ab02-00038257e073  R4
```

## 问题

```sh
# 节点重启后，状态一直是 DN，cassandra.log 没有错
$ tail -f /var/log/cassandra/system.log
WARN  [OptionalTasks:1] 2018-07-20 15:44:26,471 CassandraRoleManager.java:360 - CassandraRoleManager skipped default role setup: some nodes were not ready
INFO  [OptionalTasks:1] 2018-07-20 15:44:26,471 CassandraRoleManager.java:399 - Setup task failed with error, rescheduling

# 原因是防火墙导致节点之间无法通信
$ systemctl stop firewalld
$ systemctl disable firewalld
```

## 参考

* [Initializing a multiple node cluster (multiple datacenters)](https://docs.datastax.com/en/cassandra/3.0/cassandra/initialize/initMultipleDS.html)

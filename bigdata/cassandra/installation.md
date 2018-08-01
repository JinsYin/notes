# 安装 Cassandra

## 环境

* CentOS 7.4

| IP             | DataCenter:RACK |
| -------------- | --------------- |
| 192.168.10.200 | DCHK:R2         |
| 192.168.10.201 | DCHK:R2         |
| 192.168.10.202 | DCHK:R4         |

## 要求

```bash
$ python --version
Python 2.7.5

$ java --version
openjdk version "1.8.0_171"
OpenJDK Runtime Environment (build 1.8.0_171-b10)
OpenJDK 64-Bit Server VM (build 25.171-b10, mixed mode)
```

```bash
# 先关闭防火墙，否则节点之间可能无法相互发现
$ systemctl stop firewalld
$ systemctl disable firewalld
```

## CentOS

```bash
# 选择的是 Cassandra 3.0
$ vi /etc/yum.repos.d/cassandra.repo
[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/30x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.apache.org/dist/cassandra/KEYS
```

```bash
# 安装 3.0.x 中的指定版本
$ yum install -y cassandra-3.0.16*

# 安装 3.0.x 中的最新版本
$ yum install -y cassandra
```

## Debian/Ubuntu

```bash
echo "deb http://www.apache.org/dist/cassandra/debian 30x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -

sudo apt-get update

# 安装 3.0.x 中的最新版本
sudo apt-get install cassandra
```

## 配置

```bash
# 如果因某些原因启动过 Cassandra（如配置错误），必须先删除其数据
$ systemctl stop cassandra
$ rm -rf /var/lib/cassandra/data/system/*
```

```yaml
$ vi /etc/cassandra/conf/cassandra.yaml
cluster_name: 'ECassandra'

seed_provider:
    - class_name: org.apache.cassandra.locator.SimpleSeedProvider
      parameters:
      - seeds: "192.168.10.200,192.168.10.201,192.168.10.202"

listen_address: 192.168.10.20x # custom

rpc_address: 192.168.10.20x # custom

#endpoint_snitch: SimpleSnitch
endpoint_snitch: GossipingPropertyFileSnitch
```

```yaml
# 如果 snitch 类型选择 PropertyFileSnitch，则修改该文件
$ vi /etc/cassandra/conf/cassandra-topology.properties
# Cassandra Node IP=Data Center:Rack
192.168.10.200=DCHK:R2
192.168.10.201=DCHK:R2
192.168.10.202=DCHK:R4

# default for unknown nodes
default=DCHK:R2
```

```yaml
# GossipingPropertyFileSnitch
# 192.168.10.200 所属的 Data Center 和 RACK
$ vi /etc/cassandra/conf/cassandra-rackdc.properties
dc=DCHK
rack=R2
```

如果重新创建改变了存储目录：

```bash
$ rm -rf /var/lib/cassandra

$ ln -s /data/cassandra /var/lib/cassandra

# 改变权限
$ chown cassandra /var/lib/cassandra
```

## 启动

```bash
systemctl daemon-reload

systemctl start cassandra
systemctl status cassandra

systemctl enable cassandra
```

查看日志：

```bash
# 状态日志
$ systemctl status cassandra

# 进程启动日志
$ tail -f /var/log/cassandra/cassandra.log
```

## 状态

```bash
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

```bash
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
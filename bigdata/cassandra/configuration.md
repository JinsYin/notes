# Cassandra 配置

> 如果是运行在单机上不需要修改任何配置

## 默认端口

| port | 用途                 |
| ---- | -------------------- |
| 7000 |                      |
| 7001 |                      |
| 7199 | `nodetool status`    |
| 9042 | `cqlsh`。Server 端口 |
| 9160 | 9160                 |

> <https://docs.datastax.com/en/dse/6.0/dse-admin/datastax_enterprise/security/secFirewallPorts.html#secFirewallPorts__firewall_table>

## conf/cassandra.yml

```yaml
data_file_directories:
    - /var/lib/cassandra/data

ommitlog_directory: /var/lib/cassandra/commitlog

saved_caches_directory: /root/install/cassandra/saved_caches
```

```yaml
seed_provider:
    - class_name: org.apache.cassandra.locator.SimpleSeedProvider
      parameters:
      - seeds: "192.168.1.x,192.168.1.y,192.168.1.z"

listen_address: 192.168.1.x

rpc_address: 192.168.1.x
```

## conf/cassandra-topology.properties

该文件用于配置 Cassandra 节点的物理存放位置，形成网络拓扑结构。以便在设置数据副本策略时可以使用智能的 `NetworkTopologyStrategy` 以最小化数据故障，而不是使用普通的 `SimpleStrategy`。

```yaml
# CassandraNodeIP=DataCenter:Rack
192.168.1.100=DC1:RAC1
192.168.2.200=DC2:RAC2

10.0.0.10=DC1:RAC1
10.0.0.11=DC1:RAC1
10.0.0.12=DC1:RAC2

10.20.114.10=DC2:RAC1
10.20.114.11=DC2:RAC1

10.21.119.13=DC3:RAC1
10.21.119.10=DC3:RAC1

10.0.0.13=DC1:RAC2
10.21.119.14=DC3:RAC2
10.20.114.15=DC2:RAC2

# default for unknown nodes
default=DC1:r1

# Native IPv6 is supported, however you must escape the colon in the IPv6 Address
# Also be sure to comment out JVM_OPTS="$JVM_OPTS -Djava.net.preferIPv4Stack=true"
# in cassandra-env.sh
fe80\:0\:0\:0\:202\:b3ff\:fe1e\:8329=DC1:RAC3
```

## Snitch

* SimpleSnitch
* GossipingPropertyFileSnitch

## Kernel 配置

### 修改 open files

```bash
# 临时修改
$ ulimit -n 102400
$ ulimit -n
$ ulimit –a
```

## docker修改全局的ulimit （<type>=<soft limit>[:<hard limit>]）

## nofile: 最大文件打开数，nproc：最大进程数

```bash
docker -d --default-ulimit nofile=20480:40960 (nproc=1024:2048)
```
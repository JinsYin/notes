# nodetool 工具

## 常用命令

```plaintext
nodetool [(-p <port> | --port <port>)]
        [(-pwf <passwordFilePath> | --password-file <passwordFilePath>)]
        [(-h <host> | --host <host>)] [(-u <username> | --username <username>)]
        [(-pw <password> | --password <password>)] <command> [<args>]
```

| 命令                  | 用途                                  |
| --------------------- | ------------------------------------- |
| stopdaemon            | 停止 Cassandra 守护进程               |
| decommision           | 移除当前节点，并将数据复制到其他 Peer |
| describecluster       | 查看集群信息                          |
| describering KEYSPACE | 查看圆环的节点信息                    |
| ring                  |                                       |
| flush                 | 将 memtable 的数据刷新到 sstable      |

## 查看集群信息

```bash
$ nodetool describecluster
Cluster Information:
    Name: ECassandra
    Snitch: org.apache.cassandra.locator.DynamicEndpointSnitch
    Partitioner: org.apache.cassandra.dht.Murmur3Partitioner
    Schema versions:
        c2a2bb4f-7d31-3fb8-a216-00b41a643650: [192.168.10.200, 192.168.10.201, 192.168.10.202]
```

## 查看 Keyspace 的圆环节点信息

```bash
# CREATE KEYSPACE myspace WITH replication={'class': 'SimpleStrategy', 'replication_factor': 2}
$ nodetool decribering myspace
TokenRange(start_token:-20581068291495794, end_token:-14728228113595374, endpoints:[192.168.10.201, 192.168.10.200], rpc_endpoints:[192.168.10.201, 192.168.10.200], endpoint_details:[EndpointDetails(host:192.168.10.201, datacenter:DCHK, rack:R2), EndpointDetails(host:192.168.10.200, datacenter:DCHK, rack:R2)])
TokenRange(start_token:1169641425555922916, end_token:1184507756664100600, endpoints:[192.168.10.200, 192.168.10.201], rpc_endpoints:[192.168.10.200, 192.168.10.201], endpoint_details:[EndpointDetails(host:192.168.10.200, datacenter:DCHK, rack:R2), EndpointDetails(host:192.168.10.201, datacenter:DCHK, rack:R2)])
TokenRange(start_token:-1710398741676387412, end_token:-1660663211441278613, endpoints:[192.168.10.202, 192.168.10.200], rpc_endpoints:[192.168.10.202, 192.168.10.200], endpoint_details:[EndpointDetails(host:192.168.10.202, datacenter:DCHK, rack:R4), EndpointDetails(host:192.168.10.200, datacenter:DCHK, rack:R2)])
TokenRange(start_token:-8371557560962077843, end_token:-8315370236528078734, endpoints:[192.168.10.202, 192.168.10.200], rpc_endpoints:[192.168.10.202, 192.168.10.200], endpoint_details:[EndpointDetails(host:192.168.10.202, datacenter:DCHK, rack:R4), EndpointDetails(host:192.168.10.200, datacenter:DCHK, rack:R2)])
......
```

## 移除节点

```bash
# 若节点状态为 UN
$ nodetool decommission
```

```bash
# 若节点状态为 DN（或者关闭进程：systemctl stop cassandra）
$ nodetool removenode -- {<status>|<force>|<ID>}
```

选项：

* status：
* force：
* ID：已 Down 节点的 UUID（不能自己移除自己）

```bash
# 如果 nodetool removenode 失败
$ nodetool assassinate
```

## 参考

* [Cassandra 运维工具](https://blog.csdn.net/zrtlin/article/details/60763413)
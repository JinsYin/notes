# 修改节点 IP

## 流程

1. 运行 `nodetool drain`；
2. 停止服务 `systemctl stop cassandra`；
3. 在 `cassandra.yaml` 中修改 IP 地址
   * listen_address
   * broadcast_address
   * rpc_address （如果设置了的话）
4. 如果该节点是 seed 节点（一般 2 ~ 3 个），需要在所有节点更新 `cassandra.yaml` 文件中 `seed_provider` 栏的 `- seeds` 参数；
5. 如果 `endpoint_snitch` 选择的是 `PropertyFileSnitch`，需要在所有节点的 `cassandra-topology.properties` 文件中添加新的 IP 地址；
6. 改变本机 IP（如果是选择另一个网络设备则忽略）并重启服务 `systemctl start cassandra`；
7. 如果使用的是 `PropertyFileSnitch`，则执行滚动重启。

## 实操

下面以改变 `192.168.10.200`（千兆）为 `192.168.100.200`（万兆）为例：

```sh
# 脑裂
$ nodetool drain

# 停止服务
$ systemctl stop cassandra

# 修改配置，由于我采用的是 GossipingPropertyFileSnitch 所以不用改 cassandra-topology.properties
$ sed -i 's|192.168.10.200|192.168.100.200|g' /etc/cassandra/conf/cassandra.yaml

# 启动服务
$ systemctl start cassandra
```

```sh
# 最后待所有 seed 节点都更改完成后，更新所有节点（包括 seed 节点）的配置，不需要重启服务
$ sed -i 's|seeds: "192.168.10.200,192.168.10.201,192.168.10.202"|seeds: "192.168.100.200,192.168.100.201,192.168.100.202"|g' /etc/cassandra/conf/cassandra.yaml
```

## 参考

* [Changing the IP address of a node](https://docs.datastax.com/en/dse/5.1/dse-admin/datastax_enterprise/operations/opsChangeIp.html)

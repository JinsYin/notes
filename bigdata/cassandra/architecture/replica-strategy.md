# 复制策略（Replica Strategy）

副本策略决定了在哪些节点放置数据的其他 replica 。

* `SimpleStrategy` - 仅限于单个数据中心（DataCenter）和单个机架（Rack）
* `NetworkTopologyStrategy` - 适用于多个数据中心或单个数据中心多机架的情形；强烈推荐使用这种策略，因为它更利于在未来扩展到多个数据中心

## SimpleStrategy 策略

```sql
CREATE KEYSPACE dw WITH replication = {'class': 'SimpleStrategy', ‘replication_factor' : 3}
```

**SimpleStrategy** 策略将第一个副本放在有分区器（`partitioner`）确定的节点上，额外的副本放置在 `环` 中 `顺时针` 的下一个节点上，而不考虑拓扑（机架或数据中心的位置）。

查看节点状态和相关环的信息：

```sh
# 除第一个 Token 外，其他是从小到大的顺序排列的，而第一 Token 是最后一个 Token 的值，所以组成了一个环
$ nodetool ring | head -n 15
Datacenter: DCHK
==========
Address          Rack        Status State   Load            Owns                Token
                                                                                9130949731203775915
192.168.100.202  R3          Up     Normal  924.64 GB       69.21%              -9216963451953982562
192.168.100.202  R3          Up     Normal  924.64 GB       69.21%              -9106410662364002344
192.168.100.201  R2          Up     Normal  862.31 GB       65.08%              -9092861270347811784
192.168.100.200  R1          Up     Normal  872.61 GB       65.70%              -9070021370026043934
192.168.100.202  R3          Up     Normal  924.64 GB       69.21%              -9068499655225300921
192.168.100.200  R1          Up     Normal  872.61 GB       65.70%              -9054055892331851203
192.168.100.201  R2          Up     Normal  862.31 GB       65.08%              -8990740403073328847
192.168.100.201  R2          Up     Normal  862.31 GB       65.08%              -8953625771538267511
192.168.100.200  R1          Up     Normal  872.61 GB       65.70%              -8940169917998909711
192.168.100.201  R2          Up     Normal  862.31 GB       65.08%              -8938060385592030785
```

可以发现每台机器在环中的数目均一致：

```sh
$ nodetool ring | grep 192.168.100.200 | wc -l
256

$ nodetool ring | grep 192.168.100.201 | wc -l
256

$ nodetool ring | grep 192.168.100.202 | wc -l
256
```

## NetworkTopologyStrategy 策略

```sql
CREATE KEYSPACE dw WITH replication = {'class': 'NetworkTopologyStrategy', 'DC-SH' : 2, 'DC-BG' : 2}
```

## 参考

* [An Intro to Cassandra and NetworkTopologyStrategy](https://www.onsip.com/blog/intro-to-cassandra-and-networktopologystrategy)

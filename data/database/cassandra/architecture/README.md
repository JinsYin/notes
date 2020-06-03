# 架构

* Masterless

## Cassandra Terminology

* Node (Vnode)
* Cluster
* Data Center
* Partition
* Gossip
* Snitch
* Replication Factor
* Consistency

## 节点间通信（gossip）

* Gossip 是一个点对点的通信协议，通过该协议节点间周期性地交换它们的信息以及它们知道的其它节点的信息
* Cassandra 使用 gossip 协议来发现集群中其他节点的位置和状态信息

## 负载均衡

* Round Robin
* DC-Aware Round Robin
* Token-Aware

## 数据分发和副本

* Murmur3Partitioner

## 数据分区策略

* Random partitioning - 默认推荐策略
* Ordered partitioning

## Snitch

Snitch 定义了复制策略用来放置 replicas 和路由请求所使用的拓扑信息。

Snitch 用于让每个节点知道自己的位置（DataCenter、Rack）。

Snitch 类型：

| Type                        | 描述                                                                                                                                                               |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| SimpleSnitch                | 用于单个 DataCentoer 或 Zone                                                                                                                                       |
| RackInferringSnitch         |                                                                                                                                                                    |
| PropertyFileSnitch          | 用户通过 `cassandra-topology.properties` 文件自定义的网络拓扑结构                                                                                                  |
| GossipingPropertyFileSnitch | 通过 `cassandra-rackdc.properties` 文件定义当前节点的                                                   DataCenter 和 Rack；通过 gossip 广播节点位置信息给其他节点 |
| Amazon Snitches             | EC2Snitch/EC2MultiRegionSnitch                                                                                                                                     |

## 参考

* [Cassandra 在饿了么的应用](http://oscogozpr.bkt.clouddn.com/Cassandra%E5%9C%A8%E9%A5%BF%E4%BA%86%E4%B9%88%E7%9A%84%E5%BA%94%E7%94%A8.pdf)
* [Understanding the architecture](https://docs.datastax.com/en/cassandra/3.0/cassandra/architecture/archTOC.html)
* [Apache Cassandra and DataStax Enterprise Explained with Peter Halliday at WildHacks NU](https://www.slideshare.net/planetcassandra/apache-cassandra-and-datastax-enterprise-explained-with-peter-halliday-at-wildhacks-nu)

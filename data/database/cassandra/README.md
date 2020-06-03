# Cassandra

Cassandra 是一个高可扩展性的分区行存储。

## Snitch

* SimpleSnitch
* GossipingPropertyFileSnitch（推荐）
* org.apache.cassandra.locator.DynamicEndpointSnitch

## 副本策略（Replication Strategy）

* Simple Strategy
* Network Topology Strategy（推荐）

## 节点状态

* UN：Up
* UL：
* DN：Down

## 参考

* [Datastax Doc](https://docs.datastax.com/en/)
* [DDAC Doc](https://docs.datastax.com/en/ddac/doc/)
* [Cassandra Tutorial](https://www.tutorialspoint.com/cassandra/)

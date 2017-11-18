# Kafka 从入门到放弃

## 基本术语

* Record

Kafka 发布或者订阅的内容，即消息（Record）。每条消息由 `key`、`value`、`时间戳` 构成。

* Topic

Kafka 将消息分门别类，一个类别就是一个主题（Topic）。

* Producer

发布消息的对象，即生产者（Producer）。

* Consumer

订阅、接受消息的对象，即消费者（Consumer）。

* Broker

Kafka 集群由一组存储消息的服务器组成，一个服务器对应一个 Broker。

* Partition

一个 Topic 通常对应多个分区（Partition），发布到同一个 Topic 的消息可能分布在不同 broker 的不同分区，一个分区实际上就是一个 log 目录。分区决定了并行处理的能力。

* Offset

Kafka 集群默认保存消息 7 天，在此期间无论消息是否被消费了消息都不会被删除。

* Replication

副本机制决定了 Kafka 集群的高可用。一个分区有一个 leader，其他分区都将作为 follower。


## 注意

* Java API 在消费的时候，如果没有事先创建 topic，系统会自动创建。
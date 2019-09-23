# 基本概念

## Record

Kafka 发布或者订阅的内容，即消息（Record）。每条消息由 `key`、`value`、`时间戳` 组成。

## Topic

Kafka 将消息分门别类，一个类别就是一个主题（Topic）。

## Producer

发布消息的对象，即生产者（Producer）。

## Consumer

订阅、接受消息的对象，即消费者（Consumer）。

## Broker

Kafka 集群由一组存储消息的服务器组成，一个服务器对应一个 Broker。

## Partition

一个 Topic 通常对应多个分区（Partition），发布到同一个 Topic 的消息可能分布在不同 Broker 的不同分区，一个分区实际上就是一个 log 目录。分区数决定了并行处理的能力。

## Offset

分区中的每条消息都分配了一个顺序 ID，用于唯一标识分区中的每一条消息，称作 `offset`。不同的分区之间存在相同的 `offset`。

Kafka 集群默认将消息保存 `7` 天，在此期间无论消息是否被消费了消息都不会被删除。

## Replication

副本机制决定了 Kafka 集群的高可用。一个分区有一个 `leader`，其他分区都将作为 `follower`。

# Kafka 入门

## 配置

```bash
$ cat config/server.properties
```

> * broker.id=100 # 每个 broker 都有唯一的 id，设置为 -1 表示自动分配
>
> * listeners=PLAINTEXT://192.168.1.100:9092 # 监听的主机和端口
>
> * advertised.listeners=PLAINTEXT://192.168.1.100:9092 # 广播的主机的端口
>
> * log.dirs=/data/kafka/logs
>
> * num.partitions=4 # 每个 topic 的默认日志分区数
>
> * zookeeper.connect=10.0.0.1:2181,10.0.0.2:2181,10.0.0.3:2181/kafka # 集群的话最少 3 个节点，如果不指定 znode 默认是 /

以下操作假设已经在 `.100`, `.101`, `.102` 节点上分别部署了一个 broker，在 `.1`, `.2`, `.3` 节点上分别部署 zookeeper。


## 启动

* 运行 zookeeper（可选）

```bash
$ bin/zookeeper-server-start.sh [-daemon] config/zookeeper.properties # -daemon 后台运行
```

* 运行 kafka

```bash
$ bin/kafka-server-start.sh [-daemon] config/server.properties
```


## 实验

* 创建 topic

必须要指定副本数 `--replication-factor` 和日志分区数 `--partions`，并且副本数不能超过 broker 的数量。

```bash
$ bin/kafka-topics.sh --zookeeper 10.0.0.1:2181,10.0.0.2:2181,10.0.0.3:2181/kafka --create  --topic test --replication-factor 2 --partitions 4
```

* 查看 topic

```bash
$ # 列出所有 topic
$ bin/kafka-topics.sh --zookeeper 10.0.0.1:2181,10.0.0.2:2181,10.0.0.3:2181/kafka --list
```

```bash
$ # 查看 topic 详情，如每个日志分区的分布
$ bin/kafka-topics.sh --zookeeper 10.0.0.1:2181,10.0.0.2:2181,10.0.0.3:2181/kafka --describe --topic test

$ # 查看日志分区等信息
$ ll /data/kafka/logs 
cleaner-offset-checkpoint  meta.properties  recovery-point-offset-checkpoint  replication-offset-checkpoint
```

* 发布消息

```bash
$ bin/kafka-console-producer.sh --broker-list 192.168.1.101:9092,192.168.1.102:9092,192.168.1.103:9092 --topic test
```

* 订阅消息

```bash
$ bin/kafka-console-consumer.sh --zookeeper 10.0.0.1:2181,10.0.0.2:2181,10.0.0.3:2181/kafka --topic test [--from-beginning]
```
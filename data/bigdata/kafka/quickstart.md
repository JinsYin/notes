# Kafka 入门

## 安装

```sh
SCALA_VERSION="2.11"
KAFKA_VERSION="2.0.0"

rm -rf /tmp/kafka* && mkdir -p /tmp/kafka
curl -L http://www.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -o /tmp/kafka.tgz

tar -zxf /tmp/kafka.tgz -C /tmp/kafka --strip-components=1

cd /tmp/kafka
```

## Single-broker

Kafka 需要使用 Zookeeper 作为服务发现，所以必须先启动 Zookeeper 服务。作为测试，可以使用 Kafka 包中的 Zookeeper 脚本启动一个单节点的 Zookeeper 实例。

* 启动 Zookeeper

```sh
$ bin/zookeeper-server-start.sh [-daemon] config/zookeeper.properties
[2018-11-16 09:53:45,937] INFO binding to port 0.0.0.0/0.0.0.0:2181 (org.apache.zookeeper.server.NIOServerCnxnFactory)
```

* 启动 Kafka

```sh
# 监听在所有网卡，广告到 192.168.10.199
sed -i 's|#listeners=PLAINTEXT://:9092|listeners=PLAINTEXT://:9092|g' config/server.properties
sed -i 's|#advertised.listeners=.*|advertised.listeners=PLAINTEXT://192.168.10.199:9092|g' config/server.properties
```

```sh
# zookeeper znode 为 "/"
$ bin/kafka-server-start.sh [-daemon] config/server.properties
[2018-11-16 09:54:56,817] INFO Awaiting socket connections on 0.0.0.0:9092. (kafka.network.Acceptor)
```

* 验证

```sh
$ netstat -tpln | grep "9092" # lsof -nP -iTCP:9092
tcp6    0   0 :::9092   :::*    LISTEN  4627/java
```

## 示例

* 创建 topic

```sh
$ bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
Created topic "test".
```

> 必须指定副本数（--replication-factor）和日志分区数（--partitions），且副本数不得超过 broker 的数量

* 查看 topic

```sh
# 查看所有 topic
$ bin/kafka-topics.sh --list --zookeeper localhost:2181
test
```

```sh
# 查看 topic 详情
$ bin/kafka-topics.sh --describe --topic test --zookeeper localhost:2181
Topic:test  PartitionCount:1    ReplicationFactor:1 Configs:
    Topic: test Partition: 0    Leader: 0   Replicas: 0 Isr: 0
```

* 发布消息

```sh
# 启动一个消费者，它从文件或 stdin 获取输入，并发送给 Kafka 集群
$ bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
> This is a message
> This is another message
```

* 订阅消息

```sh
# 启动一个消费者，它将消息转储到 stdout
$ bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test [--from-beginning]
```

* 日志数据

```sh
# 存储日志文件的目录（路径取决于 config/server.properties 中的 log.dirs 参数）
$ tree -L 2 /tmp/kafka-logs/
├── __consumer_offsets-8
│   ├── 00000000000000000000.index
│   ├── 00000000000000000000.log
│   ├── 00000000000000000000.timeindex
│   └── leader-epoch-checkpoint
├── ......
├── __consumer_offsets-9
│   ├── 00000000000000000000.index
│   ├── 00000000000000000000.log
│   ├── 00000000000000000000.timeindex
│   └── leader-epoch-checkpoint
├── log-start-offset-checkpoint
├── meta.properties
├── recovery-point-offset-checkpoint
├── replication-offset-checkpoint
└── test-0
    ├── 00000000000000000000.index
    ├── 00000000000000000000.log
    ├── 00000000000000000000.timeindex
    ├── 00000000000000000002.snapshot
    └── leader-epoch-checkpoint
```

## Multi-Broker

* 配置

```sh
cp config/server.properties config/server-1.properties
cp config/server.properties config/server-2.properties
```

```sh
# 监听在所有网口，广播到 192.168.10.199
sed -i 's|broker.id=0|broker.id=1|g' config/server-1.properties
sed -i 's|#listeners=PLAINTEXT://:9092|listeners=PLAINTEXT://:9093|g' config/server-1.properties
sed -i 's|#advertised.listeners=.*|advertised.listeners=PLAINTEXT://192.168.10.199:9093|g' config/server-1.properties
sed -i 's|log.dirs=/tmp/kafka-logs|log.dirs=/tmp/kafka-logs-1|g' config/server-1.properties
```

```sh
# 监听在所有网口，广播到 192.168.10.199
sed -i 's|broker.id=0|broker.id=2|g' config/server-2.properties
sed -i 's|#listeners=PLAINTEXT://:9092|listeners=PLAINTEXT://:9094|g' config/server-2.properties
sed -i 's|#advertised.listeners=.*|advertised.listeners=PLAINTEXT://192.168.10.199:9094|g' config/server-2.properties
sed -i 's|log.dirs=/tmp/kafka-logs|log.dirs=/tmp/kafka-logs-2|g' config/server-2.properties
```

* 启动

```sh
# 保持之前启动的服务
bin/kafka-server-start.sh -daemon config/server-1.properties
bin/kafka-server-start.sh -daemon config/server-2.properties
```

* 验证

```sh
$ netstat -tpln | grep -E "9092|9093|9094"
tcp6    0   0 :::9094   :::*    LISTEN  6838/java
tcp6    0   0 :::9093   :::*    LISTEN  14199/java
```

创建带三个副本的 topic：

```sh
# 共生成 2 × 4 个分区，即 8 个目录；三个 broker 的分区数应该是 3、3、2
$ bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 2 --partitions 4 --topic mytopic
Created topic "mytopic".
```

```sh
$ bin/kafka-topics.sh --describe --topic mytopic --zookeeper localhost:2181
Topic:mytopic   PartitionCount:4    ReplicationFactor:2 Configs:
    Topic: mytopic  Partition: 0    Leader: 2   Replicas: 2,1   Isr: 2,1
    Topic: mytopic  Partition: 1    Leader: 0   Replicas: 0,2   Isr: 0,2
    Topic: mytopic  Partition: 2    Leader: 1   Replicas: 1,0   Isr: 1,0
    Topic: mytopic  Partition: 3    Leader: 2   Replicas: 2,0   Isr: 2,0
```

说明：

* `Leader` - 负责当前分区的所有读写的节点；比如第二行的 `Leader: 0` 表示：分区 `0` 中负责读写的节点为 broker.id=2 的节点
* `Replicas` - 当前分区日志的主副节点列表；比如第二行的 `Replicas: 2,1` 表示：分区 `0` 的日志数据存放到了 broker.id=2 和 broker.id=1 节点上
* `isr` - "in-sync" Replicas 的集合，它是 Replicas 的子集

干掉 Broker 1：

```sh
$ ps aux | grep server-1.properties
root      6516  1.2 10.8 7227704 860568 pts/2  Sl   11:49   2:55 /usr/lib/jvm/jre-1.8.0-openjdk/bin/java

$ kill -9 6516
```

再次查看 Topic 详情：

```sh
# Broker 1 不再处于 in-sync 副本集中
$ bin/kafka-topics.sh --describe --topic mytopic --zookeeper localhost:2181
Topic:mytopic   PartitionCount:4    ReplicationFactor:2 Configs:
    Topic: mytopic  Partition: 0    Leader: 2   Replicas: 2,1   Isr: 2
    Topic: mytopic  Partition: 1    Leader: 0   Replicas: 0,2   Isr: 0,2
    Topic: mytopic  Partition: 2    Leader: 0   Replicas: 1,0   Isr: 0
    Topic: mytopic  Partition: 3    Leader: 2   Replicas: 2,0   Isr: 2,0
```

## 使用 Kafka Connect 导入导出数据

## 使用 Kafka Streams 处理数据

## 参考

* [Kafka Quickstart](https://kafka.apache.org/quickstart)

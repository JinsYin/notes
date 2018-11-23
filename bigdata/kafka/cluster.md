# Kafka 集群（multi-broker）

如何安装 Zookeeper 集群，请参照 Zookeeper 集群搭建任务。因为 Kafka 集群需要依赖 Zookeeper 服务，虽然 Kafka 有内置 Zookeeper，但是还是建议独立安装 Zookeeper 集群服务，此处不再赘述。

| 集群      | 主机                                      |
| --------- | ----------------------------------------- |
| kafka     | 192.168.1.121 192.168.1.122 192.168.1.126 |
| zookeeper | 192.168.1.121 192.168.1.122 192.168.1.126 |

## 安装

```bash
SCALA_VERSION="2.11"
KAFKA_VERSION="2.0.1"

rm -rf /tmp/kafka* && mkdir -p /usr/share/kafka

curl -L http://www.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -o /tmp/kafka.tgz

tar -zxf /tmp/kafka.tgz -C /usr/share/kafka --strip-components=1

rm -rf /tmp/kafka*
```

## 配置

```ini
# 192.168.1.121
$ vi /usr/share/kafka/config/server.properties
broker.id=1 # 每个 broker 都必须有唯一的 id，设置为 -1 表示自动分配
listeners=PLAINTEXT://192.168.1.121:9092 # 监听的 Host:Port
advertised.listeners=PLAINTEXT://192.168.1.121:9092 # 广播的 Host:Port
log.dirs=/data/kafka/logs
num.partitions=4 # 每个 topic 的默认日志分区数
zookeeper.connect=192.168.1.121:2181,192.168.1.122:2181,192.168.1.124:2181 # znode 默认是 "/"
```

```ini
# 192.168.1.122
$ vi /usr/share/kafka/config/server.properties
broker.id=1
listeners=PLAINTEXT://192.168.1.122:9092
advertised.listeners=PLAINTEXT://192.168.1.122:9092
log.dirs=/data/kafka/logs
num.partitions=4
zookeeper.connect=192.168.1.121:2181,192.168.1.122:2181,192.168.1.124:2181
```

```ini
# 192.168.1.124
$ vi /usr/share/kafka/config/server.properties
broker.id=1
listeners=PLAINTEXT://192.168.1.124:9092
advertised.listeners=PLAINTEXT://192.168.1.124:9092
log.dirs=/data/kafka/logs
num.partitions=4
zookeeper.connect=192.168.1.121:2181,192.168.1.122:2181,192.168.1.124:2181
```

## 运行

```bash
vi /etc/systemd/system/kafka-zookeeper.service
[Unit]
Description=Apache Zookeeper server (Kafka)
Documentation=http://zookeeper.apache.org
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
User=nano
Group=nano
Environment=JAVA_HOME=/usr/java/jdk1.8.0_102
ExecStart=/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties
ExecStop=/opt/kafka/bin/zookeeper-server-stop.sh

[Install]
WantedBy=multi-user.target
```

```bash
$ vi /etc/systemd/system/kafka.service
[Unit]
Description=Apache Kafka server (broker)
Documentation=http://kafka.apache.org/documentation.html
Requires=network.target remote-fs.target
After=network.target remote-fs.target kafka-zookeeper.service

[Service]
Type=simple
User=nano
Group=nano
Environment=JAVA_HOME=/usr/java/jdk1.8.0_102
ExecStart=/usr/share/kafka/bin/kafka-server-start.sh /usr/share/kafka/config/server.properties
ExecStop=/opt/kafka/bin/kafka-server-stop.sh

[Install]
WantedBy=multi-user.target
```

## 示例

在 kafka 中创建名为 “121_test__topic1” 的 topic，该 topic 切分为 4 份，每一份备份数为 3

```bash
$ /usr/share/kafka/kafka-topics.sh --create --zookeeper 192.168.1.121:2181 --replication-factor 3 --partitions 4 --topic  121_test_topic1
```

列出所有 topic:

```bash
$ /usr/share/kafka/kafka-topics.sh --list --zookeeper 192.168.1.121:2181,192.168.1.122:2181,192.168.1.126:2181
```

> https://gist.github.com/vipmax/9ceeaa02932ba276fa810c923dbcbd4f
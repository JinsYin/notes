# Kafka 集群

如何安装 Zookeeper 集群，请参照 Zookeeper 集群搭建任务。因为 Kafka 集群需要依赖 Zookeeper 服务，虽然 Kafka 有内置 Zookeeper，但是还是建议独立安装 Zookeeper 集群服务，此处不再赘述。

| 集群        | 主机                                       |
| --------- | ---------------------------------------- |
| kafka     | 192.168.1.121 192.168.1.122 192.168.1.126 |
| zookeeper | 192.168.1.121 192.168.1.122 192.168.1.126 |


### 1. kafka 官网下载 kafka_2.10-0.10.0.1.tgz 压缩包，解压缩
   重命名为 kafka-0.10.0.1
### 2.修改 /root/Cloud /kafka-0.10.0.1/config/server.properties 文件：

## 192.168.1.121

```
broker.id=1
listeners=PLAINTEXT://192.168.1.121:9092
advertised.listeners=PLAINTEXT://192.168.1.121:9092
log.dirs=/data/kafka/logs
num.partitions=4
zookeeper.connect=192.168.1.121:2181,192.168.1.122:2181,192.168.1.124:2181
```
其他配置暂时采取默认

![png1](https://github.com/wangruofanWRF/notes/blob/master/kafka/png/png1.png)
![png2](https://github.com/wangruofanWRF/notes/blob/master/kafka/png/png2.png)
![png3](https://github.com/wangruofanWRF/notes/blob/master/kafka/png/png3.png)

r   192.168.1.122机器：
```bash
    broker.id=2
    listeners=PLAINTEXT://192.168.1.122:9092
advertised.listeners=PLAINTEXT://192.168.1.122:9092
   log.dirs=/data/kafka/logs
    num.partitions=4
    zookeeper.connect=192.168.1.121:2181,192.168.1.122:2181,192.168.1.124:2181
```
其他配置暂时采取默认

![png4](https://github.com/wangruofanWRF/notes/blob/master/kafka/png/png4.png)
![png5](https://github.com/wangruofanWRF/notes/blob/master/kafka/png/png5.png)
![png6](https://github.com/wangruofanWRF/notes/blob/master/kafka/png/png6.png)

   192.168.1.126机器：
```bash
    broker.id=3
    listeners=PLAINTEXT://192.168.1.126:9092
advertised.listeners=PLAINTEXT://192.168.1.126:9092
   log.dirs=/data/kafka/logs
    num.partitions=4
    zookeeper.connect=192.168.1.121:2181,192.168.1.122:2181,192.168.1.124:2181
```
其他配置暂时采取默认

![png7](https://github.com/wangruofanWRF/notes/blob/master/kafka/png/png7.png)
![png8](https://github.com/wangruofanWRF/notes/blob/master/kafka/png/png8.png)
![png9](https://github.com/wangruofanWRF/notes/blob/master/kafka/png/png9.png)

### 3、在每台服务器分别启动 kafka 服务：
```bash
   ./kafka-server-start.sh  /root/Cloud/kafka-0.10.0.1/config/server.properties &
```

### 4、任意一台机器上面（此处选择 192.168.1.121 ），测试：       
在 kafka 中创建名为 “121_test__topic1” 的 topic，该 topic 切分为 4 份，每一份备份数为 3
```bash
./kafka-topics.sh --create --zookeeper 192.168.1.121:2181 --replication-factor 3 --partitions 4 --topic  121_test__topic1
```

### 5、列出所有 topic :
```bash
./kafka-topics.sh --list --zookeeper 192.168.1.121:2181,192.168.1.122:2181,192.168.1.126:2181
```
![png10](https://github.com/wangruofanWRF/notes/blob/master/kafka/png/png10.png)


## 作者

本文档由 `xxx` 创建，由 `尹仁强`、`王若凡` 整理。

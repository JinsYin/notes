# 部署 Kafka Manager

在 192.168.1.121 上


## 安装 sbt

```bash
$ curl https://bintray.com/sbt/rpm/rpm > bintray-sbt-rpm.repo
$ sudo mv bintray-sbt-rpm.repo /etc/yum.repos.d/
$ sudo yum install -y sbt
```


## 安装 kafka manager

默认下载最新版（kafka-manager-1.3.1.6）

```bash
$ git clone https://github.com/yahoo/kafka-manager
```

```bash
$ cd kafka-manager
```

```bash
$ sbt clean dist # 编译需要很长时间
$ ls -l target/universal/kafka-manager-1.3.1.6.zip # 编译好的文件
``` 

解压上图中的 zip 文件

```bash
$ unzip kafka-manager-1.3.1.6.zip
$ cd kafka-manager-1.3.1.6
```

修改 conf/application.conf 

![Kafka Manager Config](./img/kafka-manager-config.png)

即：kafka-manager.zkhosts="192.168.1.121:2181,192.168.1.122:2181,192.168.1.124:2181"  
kafka-manager.zkhosts Zookeeper 集群的 hostname 和端口
 
启动 kafka manager

```bash
$ bin/kafka-manager
```


## Kafka Manager 的 Web 端

启动之后、默认启动的端口是 9000（可更改），在浏览器访问这个地址 http://192.168.1.121:9000 ,然后自己添加一个集群。  
其中 Cluster Zookeeper Hosts 为 Zookeeper 集群的 hostname 和端口。

![Kafka Manager Web Cluster](./img/kafka-manager-web-cluster.md)

然后就可以看集群的 Brokers，Topic 以及每个 Topic 的详细信息等，如下：  

Brokers 信息：

![Kafka Manager Web Brokers](./img/kafka-manager-web-brokers.md)

Topic 列表信息：

![Kafka Manager Topic List](./img/kafka-manager-web-topic-list.png)

特定 Topic 的详细信息：

![Kafka Manager Topic Detail](./img/kafka-manager-web-topic-detail.png)


## 作者

本文档由 `xxx` 创建，由 `尹仁强`、`王若凡` 整理。

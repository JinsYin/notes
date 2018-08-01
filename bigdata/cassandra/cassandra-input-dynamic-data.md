# 船舶动态数据导入 Cassandra

经过将近两个月的探索，为了将博懋三年数据导入 Cassandra ，尝试了多种方法，主要包括：  


## Cassandra bulkload

官方建议这种方式导入大数据，该方式导入速度极其快，并且需要自己编写代码产生 sstables 文件，每次导入完毕且成功后，会有 summary 提示该次已导入多少行，多少时间。
当我们使用该方式时，发现由于内存限制，每次导入的 Cassandra sstables 数量不能过多，并且当 Cassandra 数据库数据量太大时， summary 需要等待很长的时间才会出现，导致不知道是否导入成功。

> svn: svn://192.168.1.30/hzl/ganghang_bulkload  


## Cassandra COPY

适合将 csv 文件导入到 Cassandra，但文件不宜过大，当我们尝试导入一亿条时，包超时异常。

```
COPY mtb.target_history_0 (unique_id, acquisition_time, target_type, data_source, data_supplier,status,longitude, latitude,area_id, speed, conversion, cog,true_head, power, ext,extend) FROM '/root/data6T/threeData/201509/part-00000' with HEADER='false';
```

## Cassandra Spark Connector

该方式是 datastax 提供的 Cassandra 和 Spark 交互的方式，需要加载 xxx-xxx-connector.jar 包，通过该方式，需要制定多个参数。由于前两种方式导入失败，我们最终选用了该方式，并对参数进行了如下配置：

```scala
new SparkContext(true).set("output.throughput_mb_per_sec", "20")
	.set("spark.cassandra.output.concurrent.writes", "20")
	.set("spark.cassandra.connection.keep_alive_ms", "12000")
	.set("spark.cassandra.output.batch.grouping.key", "None")
```

设置 executor-cores 40，这样，我们 Cassandra 6 个节点能够抗住 Spark 的并行读写，巅峰的时候并发 write-request=2600 多。
经过摸索，我们对 Cassandra 的配置参数进行了优化：  

1. 搭建 opscenter 监控 Cassandra 集群状态，注意：由于我们没有使用 datastax 提供的 Cassandra ,有些地方不兼容，请不要使用 opscenter 配置 Cassandra 配置文件。  

2. 对参数调优：  

> * 调整 Cassandra 的写线程数： 64  
> * 调整 Cassandra 的写超时数: 12000
> * 调整 Cassandra 的堆内存占用量: ( 系统内存 - 40 ) g

配置 解决 too many open files 错误  

> http://docs.datastax.com/en/cassandra/3.0/cassandra/troubleshooting/trblshootInsufficientResources.html 


## 作者

本文档有 `胡作梁` 创建，有 `尹仁强` 参与整理。
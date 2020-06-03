# Flink 集成 Hadoop

目前，Flink 默认不再和 Hadoop 绑定。如果需要使用 Hadoop 功能（如 YARN、HDFS），必须集成 Hadoop 。

## 引用 Hadoop 配置

```sh
export HADOOP_CONF_DIR=/path/to/etc/hadoop
```

> 实际验证发现不可行

## 提供 Hadoop class

支持两种方式：

1. 添加 Hadoop classpath 到 Flink （推荐）
2. 下载 [jar 文件](https://flink.apache.org/downloads.html#additional-components) 并添加到 Flink 二进制发行版的 `lib/` 目录

## 本地运行任务

Maven `pom.xml` ：

```xml
<dependency>
    <groupId>org.apache.hadoop</groupId>
    <artifactId>hadoop-client</artifactId>
    <version>2.8.3</version>
    <scope>provided</scope>
</dependency>
```

## 参考

* [Hadoop Integration](https://ci.apache.org/projects/flink/flink-docs-stable/ops/deployment/hadoop.html#hadoop-integration)

# Hadoop on S3

## s3/s3n/s3a

`hadoop-aws` 模块提供了对 Amazon S3 服务的支持，该模块支持三种方式来访问 S3 协议：

| 协议          | 特点                                                           |
| ------------- | -------------------------------------------------------------- |
| s3（第一代）  | 以文件系统方式（Hadoop FileSystem API）在 Amazon S3 上存储对象 |
| s3n（第二代） | 同上；另外支持在 Hadoop 和 S3 上共享数据                       |
| s3a（第三代） | 同上；另外支持更大的文件和更高的性能、以及 S3 endpoint         |

> 对于 AWS 而言只有 s3 协议。以下示例默认选择 s3a（因为它支持 endpoint）

## 依赖

* hadoop-aws jar.
* aws-java-sdk-s3 jar.
* aws-java-sdk-core jar.
* aws-java-sdk-kms jar.
* joda-time jar; use version 2.8.1 or later.
* httpclient jar.
* Jackson jackson-core, jackson-annotations, jackson-databind jars.

```bash
# Hadoop 2.7.5
$ cp aws-java-sdk-1.7.5.jar share/hadoop/common/lib/
$ cp hadoop-aws-2.7.5.jar share/hadoop/common/lib/
$ cp jackson-core-2.6.7.jar share/hadoop/common/lib/
$ cp jackson-annotations-2.6.7.jar share/hadoop/common/lib/
$ cp jackson-databind-2.6.7.1.jar share/hadoop/common/lib/
$ cp joda-time-2.8.2-javadoc.jar share/hadoop/common/lib/
```

```bash
# 验证
$ ls share/hadoop/common/lib/ | grep -iE 'aws|joda-time|jackson|httpclient'
aws-java-sdk-1.7.5.jar
commons-httpclient-3.1.jar
hadoop-aws-2.7.5.jar
httpclient-4.2.5.jar
jackson-annotations-2.6.7.jar
jackson-core-2.6.7.jar
jackson-core-asl-1.9.13.jar
jackson-databind-2.6.7.1.jar
jackson-jaxrs-1.9.13.jar
jackson-mapper-asl-1.9.13.jar
jackson-xc-1.9.13.jar
joda-time-2.8.2-javadoc.jar
```

## S3 配置

```xml
$ vi etc/hadoop/core-site.xml
<configuration>
  <property>
    <name>fs.s3a.access.key</name>
    <value>jjyy</value>
  </property>

  <property>
    <name>fs.s3a.secret.key</name>
    <value>jjyy</value>
  </property>

  <property>
    <name>fs.s3a.endpoint</name>
    <value>192.168.8.220:8080</value>
  </property>

  <property>
    <name>fs.s3a.connection.ssl.enabled</name>
    <value>false</value>
  </property>
</configuration>
```

更多详细的配置参数：<https://hadoop.apache.org/docs/r2.7.5/hadoop-aws/tools/hadoop-aws/index.html#S3A> （`r2.7.5` 可以根据对应的 Hadoop 版本来选择，最新的是 `current`）

## 访问 S3

```bash
# 如果没有配置 core-site.xml（末尾的 '/' 不能少）
$ bin/hdfs dfs \
  -Dfs.s3a.access.key=jjyy \
  -Dfs.s3a.secret.key=jjyy \
  -Dfs.s3a.endpoint=192.168.8.220:8080 \
  -Dfs.s3a.connection.ssl.enabled=false \
  -ls s3a://backup/
```

```bash
# 如果已配置 core-site.xml（末尾的 '/' 不能少）
$ bin/hdfs dfs -ls s3a://backup/

# 共享数据
$ bin/hadoop distcp hdfs://x.x.x.x:9000/user/backup/2018 s3://backup/
```

## 参考

* [Hadoop-AWS module: Integration with Amazon Web Services](http://hadoop.apache.org/docs/current/hadoop-aws/tools/hadoop-aws/index.html)
* [Spark 支持 S3 作为 DataSource（一）：S3 及其开源实现](https://ieevee.com/tech/2016/07/25/s3-1.html)
* [Spark 支持 S3 作为 DataSource（二）：Hadoop 集成 S3 Service](https://ieevee.com/tech/2016/07/26/s3-2.html)
* [Spark 支持 S3 作为 DataSource（三）：Spark 集成 S3 Service](https://ieevee.com/tech/2016/07/27/s3-3.html)
* [Spark 支持 S3 作为 DataSource（四）：使用 Spark 处理存储在 S3 上的图片文件](https://ieevee.com/tech/2016/08/05/s3-4.html)
* [Accessing OpenStack Swift from Spark](http://spark.apache.org/docs/latest/storage-openstack-swift.html)
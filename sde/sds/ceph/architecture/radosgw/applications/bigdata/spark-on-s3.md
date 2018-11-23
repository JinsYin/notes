# Spark On S3

## s3/s3n/s3a

`hadoop-aws` 模块提供了对 Amazon S3 服务的支持，该模块支持三种方式来访问 S3 协议：

| 协议          | 特点                                                           |
| ------------- | -------------------------------------------------------------- |
| s3（第一代）  | 以文件系统方式（Hadoop FileSystem API）在 Amazon S3 上存储对象 |
| s3n（第二代） | 同上；另外支持在 Hadoop 和 S3 上共享数据                       |
| s3a（第三代） | 同上；另外支持更大的文件和更高的性能、以及 S3 endpoint         |

> 对于 AWS 而言只有 s3 协议。以下示例默认选择 s3a（因为它支持 endpoint）

## 依赖

* aws-java-sdk jar
* hadoop-aws jar

```bash
# hadoop-aws 版本为 Spark 内置的 Hadoop 版本保持一致
$ wget http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.5/hadoop-aws-2.7.5.jar
$ wget http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.5/aws-java-sdk-1.7.5.jar
```

## 配置

| property                       | example            |
| ------------------------------ | ------------------ |
| spark.hadoop.fs.s3a.access.key | jjyy               |
| spark.hadoop.fs.s3a.secret.key | jjyy               |
| sfs.s3a.endpoint               | 192.168.8.220:8080 |
| fs.s3a.connection.ssl.enabled  | false              |

更详细的配置：<http://hadoop.apache.org/docs/current/hadoop-aws/tools/hadoop-aws/index.html#S3A>

## spark-shell 示例

```bash
$ bin/spark-shell --master local[*] \
  --jars /opt/spark/jars/aws-java-sdk-1.7.5.jar,/opt/spark/jars/hadoop-aws-2.7.5.jar
scala> sc.hadoopConfiguration.set("fs.s3a.access.key", "jjyy")
scala> sc.hadoopConfiguration.set("fs.s3a.secret.key", "jjyy")
scala> sc.hadoopConfiguration.set("fs.s3a.endpoint", "192.168.8.220:8080")
scala> sc.hadoopConfiguration.set("fs.s3a.connection.ssl.enabled", "false")
scala> val rdd = sc.textFile("s3a://backup/data.csv")
scala> rdd.count
```

## 应用示例

```plaintext
// 版本
sbt: 0.13.8
scala: 0.11.8
spark: 2.3.0
```

```sbt
// build.sbt
libraryDependencies += "org.apache.spark" % "spark-core_2.11" % "2.3.0" % "provided"
libraryDependencies += "com.amazonaws" % "aws-java-sdk" % "1.7.5"
libraryDependencies += "org.apache.hadoop" % "hadoop-aws" % "2.7.5"
```

```scala
// Scala
import org.apache.spark.{SparkConf, SparkContext}

object S3Main {
  def main(args: Array[String]): Unit = {
    val conf = new SparkConf()
      .set("spark.hadoop.fs.s3a.access.key", "jjyy")
      .set("spark.hadoop.fs.s3a.secret.key", "jjyy")
      .set("spark.hadoop.fs.s3a.endpoint", "192.168.8.220:8080")
      .set("spark.hadoop.fs.s3a.connection.ssl.enabled", "false")
      .setMaster("local[*]")
      .setAppName("Spark On S3")
    val sc = new SparkContext(conf)

    // 读取文件
    val data = sc.textFile("s3a://backup/data.csv")
    println(data.count)

    // 读取整个目录（末尾的 '/' 不能少）
    val dataset = sc.textFile("s3a://backup/")
    println(dataset.count)
  }
}
```

## spark-submit 示例

```plaintext
// 版本
spark: 2.3.0
hadoop: 2.7 （Spark 内置）
```

```bash
$ bin/spark-submit \
  --class org.apache.spark.examples.SparkPi \
  --master local[*] \
  --name "Spark on S3" \
  --conf spark.hadoop.fs.s3a.access.key=jjyy \
  --conf spark.hadoop.fs.s3a.secret.key=jjyy \
  --conf spark.hadoop.fs.s3a.endpoint=192.168.8.220:8080 \
  --conf spark.hadoop.fs.s3a.connection.ssl.enabled=false \
  --jars jars/aws-java-sdk-1.7.5.jar,jars/hadoop-aws-2.7.5.jar \
  examples/jars/spark-examples_2.11-2.3.0.jar
```

## 参考

* [Hadoop-AWS module: Integration with Amazon Web Services](http://hadoop.apache.org/docs/current/hadoop-aws/tools/hadoop-aws/index.html)
* [Spark 支持 S3 作为 DataSource（一）：S3 及其开源实现](https://ieevee.com/tech/2016/07/25/s3-1.html)
* [Spark 支持 S3 作为 DataSource（二）：Hadoop 集成 S3 Service](https://ieevee.com/tech/2016/07/26/s3-2.html)
* [Spark 支持 S3 作为 DataSource（三）：Spark 集成 S3 Service](https://ieevee.com/tech/2016/07/27/s3-3.html)
* [Spark 支持 S3 作为 DataSource（四）：使用 Spark 处理存储在 S3 上的图片文件](https://ieevee.com/tech/2016/08/05/s3-4.html)
* [Accessing OpenStack Swift from Spark](http://spark.apache.org/docs/latest/storage-openstack-swift.html)
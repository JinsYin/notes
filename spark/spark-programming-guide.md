# Spark 编程指南

## 概述（Overview）



## 关联 Spark （Linking with spark）

Spark 2.0.2 默认是基于 Scala 2.11 来构建的，如果要用 Scala 来写 Spark 程序，需要使用兼容的 Scala 版本（比如 2.11.X）。

如果要写 Spark 程序，需要添加一个基于 Spark 的 Maven 依赖。Spark 依赖项可以从 Maven [中心仓库](http://search.maven.org)获取：

```
groupId = org.apache.spark
artifactId = spark-core_2.11
version = 2.0.2
```

另外，如果要访问 HDFS 集群，需要添加相应版本的 `hadoop-client` 依赖项。

```
groupId = org.apache.hadoop
artifactId = hadoop-client
version = <your-hdfs-version>
```

最后，需要在程序中导入一些　Spark 类。

```scala
import org.apache.spark.SparkContext
import org.apache.spark.SparkConf
```


## 初始化 Spark

Spark 程序需要做的第一件事就是创建一个 `SparkContext` 对象，SparkContext 对象决定了 Spark 如何访问集群。要创建一个 SparkContext 对象，首先需要构造一个 SparkConf 对象，它包含程序的配置等信息。

每个 JVM 进程只可能启用一个 SparkContext 对象。如果要再新建一个，必须将之前启用的 SparkContext 对象 `stop()` 掉。

```scala
val conf = new SparkConf().setAppName(appName).setMaster(master)
new SparkContext(conf)
```

appName 参数是 Spark 应用显示在集群 UI 上的名称。master 参数是 [Spark， Mesos or YARN cluster URL](#Master URL)， 或者特殊的 “local” （本地模式）。实际上，当 Spark 程序运行在集群上时，不会将 master 参数硬编码到程序中，而是用 spark-submit 脚本来设置该参数。然而，如果是本地测试或者单元测试，可以使用 ”local” 值来运行 Spark 程序。


## 使用 shell

在 Spark shell 中，默认已经为你创建了一个指定的内置 SparkContext 对象，变量名为 `sc`。所以 spark-shell 里不能自建 SparkContext 对象。你可以通过 `--master` 参数来设置要连接到哪个集群，以及传递一个逗号分隔的 jar 包列表给 `--jars` 参数，以便将这些 jar 包加到 classpath 中。你还可以通过 `--packages` 参数来添加以逗号分隔的 maven 依赖项。同样，还可以通过 `--repositories` 参数添加 maven repository 地址。


```bash
$ # 在本地 4 个 CPU core 上运行实例
$ bin/spark-shell --master local[4]
$
$ # 将 code.jar 添加到 classpath 中
$ bin/spark-shell --master local[4] --jars code.jar
$
$ # 添加 maven 依赖项
$ bin/spark-shell --master local[4] --packages "org.example:example:0.1"
```

可以使用 `spark-shell --help` 命令来查看完整的选项列表。实际上，spark-shell 是在后台调用 spark-submit 来实现其功能的。


## 弹性分布式数据集（RDD）

Spark 的核心概念是弹性分布式数据集（RDD），RDD 是一个可容错、可并行操作的分布式元素集合。有两种方法可以创建 RDD：一种是通过对 Spark 程序中的集合进行并行化（parallezing）操作来创建，另一种则是从外部存储系统的数据集中加载（如：共享文件系统、HDFS、HBase 或者其他 Hadoop 支持的数据源）。

* 并行化集合

并行化集合（Parallelized Collections）是在已有的集合上（例如：Scala Seq），调用 `SparkContext` 的 `parallelize()`方法创建得到 RDD。集合中的所有元素都将被复制到一个可并行操作的分布式数据集中。

```scala
// 将一个 1 到 5 的数组并行化为一个 RDD
val data = Array(1, 2, 3, 4, 5)
val distData = sc.parallelize(data)

// 创建成功后即可执行并行操作，例如将数组中的所有元素相加
dist.reduce((a, b) => a + b)
```

并行化集合的一个重要参数是 `分区数`（the number of partitions），即数据集要切分的数量。Spark 中的每个任务（task）都是基于分区的，集群中的每个分区运行一个对应的任务。通常情况，每个 CPU 对应 `2~4` 个分区。一般情况，Spark 会基于集群的情况，自动设置这个分区数。当然，也可以手动设置这个分区数，只需给 `parallelize()` 方法再传一个参数即可（如：`sc.parallelize(data, 10)`）。注意：Spark 代码里有些地方仍然使用分片（slice）这个术语，这只不过是分区的一个别名，主要为了保持向后兼容。

* 外部数据集

Spark 可以从 Hadoop 所支持的所有数据源中创建分布式数据集，包括：本地文件系统、HDFS、Cassandra、HBase、Amazon S3 等等。Spark 支持的文件格式包括：文本文件、SequenceFiles，以及其他 Hadoop 所支持的输入格式。

通过文本文件创建 RDD 可以用 `SparkContext` 的 `textFile` 方法。这个方法输入是一个文件的 URI（`本地路径`、`hdfs://` 或者 `s3n://` 等），其输出是一个文本行集合。

```scala
scala> val distFile = sc.textFile("data.txt")
distFile: org.apache.spark.rdd.RDD[String] = data.txt MapPartitionsRDD[10] at textFile at <console>:26
scala>
scala> // 创建后可以执行数据集操作，例如对文本行的长度求和
scala> distFile.map(line => line.length).reduce(_ + _)
```


## 参考

> https://spark.apache.org/docs/2.0.2/programming-guide.html
> http://ifeve.com/%E3%80%8Aspark-%E5%AE%98%E6%96%B9%E6%96%87%E6%A1%A3%E3%80%8Bspark%E7%BC%96%E7%A8%8B%E6%8C%87%E5%8D%97/
> https://www.gitbook.com/book/yourtion/sparkinternals/details
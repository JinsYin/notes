# Spark 入门

## Standalone 集群

* Host

```sh
$ # master
$ sbin/start-master.sh
$
$ # worker
$ sbin/start-slave.sh spark://[MASTER-IP]:7077
```

* Docker

```sh
$ # master
$ docker run -it --name=spark-master --net=host -d dockerce/spark:2.0.2 master
$
$ # worker
$ docker run -it --name=spark-worker --net=host -d dockerce/spark:2.0.2 worker spark://[MASTER-IP]:7077
```

## 测试

测试前确保已经安装了所需的 JDK、Python 和 R 运行时环境。

```sh
$ # Scala、Java
$ bin/run-example SparkPi
$
$ # Python
$ bin/spark-submit examples/src/main/python/pi.py
$
$ # R
$ bin/spark-submit examples/src/main/r/dataframe.R
```

## 交互式

* scala

```sh
$ # SparkContext 会运行一个 Web UI： http://localhost:4040
$ bin/spark-shell
$
$ # 设定 local[N] 参数启动本地 Spark 集群，其中 N 表示线程数，用 * 拜师机器上所有可用的核数
$ bin/spark-shell --master local[*]
$
$ bin/spark-shell --master spark://x.x.x.x:7077
$ bin/spark-shell --master mesos://x.x.x.x:7077
```

```scala
scala> val textFile = sc.textFile("README.md")
scala>
scala> textFile.count() // 返回 RDD 中元素的数量
scala>
scala> textFile.first() // 返回 RDD 中的第一个元素
scala> :q
```

spark-shell 命令：
  * sc - SparkContext 对象
  * :help - 获取帮助
  * :history - 历史命令
  * :q - 退出

* python

```sh
$ bin/pyspark
$ bin/pyspark --master local[*]
```

```python
>>> textFile = sc.textFile("README.md")
>>>
>>> textFile.count()
>>>
>>> textFile.first()
>>>
>>> exit()
```

* 计算包含 “Spark” 单词的行数

```scala
scala> val linesWithSpark = textFile.filter(line => line.contains("Spark"))
scala> linesWithSpark.count()
```

* 查找单词最多的行

```scala
scala> textFile.map(line => line.split(" ").size).reduce((a, b) => if (a > b) a else b)
scala>
scala> import java.lang.Math
scala> textFile.map(line => line.split(" ").size).reduce((a, b) => Math.max(a, b))
```

* Word Count

```scala
scala> val wordCounts = textFile.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey((a, b) => a + b)
scala>
scala> wordCounts.collect()
scala> wordCounts.foreach(println)
```

## 缓存

Spark 支持将数据集缓存到内存中，这对于重复访问这些数据是非常有用的，例如查询小规模热数据或者运行迭代算法（PageRank）。

```scala
scala> lineWithSpark.cache()
scala>
scala> lineWithSpark.count()
scala>
scala> lineWithSpark.count()
```

## 开发、打包、部署

* 代码

SimpleApp.scala

```scala
object SimpleApp {
	def main(args: Array[String]) {
    val logFile = "YOUR_SPARK_HOME/README.md"
    val conf = new SparkConf().setAppName("Simple Application").setMaster("local[*]")
    val sc = new SparkContext(conf)
    val logData = sc.textFile(logFile, 2).cache()
    val numAs = logData.filter(line => line.contains("a")).count()
    val numBs = logData.filter(line => line.contains("b")).count()
    println(s"Lines with a: $numAs, Lines with b: %numBs")
    println("Lines with a: %s, Lines with b: %s", numAs, numBs)
    sc.stop()
	}
}
```

* 项目目录结构

```sh
$ find .
.
./build.sbt
./src
./src/main
./src/main/scala
./src/main/scala/SimpleApp.scala
```

* 项目依赖

build.sbt

```sbt
name := "Simple Project"

version := "1.0"

scalaVersion := "2.11.8"

libraryDependencies += "org.apache.spark" %% "spark-core" % "2.0.2"
```

* 项目打包

```sh
$ sbt package
```

* 提交部署

```sh
$ bin/spark-submit \
  --class "SimpleApp" \
  --master local[4] \
  target/scala-2.11/simple-project_2.11-1.0.jar
```

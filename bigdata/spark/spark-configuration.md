# Spark 配置

## Spark 配置 Hadoop 参数

Spark 集成了 Hadoop，所以可以在 Spark 中配置 Hadoop 参数（示例配置的是 hadoop-aws 的参数）。

```scala
/**
* Option 1 （添加参数前缀：'spark.hadoop.'）
* 推荐，因为它还可以通过 spark-submit --conf 来动态配置
* spark-submit --conf spark.hadoop.fs.s3a.access.key=value ...
*/
val conf = new SparkConf().set("spark.hadoop.fs.s3a.access.key", "value")
```

```scala
// Option 2
val sc = new SparkContext().hadoopConfiguration.set("fs.s3a.access.key", "value")
```

> * [Set hadoop configuration values on spark-submit command line](https://stackoverflow.com/questions/42796561/set-hadoop-configuration-values-on-spark-submit-command-line)

## 参考

> http://ifeve.com/spark-config/

* [Spark 配置参数](http://blog.javachen.com/2015/06/07/spark-configuration.html)
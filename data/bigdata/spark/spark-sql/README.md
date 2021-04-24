# Spark SQL

Spark SQL 用于处理结构化数据。Spark SQL 主要有两种用途，一个是执行 SQL 查询，另一种是从已有 Hive 中读取数据。


## Dataset/DataFrame

* Dataset

`Dataset` 是一个分布式的数据集合，它是 Spark 1.6 新增的接口，支持 Scala 和 Java，不支持 Python 和 R。Dataset 可以从 JVM 对象中构建，然后使用函数式 transformation 进行操作。

* DataFrame

`DataFrame` 是有指定列组成的 `Dataset`。相当于关系型数据库中的表，以及 R/Python 中的 data frame。DataFram 可以从多种数据源中构建，如：结构化的数据文件、Hive 中的表、外部数据库以及已有的 RDD。

`DataFrame` 支持 Scala、Java、Python 和 R；在 Scala 和 Java 中，DataFrame 表示 `Rows` 的一个 Dataset；在 Scala API 中，`DataFrame` 相当于 `Dataset[Row]`；在 Java API 中可以使用 `Dataset<Row>` 表示 `DataFrame`。


## 入口

* 2.0

`SparkSession` 是所有功能的入口，可以使用 `SparkSession.builder()` 创建。

Spark 2.0 中的 SparkSession 提供了对的内部支持。

SparkSession in Spark 2.0 provides builtin support for Hive features including the ability to write queries using HiveQL, access to Hive UDFs, and the ability to read data from Hive tables. To use these features, you do not need to have an existing Hive setup.

```scala
import org.apache.spark.sql.SparkSession

val spark = SparkSession.builder()
  .appName("Spark SQL example")
  .master("local[*]")
  .config("spark.some.config.option", "some-value")
  .getOrCreate()

// 用于 RDD 到 DataFrame 的隐式转换
import spark.implicits._

// 完整代码："examples/src/main/scala/org/apache/spark/examples/sql/SparkSQLExample.scala"
```

* 1.6

```scala
val sc: SparkContext // 已存在的 SparkContext 对象
val sqlContext = new org.apache.spark.sql.SQLContenxt(sc)

// 用于 RDD 到 DataFrame 的隐式转换
import sqlContext.implicits._
```

## 创建 DataFrame

`examples/people.json`：

```json
{"name":"Michael"}
{"name":"Andy", "age":30}
{"name":"Justin", "age":19}
```

* 2.0

```scala
val df = spark.read.json("examples/people.json")
```

* 1.6

```scala
val df = sqlContext.read.json("examples/people.json")
```

* 操作

```scala
// 展示 DataFrame 的内容
df.show()
// +----+-------+
// | age|   name|
// +----+-------+
// |null|Michael|
// |  30|   Andy|
// |  19| Justin|
// +----+-------+

// 打印数据树形结构
df.printlnSchema()
// root
// |-- age: long (nullable = true)
// |-- name: string (nullable = true)

// 筛选 “name” 列
df.select("name").show()
// +-------+
// |   name|
// +-------+
// |Michael|
// |   Andy|
// | Justin|
// +-------+

// age 加 1
df.select(s"name", s"age" + 1).show()
df.select(df("name"), df("age") + 1).show()
df.select(df.col("name", df.col("age") + 1)).show()
// +-------+---------+
// |   name|(age + 1)|
// +-------+---------+
// |Michael|     null|
// |   Andy|       31|
// | Justin|       20|
// +-------+---------+

// 筛选出 age 大于 21 的人
df.filter(s"age" > 21).show()
// +---+----+
// |age|name|
// +---+----+
// | 30|Andy|
// +---+----+

// 各个年龄的人数
df.groupBy("age").count.show()
// +----+-----+
// | age|count|
// +----+-----+
// |  19|    1|
// |null|    1|
// |  30|    1|
```

## SQL 查询

* 2.0

```scala
// Register the DataFrame as a SQL temporary view
df.createOrReplaceTempView("people")

val sqlDF = spark.sql("SELECT * FROM people")
sqlDF.show()
// +----+-------+
// | age|   name|
// +----+-------+
// |null|Michael|
// |  30|   Andy|
// |  19| Justin|
// +----+-------+
```

* 1.6

```scala
val sqlContext = ... // 已有一个 SQLContext 对象
val df = sqlContext.sql("SELECT * FROM table")
```

## 创建 Dataset


## Maven 依赖

```xml
<dependency>
  <groupId>org.apache.spark</groupId>
  <artifactId>spark-sql_2.11</artifactId>
  <version>2.0.2</version>
</dependency>
```

## 参考

> http://ifeve.com/spark-sql-dataframes/

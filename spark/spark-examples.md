# Spark Examples

## Word Count

```scala
val rdd = sc.textFile("README.md", 5)

// 官方文档
rdd.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _).collect.foreach(println)

// 方法一
rdd.flatMap(line => line.split("""[^a-zA-Z]+""")).filter(elem => elem.nonEmpty).map(word => (word, 1)).reduceByKey(_ + _).collect.foreach(println)

// 方法二
rdd.flatMap(line => line.split("""[^a-zA-Z]+""")).map {
	case word if word.matches("""[a-zA-Z]+""") => (word, 1))
  case _ => ("", 0)
}.reduceByKey(_ + _).collect.foreach(println)
```

## 找出长度最长的单词

```scala
val rdd = sc.textFile("README.md")

// 方法一
rdd.flatMap(line => line.split(" ")).reduce((a, b) => if (a.length > b.length) a else b)

// 方法二
rdd.flatMap(line => line.split(" ")).map(word => (word, word.length)).reduce((a, b) => if (a._2 > b._2) a else b)
```

## 找出出现次数最多的单词

```scala
val rdd = sc.textFile("README.md")
val word = rdd.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _).reduce((a, b) => if (a._2 > b._2) a else b)
println(word)
```

## 找出出现次数排名前十的单词

```scala
val rdd = sc.textFile("README.md")
val words = rdd.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _).sortBy(x => x._2, false).take(10)
words.foreach(println)
```

## 查看各个分区的元素个数

```scala
var rdd = sc.textFile("README.md", 5)
rdd.mapPartitionsWithIndex(
  val result = ArrayBuffer[String]()
  // index：分区编号，partition：每个分区中的所有元素所组成的 Iterator
  (index, partition) => {
    result += s"$index-${partition.length}"
    result.iterator
  }
).collect.foreach(println)
```

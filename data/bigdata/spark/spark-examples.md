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

// 方法三
rdd.flatMap(line => line.split("""[^a-zA-Z]+""")).filter(elem => elem.nonEmpty).map(word => (word, 1)).countByKey().foreach(println)
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

## 查看各个分区的元素

```scala
var rdd = sc.textFile("README.md", 5)
rdd.flatMap(line => line.split("""[^a-zA-Z]""")).filter(word => word.nonEmpty).mapPartitionsWithIndex {
  val map = scala.collection.mutable.Map[Int, String]()
  (index, partition) => {
    val elems = new StringBuilder()
    while (partition.hasNext) {
      elems.append(s"${partition.next} | ")
    }
    map += (index -> elems.toString)
    map.toIterator
  }
}.collect.foreach(println)
```

## 求每个分组的元素个数

```scala
val rdd = sc.textFile("README.md", 5)
// 按单词长度分组
val grouped = rdd.flatMap(line => line.split("""[^a-zA-Z]+""")).filter(_.nonEmpty).distinct.groupBy(_.length)

// 方法一    
grouped.collect.foreach(x => println(s"word length: ${x._1}, group size: ${x._2.size}"))

// 方法二
grouped.mapValues(_.size).collect.foreach(x => println(s"word length: ${x._1}, group size: ${x._2}"))
```

## 求两个文本之间相同的单词及单词个数

```scala
val rdd1 = sc.textFile("R1.md").flatMap("""[^a-zA-Z]+""")
val rdd2 = sc.textFile("R2.md").flatMap("""[^a-zA-Z]+""")

// 交集
val intersection = rdd1.intersection(rdd2)

// 相同元素
intersection.collect.foreach(println)

// 相同元素个数
println(intersection.count)
```

## 求两个文本的相似度

```scala
val rdd1 = sc.textFile("R1.md").flatMap("""[^a-zA-Z]+""").filter(_.nonEmpty)
val rdd2 = sc.textFile("R2.md").flatMap("""[^a-zA-Z]+""").filter(_.nonEmpty)

// 交集
val intersection = rdd1.intersection(rdd2)

// 并集
val union = rdd1.union(rdd2).distinct

// 相似度
val similarity = intersection.count.toDouble / union.count.toDouble

println(similarity)
```

## TF-IDF

> https://my.oschina.net/dreamerliujack/blog/809387

```scala

```

## PageRank

> http://blog.csdn.net/gamer_gyt/article/details/47443877

```scala
```

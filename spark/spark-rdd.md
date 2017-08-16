# Spark RDD

RDD，全称为 Resilient Distributed Datasets（弹性分布式数据集），是一个容错的、并行的数据结构，可以让用户显式地将数据存储到磁盘和内存中，并能控制数据的分区。

Spark 最重要的一个抽象概念就是弹性分布式数据集（Resilient Distributed Dataset - RDD），RDD 是一个可分区的（partitioned）元素集合，其包含的元素可以分布在集群各个节点上，并且可以执行一些分布式并行操作。

用户也可以请求 Spark 将 RDD 持久化到内存里，以便在不同的并行操作中重复使用；最后，RDD 具备容错性，可以从节点失败中自动恢复数据。


## 创建　RDD

Spark RDD 可以从 `Hadoop 所支持的外部数据源` 或者 `Scala 集合对象` 中创建或转换得到。

* 集合对象 

```scala
val rdd = sc.parallelize(List("a", "b", "c"))
```

* 外部数据源

对于 `textFile()` 函数，如果输入的是目录而不是文件，Spark 会把该目录下的所有文件作为 RDD 的输入，多个目录之间可以用逗号分隔；另外，数据是按 `行` 分割成一个 RDD 元素。
对与 `wholeTextFiles()` 函数，以目录路径作为 RDD 的输入，多个目录之间依然使用逗号分隔；返回一个 (key,value) 二元组元素组成的 RDD，key 表示文件路径，value 表示 `文本内容`；另外，小文件效率比较高，大文件性能可能非常低。

```scala
// Local
val rdd = sc.textFile("README.md")

// HDFS
val rdd = sc.textFile("hdfs://192.168.1.2:9000/data.csv")

// Alluxio
val rdd = sc.textFile("alluxio://192.168.1.2:19998/data.csv")

// wholeTextFiles
val rdd = sc.wholeTextFiles("/my/dir1,/my/dir2,/my/paths/part-00[0-5]*,/a/specific/file", 20)
```


## 分区

RDD 以分区（partition）的形式分布在集群中的多台机器上，每个分区代表数据集的一个子集，并且每个分区的大小不一定相同。分区定义了 Spark 中数据的并行单位，分区的数量决定了 Spark 并行计算的能力。Spark 并行处理多个分区，每个分区内的数据对象则是顺序处理。

```bash
$ # 第二个参数代表分区的个数
$ val rdd = sc.parallelize(Array(1, 2, 3, 4), 4)
```


## RDD 依赖

* narrowdependency

* widedependency


## 算子分类

#### Transformation

在已存在的 RDD 的基础上创建一个新的 RDD。

---

* map 型

实际上，map 型算子也可以操作 `(K, V)` 类型的数据，不过内部依然会把 `(K, V)` 类型的元素作为一个 Value。map 型 Transformation 前后分区数不变。

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| map(f)                    | (V)         | T => U                                   | 对 RDD 中的每个元素都执行 f 函数，并返回新的 RDD 
| flatMap(f)                | (V)         | T => TraversableOnce[U]                  | 对 RDD 中的每个元素都执行 f 函数，再扁平化结果，最后返回新的 RDD
| mapPartitions(f)          | (V), (K, V) | Iterator<T> => Iterator<U>               | 对 RDD 中的每个分区都执行 f 函数，并返回新的 RDD 
| mapPartitionsInternal(f)  | (K, V)      | Iterator[T] => Iterator[U]               | value 一对多
| mapPartitionsWithIndex(f) | (V), (K, V) | (Int, Iterator<T>) => (Int, Iterator<U>) | 类似 mapPartitions，只是每个分区都带有 index
| mapValues(f)              | (K, V)      | (T, U) => (T, U)                         | value 一对一
| flatMapValues(f)          | (K, V)      | (T, U) => (T, Seq<U>)                    | value 一对多

---

* group 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| groupBy(f)    | (K, V) | T => U | 按 f 的返回值进行分组
| groupByKey([n]) | (K, V) | T => T | 按 key 进行分组 
| cogroup(rdd2) | (K, V) | 
| groupWith(rdd2) | 同上 | 同上 | 同上

---

* reduce 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| reduceByKey(f)    | (K, V) | T => T | 按 f 的返回值进行分组

---

* persist 型

| 算子       | RDD 类型   | 持久化方式 | 用途      |
| --------- | --------- | --------- | --------- |
| persist([Level]) | (V), (K, V) | MEMORY_ONLY | 默认持久化到内存，支持多种持久化方式
| cache()          | (V), (K, V) | MEMORY_ONLY | 持久化数据到内存

---

* 集合型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| union | --------- | --------- | --------- |
| intersection | --------- | --------- | --------- |
| cartesian | --------- | --------- | --------- |

---

* join 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| join | --------- | --------- | --------- |
| leftOutJoin | --------- | --------- | --------- |
| rightOutJoin | --------- | --------- | --------- |
| fullOuterJoin | --------- | --------- | --------- |

---

* repartition 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| coalesce | --------- | --------- | --------- |
| replication | --------- | --------- | --------- |
| repartitionAndSortWithinPartitions | --------- | --------- | --------- |
| partitionBy | --------- | --------- | --------- |

---

* sort 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| sortBy | --------- | --------- | --------- |
| sortByKey | --------- | --------- | --------- |

---

* 聚合型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| aggregateByKey | --------- | --------- | --------- |
| foldByKey | --------- | --------- | --------- |
| sampleByKey | --------- | --------- | --------- |
| sampleByKeyExact | --------- | --------- | --------- |

---

* filter 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| filter     | - | - | - |
| filterByRange     | - | - | - |
| distinct   | - | - | - | 去重

---

* other 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| subtract   | - | - | - |
| glom()     | - | - | - |


#### Action

actions: 在 dataset 上做完运算后返回一个 value 给 driver program

---

* reduce 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| reduce(f)     | - | - | - |
| treeReduce(f)     | - | - | - |

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |

---

* save 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| saveAsTextFile(path)    | - | - | - |
| saveAsSequenceFile(path) | - | - | - |
| saveAsObjectFile(path) | - | - | - |

---

* take 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| take(n)     | - | - | - |
| takeSample(withReplacement, num, [seed])     | - | - | - |
| takeOrdered(n, [ordering])     | - | - | - |

---

* count 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| count()        | (V), (K, V) | - | - |
| countByValue() | (V)         | - | - |
| countByKey()   | (K, V)      | --------- | --------- |

---

* other 型

| 算子       | RDD 类型   | f 函数类型 | 用途      |
| --------- | --------- | --------- | --------- |
| collect()     | - | - | - |
| first()     | - | - | - |
| lookup()   | - | - | - |
| foreach(func)   | - | - | - |


## 算子

从小方向来说，Spark 算子大致可以分为以下三类：

* Value 数据类型的 Transformation 算子

类型 | 算子
--- | ---
输入分区与输出分区一对一型 | map、flatMap、mapPartitions、glom
输入分区与输出分区多对一型 | union、cartesian
输入分区与输出分区多对多型 | groupBy
输出分区为输入分区子集型   | filter、distinct、subtract、sample、takeSample
Cache 型               | cache、persist

* Key-Value 数据类型的 Transfromation 算子

类型 | 算子
--- | ---
输入分区与输出分区一对一 | mapValues
对单个 RDD            | combineByKey、reduceByKey、partitionBy
两个 RDD 聚集         | cogroup
连接                 | join、leftOutJoin、rightOutJoin

* Action 算子

类型 | 算子
--- | ---
无输出 | foreach
HDFS  | saveAsTextFile、saveAsObjectFile
Scala集合和数据类型 | collect、collectAsMap、reduceByKeyLocally、lookup、count、top、reduce、fold、aggregate


## Transformation

Transformation 返回新 RDD 的 `pointer`

---

* map(func)

原 RDD 中的每个元素都执行 func 函数后映射成一个新的元素并组合新的 RDD，属于 `一对一的映射`，所以 `func` 应该返回单个值。操作前后分区数不变，属于 `一对一的分区`。

```scala
val rdd = sc.parallelize(List("The", "main", "abstraction", "Spark", "provides", "is", "a", "RDD"))
val newRDD = rdd.map(elem => elem.charAt(0).toUpper + elem.substring(1))

newRDD.foreach(println) // List("The", "Main", "Abstraction", "Spark", "Provides", "Is", "A", "RDD")
```

---

* flatMap(func)

原 RDD 中的每个元素被映射为 0 个或多个元素并生成新的 RDD，属于 `一对多的映射`，所以 `func` 应该返回一个 `Seq`。操作前后分区数不变，属于 `一对一的分区`。

```scala
sc.textFile("R.md").flatMap(line => line.split(" ")).foreach(println)
```

---

* mapPartitions(func)

`map` 中的 func 作用的对象是 RDD 中的每个元素，而 `mapPartitions` 中的 func 作用的对象是 RDD 中的每个分区（`partition` / `block`），所以 func 类型必须是 `Iterator<T> => Iterator<U>`。操作前后分区数不变，属于 `一对一的分区`。

```scala
val rdd = sc.textFile("R.md", 5)
rdd.mapPartitions {
  // 这里的 block 是由每个分区中的所有元素所组成的 Iterator
  block => {
    val result = ArrayBuffer[String]()
    while (block.hasNext) result ++= block.next.split(" ")
    result.iterator
  }
}.foreach(println)
```

---

* mapPartitionsWithIndex(func)

与 `mapPartitions` 类似，但输入会多提供一个整数表示分区的编号，所以 func 的类型是 `(Int, Iterator<T>) => Iterator<U>`。

```scala
val rdd = sc.textFile("R.md", 5)

// 查看各个分区都有多少个元素（行）
rdd.mapPartitionsWithIndex {
  // 这里的 index 为分区编号，block 是由每个分区中的所有元素所组成的 Iterator
  (index, block) => {
    val result = ArrayBuffer[String]()
    result.append(s"${index}-${block.size}")
    result.iterator
  }
}.foreach(println)
```

---

* mapValues(func)

与 `map` 相似，不同的是 `map` 对输入的数据统一按 `Value` 型数据来进行映射操作；而 `mapValues` 只对 `Key-Value` 型数据的 Value 进行 Map 操作，而原 RDD 中的 Key 保持不变。

```scala
val rdd = sc.parallelize(List("This", "is", "a", "dog"), 5)
rdd.map(word => (word, 0)).mapValues(_ + 1).collect // Array((This, 1), (is, 1), (a, 1), (dog, 1))
```

---

* flatMapValues(func)

结合了 `flatMap` 和 `mapValues` 的特点，对 `Key-Value` 数据类型中的 Value 进行 `一对多映射`，所以 func 函数应该返回一个 `Seq`。

```scala
val rdd = sc.parallelize(List(1, 2, 3))
rdd.map(x => (x, x * 2)).flatMapValues(_ to 5).collect // Array((1, 2), (1, 3), (1, 4), (2, 4), (2, 5))
```

---

* sample(withReplacement: Boolean, fraction: Double, seed: Long = Utils.random.nextLong)

`sample` 用于对数据进行 `简单随机抽样`。`withReplacement` 为 true 时采用 `PoissonSampler` 取样器（泊松分布）, 否则采用 `BernoulliSampler` 取样器（柏努利分布）；`Fraction` 的取值范围为 `(0, 1]`，表示抽取的数据所占整个数据集的比例；`Seed` 默认值是 `(0, Long.maxvalue]` 之间的整数，比如当前时间戳 `System.currentTimeMillis`。

---

* filter(func)

对原 RDD 中的每个元素应用 func 函数，返回值为 `false` 的元素将被过滤掉，返回值为 `true` 的元素组成新的 RDD。操作前后分区数不变，属于 `一对一的分区`。

```scala
sc.textFile("R.md", 5).filter(line => line.contains("Spark")).foreach(println)
```

---

* cartesian(oterhRDD)

对 `T` 和 `U` 类型的 RDD 进行笛卡尔积操作，返回 `(T, U)` 类型的 RDD （CartesianRDD）。

```scala
val rdd1 = sc.parallelize(List(1, 2))
val rdd2 = sc.parallelize(List("a", "b", "c"))

rdd1.cartesian(rdd2).collect // Array((1, a), (1, b), (1, c), (2, a), (2, b), (2, c))
```

---

* pipe(command, [envVars])

对 RDD 中的每个元素都执行一个 shell 命令或者 shell 脚本。

---

* union(otherDataset)

合并两个数据类型相同的 RDD，`union` 操作并不对数据进行去重。合并后的 RDD 的分区数 == 合并前的两个 RDD 的分区数之和。

```scala
val rdd1 = sc.parallelize(List(("a", 1), ("b", 2), ("c", 3)), 5)
val rdd2 = sc.parallelize(List(("c", 3), ("d", 4)), 3)
val rdd3 = rdd1.union(rdd2)

rdd3.collect.foreach(println) // Array(("a", 1), ("b", 2), ("c", 3), ("c", 3), ("d", 4)) 

println(rdd1.partitions.length) // 5
println(rdd2.partitions.length) // 3
println(rdd3.partitions.length) // 8

// 并集
rdd1.union(rdd2).distinct.foreach(println) // Array(("a", 1), ("b", 2), ("c", 3), ("d", 4))
```

---

* intersection(otherDataset)

求两个 RDD 的交集。交集后的 RDD 的分区数 == 交集前的两个 RDD 中的最大分区数。

```scala
val rdd1 = sc.parallelize(List(("a", 1), ("b", 2), ("c", 3)), 5)
val rdd2 = sc.parallelize(List(("c", 3), ("d", 4)), 6)
val rdd3 = rdd1.intersection(rdd2)

rdd3.collect.foreach(println) // Array((c, 3))

println(rdd1.partitions.length) // 5
println(rdd2.partitions.length) // 6
println(rdd3.partitions.length) // 6
```

---

* distinct([numTasks]))

用于对原 RDD 进行去重。numTasks 的默认值取决于原 RDD 的分区数，新 RDD 的分区数 == (numTasks || 原 RDD 的分区数)。

```scala
val rdd = sc.parallelize(List("A", "B", "C", "B"), 5)

rdd.distinct.collect.foreach(println) // Array("A", "B", "C")

println(rdd.distinct.partitions.length) // 5
println(rdd.distinct(3).partitions.length) // 3
```

---

* groupByKey([numTasks])

对 `(K, V)` 类型的 RDD 按照 key 相同的方式进行分组，并对 key 相同的元素的 value 进行聚合，分组后返回 `(K, Iterable<V>)` 类型的 RDD，其中一个元素代表一个组。numTasks 的默认值取决于原 RDD 的分区数，新 RDD 的分区数 == max(原 RDD 的分区数, numTasks)。

```scala
val rdd = sc.parallelize(List(("A",1),("B",2),("A",4)), 5)

rdd.groupByKey.collect.foreach(println)    // Array((A,CompactBuffer(1, 4)), (B,CompactBuffer(2)))
println(rdd.groupByKey.partitions.length)    // 5
println(rdd.groupByKey(7).partitions.length) // 7
```

> 注： 如果只是为了执行聚合（aggregate）操作而分组，例如求和或求平均数，使用 reduceByKey 或者 aggregateByKey 会获得更好的性能。
> 注： 输出的并行化程度取决于原 RDD 的分区数，但可以通过可选的 numTasks 设置不同的任务数。

---

* reduceByKey(func, [numTasks])

对 (K, V) 类型的 RDD 使用 func 函数进行聚合，使 key 相同的多个元素的 value 被 reduce 为一个值，然后与原 RDD 中的 key 组成一个新的 (K, V) 类型的 RDD。func 函数的类型必须是 `(V, V) => V`。

```scala
// 求单词数
sc.textFile("R.md", 5).flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _).collect.foreach(println)
```

---

* aggregateByKey(zeroValue)(seqOp, combOp, [numTasks])

对 (K, V) 类型的 RDD 中相同 key 的值进行聚合，聚合过程中使用了中立的初始值。

---

* sortByKey([ascending], [numTasks])

对 `(K, V)` 类型的 RDD 按 key 进行排序。ascending: Boolean = false： 降序；ascending: Boolean = true： 升序（默认）。numTasks 默认值取决于原 RDD 的分区数，新 RDD 的分区数 == min(原 RDD 的分区数, numTasks)。

```scala
val rdd = sc.parallelize(List(("A",1),("B",2),("c",3),("A",4),("C",5)), 5)
val sortedRDD1 = rdd.sortByKey()
val sortedRDD2 = rdd.sortByKey(false, 7)
val sortedRDD3 = rdd.sortByKey(false, 3)

sortedRDD1.collect.foreach(println) // Array((A, 1), (A, 4), (B, 2), (C, 5), (c, 3))

println(sortedRDD1.partitions.length) // 5
println(sortedRDD2.partitions.length) // 5
println(sortedRDD3.partitions.length) // 3
```

---

* subtractByKey(otherRDD, [numPartitions])

从 `(K, V)` 类型的原 RDD 中删除与另一个 RDD 具有相同 key 的元素，返回新的 RDD。新 RDD 的分区数 == 原 RDD 的分区数。

```scala
val rdd1 = sc.parallelize(List(("a", 1), ("b", 2), ("c", 3)), 5)
val rdd2 = sc.parallelize(List(("a", 1), ("b", 2), ("d", 4)), 3)
val newR = rdd1.subtractByKey(rdd2)

println(newR) // 5

newR.collect.foreach(println) // Array(("c", 3))
```

---

* combineByKey()

聚合各分区的元素，而每个元素都是二元组。功能与基础RDD函数aggregate()差不多，可让用户返回与输入数据类型不同的返回值。

combineByKey函数的每个参数分别对应聚合操作的各个阶段。所以，理解此函数对Spark如何操作RDD会有很大帮助。

---

* combineBy()

---

* join(otherDataset, [numTasks])

对 `(K, V)` 和 `(K, W)` 类型的 RDD 进行连接操作，也就是将 key 相同的数据进行笛卡尔积操作，key 不相同的数据将被忽略，最终返回 `(K, (V, W))` 类型的 RDD。另外，支持外连接包括 leftOuterJoin、rightOuterJoin 和 fullOuterJoin。

```scala
var rdd1 = sc.parallelize(List((1, "A"), (1, "X"), (2, "B")))
var rdd2 = sc.parallelize(List((1, 'a'), (2, 'c'), (3, 'c'), (4, 'd')))

rdd1.join(rdd2).collect.foreach(println) // Array((1, (A, a)), (1, (X, a), (2, (B, c))))
rdd1.leftOuterJoin(rdd2).collect.foreach(println) // Array((1, (A, Some(a))), (1, (X, Some(a)), (2, (B, Some(c)))))
rdd1.rightOuterJoin(rdd2).collect.foreach(println) // Array((4,(None,d)), (1,(Some(A),a)), (1,(Some(X),a)), (2,(Some(B),c)), (3,(None,c)))
rdd1.fullOuterJoin(rdd2).collect.foreach(println) // Array((4,(None,Some(d))), (1,(Some(A),Some(a))), (1,(Some(X),Some(a))), (2,(Some(B),Some(c))), (3,(None,Some(c))))
```

---

* cogroup(otherDataset, [numTasks])

对 `(K, V)` 和 `(K, W)` 类型的 RDD 进行合并，先各自对 key 相同的数据聚合成 Iterable，两个 RDD 之间再按 key 相同的方式组合成笛卡尔积，最终返回 `(K, (Iterable<V>, Iterable<W>))` 类型的 RDD。cogroup 支持合并 [1, 3] 个 RDD，即：rdd.cogroup(rdd1, rdd2, rdd3, [numTasks])。新 RDD 的分区数 == max(原各个 RDD 的分区数)。

```scala
var rdd1 = sc.parallelize(List((1, "A"), (1, "X"), (1, "X"), (2, "B")), 3)
var rdd2 = sc.parallelize(List((1, 'a'), (2, 'b'), (2, 'c')), 5)

// Array((1,(CompactBuffer(A, X, X),CompactBuffer(a))), (2,(CompactBuffer(B),CompactBuffer(b, c))))
rdd1.cogroup(rdd2).collect.foreach(println)

println(rdd1.cogroup(rdd2).partitions.length) // 5
```

---

* groupWith(otherDataset)

与 cogroup 几乎一致，不同是没有参数 numTasks。

---

* aggregate()

---

* subtract(otherRDD, [numPartitions])

从 `(K, V)` 和 `V` 类型的原 RDD 中删除与另一个 RDD 中相同的元素，返回新的 RDD。

```scala
val rdd1 = sc.parallelize(List(("a", 1), ("b", 2), ("c", 3)))
val rdd2 = sc.parallelize(List(("a", 1), ("b", 2), ("c", 4), ("d", 4)))

rdd1.subtractByKey(rdd2).collect.foreach(println) // Array()
rdd1.subtract(rdd2).collect.foreach(println) // Array((c, 3))
```

---

* treeAggregate()

---

* sortBy(func, ascending: Boolean = true, numPartitions: Int = this.partitions.length)

对 `V` 类型或 `(K, V)` 类型的 RDD 进行排序，其中 func 的返回值将作为排序的方式。另外，排序并不对元素进行去重。func 函数的类型可以是 `V => V` 、 `(K, V) => K` 或 `(K, V) => V`。新 RDD 的分区数 == min(原 RDD 的元素个数，numPartitions)。

```scala
val rdd1 = sc.parallelize(List(60, 70, 80, 55, 45, 55), 3)
val rdd2 = sc.parallelize(List(("dog", 3), ("tiger", 5), ("cat", 3)), 5)

val sortedRDD1 = rdd1.sortBy(v => v, false, 11)
val sortedRDD11 = rdd1.sortBy(v => v, false, 5)
val sortedRDD2 = rdd2.sortBy(x => x._2, true, 7)
val sortedRDD22 = rdd2.sortBy(x => x._2, true, 2)

sortedRDD1.collect.foreach(println) // Array(80, 70, 60, 55, 55, 45)
sortedRDD2.collect.foreach(println) // Array(("dog", 3), ("cat", 3), ("tiger", 5))

println(sortedRDD1.partitions.length)   // 6
println(sortedRDD11.partitions.length)  // 5
println(sortedRDD2.partitions.length)   // 3
println(sortedRDD22.partitions.length)  // 2
```

---

* groupBy(func)

func 的返回值将作为一个分组。

```bash
val rdd = sc.parallelize(1 to 9, 5)
rdd.groupBy(x => {
  if (x % 2 == 0) "A"
  else if (x % 3 == 0) "B"
  else "C"
})
```

---

* keyBy(func)

将 `V` 类型的 RDD 转换为 `(K, V)` 类型的 RDD，func 函数的返回值将作为新 RDD 的 key。

```scala
val rdd = sc.parallelize(List("dog", "tiger", "cat"))
rdd.keyBy(_.length).collect.foreach(println) // Array((3, dog), (5, tiger), (3, cat))
```

---

* spanBy()

* coalesce(numPartitions, shuffle = false)

减少 RDD 的分区个数为 numPartitions 个，这在过滤大型数据集后使用是非常有用的。内部采用 HashPartitioner 的分区方式进行重新分区。新 RDD 的分区个数 == min(原 RDD 的分区个数, numPartitions)，不过不建议设置 numPartitions 大于原 RDD 的分区个数。如果 shuffle 设置为 true，则会进行 shuffle。

```scala
val rdd = sc.parallelize(List("This", "is", "a", "list"), 3)

println(rdd.coalesce(2).partitions.length) // 2
println(rdd.coalesce(5).partitions.length) // 3
```

* repartition(numPartitions)

Reshuffle the data in the RDD randomly to create either more or fewer partitions and balance it across them. This always shuffles all data over the network.

> http://www.cnblogs.com/fillPv/p/5392186.html

等价于 `coalesce(numPartitions, shuffle = true)`。

---

* keys()

返回 `(K, V)` 类型 RDD 中的所有 key，并组成新的 RDD。等价于 `map(_._1)`。

```scala
val rdd = sc.parallelize(List(("a", 1), ("b", 2), ("c", 3)))
val newRDD = rdd.keys

newRDD.collect.foreach(println) // Array(a, b, c)
```

---

* values()

返回 `(K, V)` 类型 RDD 中的所有 value，并组成新的 RDD。等价于 `map(_._2)`。

```scala
val rdd = sc.parallelize(List(("a", 1), ("b", 2), ("c", 3)))
val newRDD = rdd.values

newRDD.collect.foreach(println) // Array(1, 2, 3)
```


---

* mapWith()、 flatMapWith()

在 Spark 2.x 的版本已经不存在了。


## Action

Action 算子会提交 Spark 作业，并返回运算后的 `value`。

* reduce()

`reduce` 将 RDD 中元素两两传递给输入函数，同时产生一个新的值，新产生的值与 RDD 中的下一个元素再被传递给输入函数直到最后只有一个值为止。

```scala
val rdd = sc.textFile("R.md", 5)

// 查找出现次数对多的单词
rdd.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _).reduce((a, b) => if (a._2 > b._2) a else b)
```

---

* collect()

将各个分区的数据汇总成一个 `Array`。

```scala
val textFile = sc.textFile("README.md", 5)
val wordCounts: Array[(String, Int)] = textFile.flapMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _).collect()

wordCounts.foreach(println)
```

---

* count()

返回 RDD 中元素的个数。

```scala
sc.textFile("R.md").count()
```

---

* countByKey()

对 `(K, V)` 类型的 RDD 中 key 相同的元素的 value 进行求和，最终返回一个 `Map[K, Long]`。另外，元素的 value 不一定要是数值型，因为 countByKey 内部把元素的 value 都映射成了 `1L`。`rdd.countBykey()` 等同于 `rdd.mapValues(_ => 1L).reduceByKey(_ + _).collect.toMap`。

```bash
// 求单词数（不用在调用 collect 函数）
sc.textFile("R.md").flapMap("""[^a-zA-Z]+""").map(word => (word, 1)).countByKey.foreach(println)
```

---

* countByValue()

对 `V` 类型的 RDD 中的每个元素调用 map 函数，新 RDD 的每个元素为 `(value, null)`，然后调用 countByKey 函数对新 RDD 的 value（都是 1L） 求和，最终还是返回一个 `Map[K, Long]`。`rdd.countByValue()` 等同于 `rdd.map(value => (word, null)).countByKey()`。

```scala
sc.textFile("R.md").flapMap("""[^a-zA-Z]+"").countByValue.foreach(println)
```

---

* first()

返回 RDD 中的第一个元素。

```scala
sc.textFile("R.md").first()
```

---

* persist()

默认缓存在内存中，`def persist() = persist(StorageLevel.MEMORY_ONLY)`。

| 缓存方式 | 描述 |
| ------ | ------ |
| NONE |  |
| DISK_ONLY | 缓存数据到本地磁盘 |
| DISK_ONLY_2 |  |
| MEMORY_ONLY | 将　RDD 数据缓存在 Spark JVM 内存中 |
| MEMORY_ONLY_2  |  |
| MEMORY_ONLY_SER  | 将　RDD 数据序列化后缓存在 Spark JVM 内存中 |
| MEMORY_ONLY_SER_2  |  |
| MEMORY_AND_DISK  |  |
| MEMORY_AND_DISK_2  |  |
| MEMORY_AND_DISK_SER  |  |
| MEMORY_AND_DISK_SER_2  |  |
| OFF_HEAP  |  |

`MEMORY_ONLY`、`MEMORY_ONLY_SER` - 如果一个分区在内存中放不下，那整个分区都不会放入内存。
`MEMORY_AND_DISK`、`MEMORY_AND_DISK_SER` - 如果分区在内存中放不下，Spark 会将溢出的分布写入磁盘。

```scala
// 缓存在内存，多余的缓存在磁盘
rdd.persist(StorageLevel.MEMORY_AND_DISK)
```

---

* cache()

```scala
// 缓存在内存
def cache() = persist(StorageLevel.MEMORY_ONLY)
```

## Save

对于多个分区的操作，Spark 会写入多个 `part-X` 到文件系统中。此外，saveAsTextFile 要求保存的目录之前是没有的，否则会报错；所以，在保存前应该先判断一下目录是否存在。

```scala
val textFile = sc.textFile("README.md", 5)
val rdd = textFile.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _)

rdd.saveAsTextFile("words") // 会有 5 个 part-X 文件输出到当前项目的 words 目录中， X 从 00000 开始递增
```

## Partition

> http://blog.csdn.net/xubo245/article/details/51475506

* 分区算法

defaultPartitioner

HashPartitioner

RangePartitioner


* 自定义分区

```scala
```

* 分区操作

```scala
var rdd = sc.textFile("README.md", 5)

// 分区数
println(rdd.partitions.length)

// 各个分区的 index
rdd.partitions.foreach(println(_.index))
```



## 参考

* [理解 Spark 的核心 RDD](http://www.infoq.com/cn/articles/spark-core-rdd/)
* [那些年我们对 Spark RDD 的理解](http://blog.csdn.net/stark_summer/article/details/50218641)
* [Spark 算子使用示例](http://blog.csdn.net/u013980127/article/details/53046760)
* [Spark RDD 概念学习系列之 Spark 的算子的分类](http://www.cnblogs.com/zlslch/p/5723857.html)
* [Spark 算子](http://blog.csdn.net/tanggao1314/article/details/51582017)
* [Spark 键值对 RDD 操作](http://www.cnblogs.com/yongjian/p/6425772.html)
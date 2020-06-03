# Spark Shuffle

从逻辑角度来讲，Shuffle 过程就是一个 GroupByKey 的过程，两者没有本质区别。

## 调优

* 减少 Shuffle 次数

```scala
// 两次
rdd.map(...).repartition(1000).reduceByKey(_ + _, 3000)

// 一次
rdd.map(...).repartition(3000).reduceByKey()
```

* 必要时率先进行 Shuffle 操作以改变并行度，提供并行进行速率

```scala
rdd.repartiton(largerNumPartition).map(...)...
```

* 使用 treeReduce & treeAggregate 替换 reduce & aggregate 。数据量较大时，reduce & aggregate 一次性聚合，Shuffle 量太大，而 treeReduce & treeAggregate 是分批聚合，更为保险。

## 参考

* [Spark 性能优化：shuffle 调优](http://blog.csdn.net/u012102306/article/details/51637732)
* [Spark Sort-Based Shuffle 详解](http://blog.csdn.net/snail_gesture/article/details/50807129)
* [Spark 学习: spark 原理简述与 shuffle 过程介绍](http://blog.csdn.net/databatman/article/details/53023818)
* [Spark Shuffle 详解](https://zhuanlan.zhihu.com/p/67061627)

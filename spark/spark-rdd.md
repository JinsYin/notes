# Spark RDD

RDD，全称为 Resilient Distributed Datasets（弹性分布式数据集），是一个容错的、并行的数据结构，可以让用户显式地将数据存储到磁盘和内存中，并能控制数据的分区。

Spark RDD 支持两种类型的操作：

> * transformations: 从一个已存在的 dataset 基础上创建一个新的 dataset
>
> * actions: 在 dataset 上做完运算后返回一个 value 给 driver program


## Transformation

Transformation 返回新 RDD 的 `pointer`

* filter

```scala
sc.textFile("R.md").filter(line => line.contains("Spark"))
```


## Action

Action 返回 RDD 的 `value`

* count()

```scala
sc.textFile("R.md").count()
```

* first()

```scala
sc.textFile("R.md").first()
```

## 参考

> http://www.infoq.com/cn/articles/spark-core-rdd/
> http://blog.csdn.net/stark_summer/article/details/50218641
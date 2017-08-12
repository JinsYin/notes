# Spark GraphX

GraphX 用于图计算和图并行计算。

GraphX 的核心抽象是 `Resilient Distributed Property Graph`（弹性分布式属性图），一种点和边都带属性的 `有向多重图`。它扩展了 Spark RDD 的抽象，有 `Table` 和 `Graph` 两种视图，而只需要一份物理存储。两种视图都有自己独有的操作符，从而获得了灵活操作和执行效率。

对 Graph 视图的所有操作，最终都会转换成其关联的 Table 视图的 RDD 操作来完成。这样对一个图的计算，最终在逻辑上，等价于一系列 RDD 的转换过程。因此，Graph 最终具备了 RDD 的 3 个关键特性：Immutable、Distributed和Fault-Tolerant，其中最关键的是Immutable（不变性）。逻辑上，所有图的转换和操作都产生了一个新图；物理上，GraphX会有一定程度的不变顶点和边的复用优化，对用户透明。


## 多重图

凡是不包含环和多重边的图被称为 `简单图`。

`多重图`（multigraph）是一个允许有多重边的图，也就是有至少二个边的二个顶点完全相同，至少有二个顶点可以由二个边相连接。多重图是指存在平行边和自环的图，是离散数学和图论里的相关概念。

![多重图](./img/graph-multigraph.png)



## 开始

```scala
import org.apache.spark._
import org.apache.spark.graphx._

// To make some of the examples work we will also need RDD
import org.apache.spark.rdd.RDD
```


## 属性图（Property Graph）

Property Graph 是一个有向多重图，它带有连接到每个顶点和边的用户定义的对象。 有向多重图中多个并行(parallel)的边共享相同的源和目的地顶点。支持并行边的能力简化了建模场景，这个场景中，相同的顶点存在多种关系(例如co-worker和friend)。每个 Vertex 由一个唯一的 `64` 位长的标识符（`VertexID`）作为 key。GraphX 并没有对顶点标识强加任何排序。同样，Edge 拥有相应的源和目的 Vertex 标识符。

属性图通过vertex(VD)和edge(ED)类型参数化，这些类型是分别与每个顶点和边相关联的对象的类型。



## 计算模式/模型

* vertexProgram

* sendMessage

* messageCombiner


## 操作

* subgraph

* joinVertices

* aggregateMessages



## 参考

* [GraphX Programming Guide](http://spark.apache.org/docs/2.0.2/graphx-programming-guide.html)
* [Spark 入门实战系列 - Spark 图计算 GraphX 介绍及实例](http://www.cnblogs.com/shishanyuan/p/4747793.html)
* [Spark GraphX 原理介绍](http://blog.csdn.net/tanglizhe1105/article/details/50740295)
* [Spark 中 GraphX 指南（一）](http://blog.csdn.net/gdp12315_gu/article/details/50484178)
* [求有重边的无向图的割边算法](http://www.cnblogs.com/justPassBy/p/4387053.html)
* [POJ 3177 Redundant Paths（重边标记法，有重边的边双连通分支）](http://www.cnblogs.com/chenchengxun/p/4718736.html)
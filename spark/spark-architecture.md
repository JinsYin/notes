# Spark 架构

## 术语

* Application - 基于 Spark 开发的应用程序；即 Driver Program。
* Driver - 执行 Application 的 main() 函数，并且在集群上执行各种并行计算的 `进程`。
* RDD

Spark 最重要的一个抽象概念就是弹性分布式数据集（Resilient Distributed Dataset - RDD），RDD 是一个可分区的（partitioned）元素集合，其包含的元素可以分布在集群各个节点上，并且可以执行一些分布式并行操作。

* Shared Variables

Spark 第二个重要抽象概念是 `共享变量` （Shared Variableds）,共享变量是一种可以在并行操作之间共享使用的变量。默认情况下，当 Spark 把一系列任务调度到不同节点上运行时，Spark 会同时把每个变量的副本和任务代码一起发送到各个节点。但有的时候，我们需要在任务之间，或者任务和 Driver Program 之间共享一些变量。

Spark 提供了两种类型的共享变量：`广播变量` （Ｂroadcast Variables）和 `累加器` （Accumulators），广播变量可以用来在各个节点的内存中缓存数据，而累加器则仅仅用来执行跨节点的“累加”（added）操作，例如：计数（counter）和求和（sum）。

* Operation（算子） - 作用于 RDD 的 Transformation 和 Action。

* Master - Master 负责将串行任务变成可并行执行的任务集Tasks
* Worker - Worker 节点负责执行任务
* Executor - Worker 上的进程，用于

每个 Worker 上存在一个或多个 Executor 进程


## ck

* [Apache Spark Jobs 性能调优（一）](https://www.zybuluo.com/xiaop1987/note/76737)
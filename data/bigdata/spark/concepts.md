# Spark 概念

* Application
* Master
  * 资源管理
  * 任务调度
  * 将串行任务转换成并行任务
* Worker
* Driver
* Executor
* Job - 由 action 算子触发的作业，一个 action 算子触发一个 job
* Stage - job 的组成单位，一个 job 被分成一个或多个 stage（以 shuffle 操作作为边界），job 中的 stage 按顺序串行执行
* Shuffle - 将 map-like 算子的输出汇聚成 reduce-like 算子的输入的过程
  * Shuffle Write - 前一个 stage 将 map-like 算子的输出写入内存缓冲器（默认 100MB）或磁盘
  * Shuffle Read - 后一个 stage 拉取 map-like 算子的输出结果
* Task - stage 的任务执行单元（并行执行），一个 task 对应一个 partition（一个 task 处理一个 partition 上的数据）

## 触发 Shuffle 的算子

| 类别           | 算子                                                  |
| -------------- | ----------------------------------------------------- |
| repartition 类 | repartition、coalesce                                 |
| *byKey 类      | groupByKey、reduceByKey、combineByKey、aggregateByKey |
| join 类        | cogroup、join                                         |

简单的说就是需要进行数据迁移的算子。

## 参考

* [spark 中 job stage task 关系](https://www.cnblogs.com/wzj4858/p/8204411.html)
* [Spark Shuffle 详解](https://zhuanlan.zhihu.com/p/67061627)

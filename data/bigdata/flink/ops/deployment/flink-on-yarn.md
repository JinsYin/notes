# Flink on YARN

Apache Flink 提供了两种方式在 YARN 中运行 Flink 集群或 Flink Job。

## 前提

* [Flink 集成 Hadoop](hadoop-integration.md)

## 会话模式

Flink 运行在一个 YARN Application 中。

该模式下会启动一个 YARN 会话，该回话将启动 JobManager 和 TaskManager 服务，以便可以提交任务给集群（每个会话可以运行多个程序）。

前提：

* Hadoop 2.2+
* HDFS 或者其他被 Hadoop 支持的分布式文件系统
* 配置 YARN_CONF_DIR 或 HADOOP_CONF_DIR 环境，以便 Flink 读取 Hadoop 或 YARN 的配置

启动 Flink 会话：

```sh
$ cd flink-x.y.z/ # 必须事先集成 Hadoop

$ ./bin/yarn-session.sh -jm 1024m -tm 4096m -s 2 # -s: 每个 TaskManger 的处理器核数
...
...
JobManager Web Interface: http://<host>:44541   # 日志
```

提交作业：

* `http://<host>:44541` Flink Dashboard 中提交
* `./bin/flink run ./examples/batch/WordCount.jar` - 客户端可以确定 YARN 运行的 JobManager 的地址。此外，可以传递 `-m` 参数指定 JobManager 的地址，端口号与 Web 接口端口号相同。

结论：

* YARN 会创建一个 application 并赋予一个 container 来运行 JobManager，没有任务运行时不会创建 TaskManager
* 当 JobManager（YARN application）提交作业后（可以在 Dashboard 中提交），YARN 会自动创建新的 container， 与此同时创建 TaskManager 并将 container 资源给到 TaskManager
* `yarn-session.sh` 进程必须一直打开，否则 YARN 会 kill 该 application
* 向 YARN 提交作业后，会在 HDFS 上创建 `/user/<user>/.flink/application_xxx_yyy/` 目录，用于存放运行的 application 所需的 jar 及各种文件。

| 参数               | 描述     |
| ------------------ | -------- |
| `-d`, `--detached` | 后台运行 |

## 作业模式

直接由 YARN 来调度和运行 Flink 作业。

```sh
$ cd flink-x.y.z/ # 必须事先集成 Hadoop

$ ./bin/flink run -m yarn-cluster -d -p 4 -yjm 1024m -ytm 4096m ./examples/batch/WordCount.jar
```

## 参考

* [YARN Setup](https://ci.apache.org/projects/flink/flink-docs-stable/ops/deployment/yarn_setup.html)

# Flink 独立集群部署

## 环境

| IP       | Role   | Hostname      |
| -------- | ------ | ------------- |
| 10.0.0.1 | master | flink-master  |
| 10.0.0.2 | worker | flink-worker1 |
| 10.0.0.3 | worker | flink-worker2 |

```sh
# 同步到所有节点
$ cat /etc/hosts
10.0.0.1 flink-master
10.0.0.2 flink-worker1
10.0.0.3 flink-worker2
```

## 要求

* Java 1.8+
* SSH（每个节点必须运行 `sshd`，确保 master 节点无密钥访问所有 worker 节点）
* Flink 在每一个节点上的安装路径必须保持一致

## 下载

```sh
```

## 配置

JAVA_HOME

```sh
$ env | grep JAVA_HOME
```

`conf/flink-conf.yaml`:

```yaml
env.java.home: /path/to/java/jdk
```

Master 配置：

```yaml
jobmanager.rpc.address: 10.0.0.1       # master 的主机名（/etc/hosts）或者 IP 地址
jobmanager.heap.size: 1024m            # master 节点 JobManager JVM 堆大小
taskmanager.memory.process.size: 4096m # worker 节点允许分配的最大内存 (TaskManager + JVM 元数据 + 其他开销)
taskmanager.numberOfTaskSlots: 4       # worker 节点可用的最大 CPU 核数
```

Worker 配置：

```yaml
# taskmanager.memory.process.size: xxx # 覆盖 master 节点配置的值 # or: taskmanager.memory.flink.size
```

### 配置 conf/slaves

所有 worker 节点的 IP/Hostname

```sh
10.0.0.2
10.0.0.3
```

## 拷贝

```sh
# 必须和 master 节点的路径相同
$ scp -r flink/ user@flink-worker1:~
$ scp -r flink/ user@flink-worker2:~
```

## 启动集群

```sh
# flink-master 节点
$ bin/start-cluster.sh
```

👆：

* 启动了一个 JobManager
* 通过 SSH 连接所有 worker 节点以启动 TaskManager

## 加入集群

添加 JobManager 示例到已有集群：

```sh
$ bin/jobmanager.sh ((start|start-foreground) [host] [webui-port])|stop|stop-all
```

添加 TaskManager 示例到已有集群：

```sh
$ bin/taskmanager.sh start|start-foreground|stop|stop-all
```

具体：

```sh
# flink-worker1 & flink-worker2 节点
$ bin/taskmanager.sh start
```

## 验证

```sh
$ open http://10.0.0.1:80
```

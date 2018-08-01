# HDFS 命令

Hadoop 1.0 和 2.0 命令有所不同，有些已经过时（hadoop fsck, hadoop dfsadmin），有些还勉强可以用（hadoop fs）。

## namenode

```bash
$ hdfs namenode -format # 格式化 namenode（第一次启动 namenode 时应用）
```

## classpath

```bash
$ hdfs classpath
```

## dfs

[FileSystem shell](./fs-shell.md)

## fsck

```bash
$ hdfs fsck -move # 转移缺损文件（例如某个节点挂了）到 /lost+found
$ hdfs fsck -delete # 删除缺损文件
$ hdfs fsck -locations # 
```

## dfsadmin

```bash
$ hdfs dfsadmin -report # 查看 namenode 和 datanode 等信息
$ hdfs dfsadmin -refreshNodes # 刷新所有节点
$ hdfs dfsadmin -safemode [get | enter | leave | wait] # 安全模式下只允许读不允许写。当有程序对 hdfs 进行读写操作时，hadoop 集群自动进入安全模式。
```

## HDFS 集群服务

Hadoop 2.x 支持使用 `hdfs` 命令来启动 HDFS 集群，这可以用于运行 docker 容器服务。

> hadoop 2.7.2 命令行启动 namenode 存在 bug，所以升级到 2.7.3。

namenode
```bash
$ mkdir -p /data/hdfs/dfs/name
$ hdfs namenode -format -D dfs.namenode.name.dir=/data/hdfs/dfs/name # 这里还存在 bug，指定的配置依然无效
$ hdfs namenode \
-D fs.defaultFS=hdfs://0.0.0.0:9000 \
-D hadoop.tmp.dir=/data/hdfs \
-D dfs.namenode.name.dir=/data/hdfs/dfs/name \
-D dfs.replication=3 \
-D dfs.namenode.datanode.registration.ip-hostname-check=false \
-D dfs.permissions.enabled=false
```

datanode
```bash
$ mkdir -p /data/hdfs/dfs/data
$ hdfs datanode \
-fs hdfs://xxx.xxx.xxx.xxx:9000 \
-D hadoop.tmp.dir=/data/hdfs \
-D dfs.datanode.data.dir=/data/hdfs/dfs/data \
-D dfs.permissions.enabled=false
```

## HDFS 高可用集群

HDFS High Availability Using the Quorum Journal Manager。



## 参考文章

> [HDFS Commands Guide](http://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-hdfs/HDFSCommands.html)
> [Hadoop Commands Guide](http://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-common/CommandsManual.html)


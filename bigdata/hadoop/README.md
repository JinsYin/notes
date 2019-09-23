# Hadoop

Hadoop 版本： `2.7.2`

## 目录

- [Hadoop 配置](./hadoop-config.md)
- [FS shell](./fs-shell.md)
- [HDFS 命令](./hdfs-command.md)
- [YARN 命令](./yarn-command.md)

## 主机集群

- [单机集群](http://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/SingleCluster.html)
- [分布式集群](http://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/ClusterSetup.html)

## 高可用集群

在 hadoop 2.0.0 以前，HDFS 集群的 NameNode 存在单点问题，如果 NameNode 节点出现故障，整个集群将不可用。

HDFS 的高可用为在同一个集群提供了两个冗余的 NameNode，一个 `主`（Active），一个 `备`（Standby），`主` 负责客户端请求， `备` 维持状态以提供快速容错。这样，如果 NameNode 节点宕机了可以快速切换到新的 NameNode。

为了让 Active NameNode 节点同步 Standby Namenode 节点的状态，需要一组 JournalNodes（JNs）来建立两者的通信。JournalNode 至少 3 个且应该奇数个, N 个节点可以容错 (N - 1)/2。

> Note that, in an HA cluster, the Standby NameNode also performs checkpoints of the namespace state, and thus it is not necessary to run a Secondary NameNode, CheckpointNode, or BackupNode in an HA cluster

> [HDFS High Availability Using the Quorum Journal Manager](https://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-hdfs/HDFSHighAvailabilityWithQJM.html)

> [Hadoop HA 高可用集群配置详解](http://www.linuxidc.com/Linux/2016-08/134180.htm)

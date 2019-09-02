# hadoop 配置文件

`core-site.xml` 和 `hdfs-site.xml` 是 hdfs 的配置文件。
`mapred-site.xml` 和 `yarn-site.xml` 是 mapreduce 和 yarn 的配置文件。

## 常用集群配置

1. core-site.xml

`fs.defaultFS` 用于指定 namenode 的地址和端口（默认端口是 `8020`）。默认配置：[core-default.xml](http://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-common/core-default.xml)。

namenode 和 datanode 节点需要配置
```xml
<property>
    <name>fs.defaultFS</name>
    <value>hdfs://xxx.xxx.xxx.xxx:9000</value>
</property>
```

`hadoop.tmp.dir` 用于指定 hadoop 数据存储的 `根` 路径。配置该参数后，`dfs.namenode.name.dir` 可以不用配置，其默认值为 `file://${hadoop.tmp.dir}/dfs/name`；`dfs.datanode.data.dir` 也可以不配置，其默认值为 `file://${hadoop.tmp.dir}/dfs/data`。

建议 namenode 和 datanode 节点都不配置，直接配置 `dfs.namenode.name.dir` 和 `dfs.datanode.data.dir`即可。如果嫌麻烦，也可以只配置该参数，其他跟路径相关的参数不配置。
```xml
<property>
    <name>hadoop.tmp.dir</name>
    <value>/data/hdfs</value>
</property>
```


2. hdfs-site.xml

`dfs.namenode.name.dir` 用于指定 namenode 数据存储的路径，该路径是相对于 `根`路径而言的。默认配置：[hdfs-default.xml](http://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)

namenode 节点需要配置
```xml
<!-- 默认值是 file://${hadoop.tmp.dir}/dfs/name -->
<property>
    <name>dfs.namenode.name.dir</name>
    <value>/data/hdfs/dfs/name</value>
</property>
```

datanode 节点需要配置
```xml
<!-- 默认值是 file://${hadoop.tmp.dir}/dfs/data -->
<property>
    <name>dfs.datanode.data.dir</name>
    <value>/data/hdfs/dfs/data</value>
</property>
```

`dfs.replication` 用于指定数据的副本数。

namenode 节点需要配置，datanode 节点可配可不配
```xml
<!-- 默认值是 3 -->
<property>
    <name>dfs.replication</name>
    <value>2</value>
</property>
```

`dfs.namenode.datanode.registration.ip-hostname-check` 用于主机名与 ip 之间的校验，默认值是 true。

如果使用主机部署的话，需要在主机的 `/etc/hosts` 和/或 hadoop 的  `etc/hadoop/slaves` 中添加 hostname 和/或 ip，这样，对加入集群的 datanode 就可控，避免其他节点加入 hadoop 集群中。

如果是 docker 部署的话，hostname 和 ip 都是随机生成的，导致没有办法作 hostname 与 ip 的校验，所有必须关闭它。

namenode 节点需要配置，datanode 节点可配可不配
```xml
<!-- 默认值是 true -->
<property>
    <name>dfs.namenode.datanode.registration.ip-hostname-check</name>
    <value>false</value>
</property>
```

namenode 和 datanode 节点需要配置
```xml
<!-- 默认值是 true -->
<property>
    <name>dfs.permissions.enabled</name>
    <value>false</value>
</property>
```


3. mapred-site.xml

默认配置：[mapred-default.xml](http://hadoop.apache.org/docs/r2.7.3/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)

```xml
<!-- 默认值是 local -->
<property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
</property>
```


4. yarn-site.xml

默认配置：[yarn-default.xml](http://hadoop.apache.org/docs/r2.7.3/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)

```xml
<!-- 默认值为空 -->
<property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
</property>
```


## 高可用集群配置

1. core-site.xml

```xml
<property>
  <name>fs.defaultFS</name>
  <value>hdfs://ha_hdfs</value>
</property>
```

```xml
<property>
  <name>ha.zookeeper.quorum</name>
  <value>zk1.example.com:2181,zk2.example.com:2181,zk3.example.com:2181</value>
</property>
```

```sh
$ $HADOOP_PREFIX/bin/hdfs zkfc -formatZK
```

2. hdfs-site.xml

```xml
<property>
    <name>dfs.nameservices</name>
    <value>ha_hdfs</value>
</property>
```

```xml
<property>
  <name>dfs.ha.namenodes.ha_hdfs</name>
  <value>nn1,nn2</value>
</property>
```

```xml
<property>
  <name>dfs.namenode.rpc-address.ha_hdfs.nn1</name>
  <value>nn1.example.com:8020</value>
</property>

<property>
  <name>dfs.namenode.rpc-address.ha_hdfs.nn2</name>
  <value>nn2.example.com:8020</value>
</property>
```

```xml
<property>
  <name>dfs.namenode.http-address.ha_hdfs.nn1</name>
  <value>nn1.example.com:50070</value>
</property>
<property>
  <name>dfs.namenode.http-address.ha_hdfs.nn2</name>
  <value>nn2.example.com:50070</value>
</property>
```

```xml
<property>
  <name>dfs.namenode.shared.edits.dir</name>
  <value>qjournal://jn1.example.com:8485;jn2.example.com:8485;jn3.example.com:8485/ha_hdfs</value>
</property>
```

```xml
<property>
  <name>dfs.client.failover.proxy.provider.ha_hdfs</name>
  <value>org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider</value>
</property>
```

自动容错
```xml
<property>
  <name>dfs.ha.automatic-failover.enabled</name>
  <value>true</value>
</property>
```

`dfs.journalnode.edits.dir` JournalNode 的日志存储路径
```xml
<property>
  <name>dfs.journalnode.edits.dir</name>
  <value>/data/hdfs/dfs/journal</value>
</property>
```

`dfs.ha.fencing.methods` 参数比较重要。主备架构解决单点故障问题时，必须要认真解决的是脑裂问题，即出现两个 master 同时对外提供服务，导致系统处于不一致状态，可能导致数据丢失等潜在问题。在 HDFS HA 中， JournalNode 只允许一个 NameNode 写数据，不会出现两个 Active NameNode 的问题，但是，当主备切换时，之前的 Active NameNode 可能仍在处理客户端的 RPC 请求，为此，需要增加隔离机制（ fencing ）将之前的 Active NameNode 杀死。 HDFS 允许用户配置多个隔离机制，当发生主备切换时，将顺次执行这些隔离机制，直到一个返回成功。 Hadoop 2.0 内部打包了两种类型的隔离机制，分别是 shell  和 sshfence 。

1) sshfence 方式
sshfence 通过 ssh 登录到前一个 ActiveNameNode 并将其杀死。为了让该机制成功执行，需配置免密码 ssh 登陆（注意：这个为主备节点配置双向的 RSA 免密码登陆），这可通过参数 dfs.ha.fencing.ssh.private-key-files 指定一个私钥文件。
```xml
<property>
  <name>dfs.ha.fencing.methods</name>
  <value>sshfence</value>
</property>

<property>
  <name>dfs.ha.fencing.ssh.private-key-files</name>
  <value>/home/exampleuser/.ssh/id_rsa</value>
</property>

<!-- 可选.设置一个超时时间，一旦 ssh 超时，则执行失败 -->
<property>
  <name>dfs.ha.fencing.ssh.connect-timeout</name>
  <value>30000</value>
</property>
```

2)  shell 方式
执行自定义的 Shell 脚本命令隔离旧的 ActiveNameNode 。相比于 sshfence 方式，个人认为这种方式有个好处就是，你在 shell 脚本里边可以将之前的 Active NameNode 直接 kill 掉，然后立马启动 NameNode ，此时刚刚启动的 NameNode 就是立马处于一个 StandBy 状态，立马就可以进入 HA 状态，如果采用 sshfence 方式还要手动自己重启刚刚被 kill 掉的 NameNode 从而才能进入 HA （这些的前提都是，采用手动 HA 方式，之前的 Acitve NameNode 不是宕机而仅仅是 NameNode 进程挂掉）。
```xml
<property>
  <name>dfs.ha.fencing.methods</name>
  <value>shell(/path/to/my/script.sh arg1 arg2 ...)</value>
</property>
```
> shell(/bin/true)
> 注意， Hadoop 中所有参数将以环境变量的形似提供给该 shell ，但所有的“ . ”被替换成了“ _ ”，比如“ dfs.namenode.rpc-address.ns1.nn1 ”变为“ dfs_namenode_rpc-address ”。


## 参考文章

> https://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-hdfs/HDFSHighAvailabilityWithQJM.html
> http://www.tuicool.com/articles/AbQBz2
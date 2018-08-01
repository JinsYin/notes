docker run -it --name 192.168.111.203 -d -p 8485:8485 -p 8480:8480 hdfs:2.7.3 hdfs journalnode -D dfs.journalnode.edits.dir=/data/hdfs/dfs/journal



===============

export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk


export zk1=192.168.111.203
export zk2=192.168.111.204
export zk3=192.168.111.205

export 192.168.111.203=192.168.111.203
export 192.168.111.204=192.168.111.204
export 192.168.111.205=192.168.111.205

## jn1, jn2
hdfs journalnode -D dfs.journalnode.edits.dir=/data/hdfs/dfs/journal



# nn1
# hdfs namenode -format (on one of NameNodes)
hdfs namenode -D hadoop.tmp.dir=/data/hdfs -format

# hdfs namenode -initializeSharedEdits (on one of NameNodes)
hdfs namenode -D fs.defaultFS=hdfs://mycluster -D hadoop.tmp.dir=/data/hdfs -D ha.zookeeper.quorum=192.168.111.203:2181,192.168.111.204:2181,192.168.111.205:2181 -D dfs.nameservices=mycluster -D dfs.ha.namenodes.mycluster=nn1,nn2 -D dfs.namenode.rpc-address.mycluster.nn1=192.168.111.206:8020 -D dfs.namenode.rpc-address.mycluster.nn2=192.168.111.207:8020 -D dfs.namenode.http-address.mycluster.nn1=192.168.111.206:50070 -D dfs.namenode.http-address.mycluster.nn2=192.168.111.207:50070 -D dfs.namenode.shared.edits.dir="qjournal://192.168.111.203:8485;192.168.111.204:8485;192.168.111.205:8485/mycluster" -D dfs.client.failover.proxy.provider.mycluster=org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider -D dfs.ha.automatic-failover.enabled=true -D dfs.ha.fencing.methods="shell(/bin/true)" -initializeSharedEdits

# hdfs zkfc -format (on one of NameNodes)
# 在 zoookeeper 中初始化 HA 状态, 在任意一台 NameNode上执行一次.(ENV formatzk_forced=false)
bin/hdfs zkfc -D ha.zookeeper.quorum=192.168.111.203:2181,192.168.111.204:2181,192.168.111.205:2181 -D dfs.nameservices=mycluster -D dfs.ha.namenodes.mycluster=nn1,nn2 -D dfs.namenode.rpc-address.mycluster.nn1=192.168.111.206:8020 -D dfs.namenode.rpc-address.mycluster.nn2=192.168.111.207:8020 -D dfs.client.failover.proxy.provider.mycluster=org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider -D dfs.ha.automatic-failover.enabled=true -formatZK

hdfs namenode -D fs.defaultFS=hdfs://mycluster -D hadoop.tmp.dir=/data/hdfs -D ha.zookeeper.quorum=192.168.111.203:2181,192.168.111.204:2181,192.168.111.205:2181 -D dfs.nameservices=mycluster -D dfs.ha.namenodes.mycluster=nn1,nn2 -D dfs.namenode.rpc-address.mycluster.nn1=192.168.111.206:8020 -D dfs.namenode.rpc-address.mycluster.nn2=192.168.111.207:8020 -D dfs.namenode.http-address.mycluster.nn1=192.168.111.206:50070 -D dfs.namenode.http-address.mycluster.nn2=192.168.111.207:50070 -D dfs.namenode.shared.edits.dir="qjournal://192.168.111.203:8485;192.168.111.204:8485;192.168.111.205:8485/mycluster" -D dfs.client.failover.proxy.provider.mycluster=org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider -D dfs.ha.automatic-failover.enabled=true -D dfs.ha.fencing.methods="shell(/bin/true)"

## nn2

hdfs namenode -D fs.defaultFS=hdfs://mycluster -D hadoop.tmp.dir=/data/hdfs -D ha.zookeeper.quorum=192.168.111.203:2181,192.168.111.204:2181,192.168.111.205:2181 -D dfs.nameservices=mycluster -D dfs.ha.namenodes.mycluster=nn1,nn2 -D dfs.namenode.rpc-address.mycluster.nn1=192.168.111.206:8020 -D dfs.namenode.rpc-address.mycluster.nn2=192.168.111.207:8020 -D dfs.namenode.http-address.mycluster.nn1=192.168.111.206:50070 -D dfs.namenode.http-address.mycluster.nn2=192.168.111.207:50070 -D dfs.namenode.shared.edits.dir="qjournal://192.168.111.203:8485;192.168.111.204:8485;192.168.111.205:8485/mycluster" -D dfs.client.failover.proxy.provider.mycluster=org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider -D dfs.ha.automatic-failover.enabled=true  -D dfs.ha.fencing.methods="shell(/bin/true)" -bootstrapStandby


hdfs namenode -D fs.defaultFS=hdfs://mycluster -D hadoop.tmp.dir=/data/hdfs -D ha.zookeeper.quorum=192.168.111.203:2181,192.168.111.204:2181,192.168.111.205:2181 -D dfs.nameservices=mycluster -D dfs.ha.namenodes.mycluster=nn1,nn2 -D dfs.namenode.rpc-address.mycluster.nn1=192.168.111.206:8020 -D dfs.namenode.rpc-address.mycluster.nn2=192.168.111.207:8020 -D dfs.namenode.http-address.mycluster.nn1=192.168.111.206:50070 -D dfs.namenode.http-address.mycluster.nn2=192.168.111.207:50070 -D dfs.namenode.shared.edits.dir="qjournal://192.168.111.203:8485;192.168.111.204:8485;192.168.111.205:8485/mycluster" -D dfs.client.failover.proxy.provider.mycluster=org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider -D dfs.ha.automatic-failover.enabled=true  -D dfs.ha.fencing.methods="shell(/bin/true)"

## transitionToActive
hdfs datanode -D fs.defaultFS=hdfs://mycluster -D dfs.datanode.data.dir=/data/hdfs/dfs/data -D ha.zookeeper.quorum=192.168.111.203:2181,192.168.111.204:2181,192.168.111.205:2181 -D dfs.nameservices=mycluster -D dfs.ha.namenodes.mycluster=nn1,nn2 -D dfs.namenode.rpc-address.mycluster.nn1=192.168.111.206:8020 -D dfs.namenode.rpc-address.mycluster.nn2=192.168.111.207:8020 -D dfs.namenode.http-address.mycluster.nn1=192.168.111.206:50070 -D dfs.namenode.http-address.mycluster.nn2=192.168.111.207:50070 -D dfs.namenode.shared.edits.dir="qjournal://192.168.111.203:8485;192.168.111.204:8485;192.168.111.205:8485/mycluster" -D dfs.client.failover.proxy.provider.mycluster=org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider -D dfs.ha.automatic-failover.enabled=true -D dfs.permissions.enabled=false


## dd1

hdfs datanode -D fs.defaultFS=hdfs://mycluster -D dfs.datanode.data.dir=/data/hdfs/dfs/data -D ha.zookeeper.quorum=192.168.111.203:2181,192.168.111.204:2181,192.168.111.205:2181 -D dfs.nameservices=mycluster -D dfs.ha.namenodes.mycluster=nn1,nn2 -D dfs.namenode.rpc-address.mycluster.nn1=192.168.111.206:8020 -D dfs.namenode.rpc-address.mycluster.nn2=192.168.111.207:8020 -D dfs.namenode.http-address.mycluster.nn1=192.168.111.206:50070 -D dfs.namenode.http-address.mycluster.nn2=192.168.111.207:50070 -D dfs.namenode.shared.edits.dir="qjournal://192.168.111.203:8485;192.168.111.204:8485;192.168.111.205:8485/mycluster" -D dfs.client.failover.proxy.provider.mycluster=org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider -D dfs.ha.automatic-failover.enabled=true -D dfs.permissions.enabled=false

## 手动切换 Active NameNode

hdfs haadmin-transitionToActive nn1

## nn2 转化为 Acive NameNode
hdfs haadmin-failover --forcefence --forceactive nn1 nn2


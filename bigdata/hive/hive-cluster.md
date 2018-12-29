# Hive 高可用集群

## Hive 知识点

* Hive 是构建在 Hadoop 之上的数据仓库平台。
* Hive 是一个 SQL 解析引擎，它将 SQL 语句转换成 MapReduce 作业并在 Hadoop 上执行。
* Hive 表是 HDFS 的一个文件目录，一个表对应一个目录名，如果有分区的话，则分区值对应目录名。
* Hive 不支持对数据的修改和添加。
* 使用 Mysql 作为 Hive 的元数据存储，减少了查询过程中执行语义检查的时间。
* Hive 没有集群之说，但 Hive 支持使用 zookeeper 作高可用（HA）。

## 混淆知识点

1. Hadoop

Hive 依赖 Hadoop 的 HDFS 和 MapReduce，其中 HDFS 作底层数据存储，MapReduce 作数据计算。具体配置如下：

* $HIVE_HOME/conf/hive-env.sh 和 /etc/environment 中指定 HADOOP_HOME 和 HADOOP_CONF_DIR 路径。（前提当然是下载并安装了 hadoop-bin）

* $HADOOP_HOME/etc/hadoop/core-site.xml 配置

```xml
<property>
  <name>fs.defaultFS</name>
  <value>hdfs://192.168.1.xxx:9000</value>
</property>
```

注意：并不需要启动 Hadoop 服务，只需要像上面一样指定远程 HDFS 路径即可，其他都不用配置。我试过在 hiveserver2 启动的时候指定 HDFS 路径，不过并不 work。（hive --service hiveserver --hiveconf fs.defaultFS=hdfs://xxx:9000）

测试一下：

```bash
$ hdfs dfs -ls /
$ hive --service metatool -listFSRoot (嵌入模式好像不行)
```

1. hiveserver/hiveserver2/metastore

hiveserver2 并不是 hive2.0 版本提供的服务，而是在 0.11.0 版本开始为支持多客户端并发而提供的，而 hiveserver 只支持单一客户端。
最容易混淆的是 hiveserver2 和 metastore，从配置文件也可以体验出来。
通常所指的 metastore 包括 metastore database（derby, mysql, postgresql, oracle..）和 metastore service (hive –service metastore, 默认端口是9083)

Metastore 支持三种部署模式：

* 嵌入模式（Embedded Mode）

![png1](https://github.com/wangruofanWRF/notes/blob/master/mesos/png/png1.png)

该模式仅支持单用户操作，使用 derby 数据库作为 hive 元数据存储库，并集成到了 hive 中, database 和 metastore 服务都作为内置服务运行在 hiveserver2 主进程中，所以不需要单独启动 metastore 服务（hive --service metastore）。不用修改配置文件，只需要两个以下几步：
	a) schematool -dbType derby -initSchema (从 hive2.1 开始需要运行)
	b) hive --service hiveserver2 (可选：cp hive-default.xml.template hive-site.xml)
	测试一下：netstat -tpln | grep 10000
	本地： hive 或者 beeline -u jdbc:hive2://localhost:10000/default -n APP -p mine
	远程： beeline -u jdbc:hive2://192.168.1.xxx:10000/default -n APP -p mine

* 本地模式（Local Mode）

![png2](https://github.com/wangruofanWRF/notes/blob/master/mesos/png/png2.png)

该模式 metastore service 作为内置服务运行在 hiveserver2（默认端口 10000 ）主进程中（不用单独启动 hive –service metastore，默认端口 9083），metastore database（mysql 等等）则运行在另外一个进程，或者另一台主机。metastore service 和 metastore database 之间通过 jdbc 通信。如果使用远程 MySQL：
	a) mysql 增加远程和用户访问权限
  ```bash
	sed -i 's|bind-address.*|bind-address = 0.0.0.0' /etc/mysql/my.cnf
	service mysql restart
	mysql -h 192.168.1.xxx -u root -p
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'hive123456' WITH GRANT OPTION; # remote login
	flush privileges; # 使权限生效
```
b) mysql-connector-java
```bash
	MYSQL_CONNECTOR_VERSION=5.1.40
	wget -O $HIVE_HOME/lib/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.jar \
 http://central.maven.org/maven2/mysql/mysql-connector-java/$MYSQL_CONNECTOR_VERSION/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.jar
```
b) hive-site.xml 中配置 mysql  (cp hive-default.xml.template hive-site.xml)
```bash
		javax.jdo.option.ConnectionURL ==  jdbc:mysql://192.168.1.xxx/metastore?createDatabaseIfNotExist=true&amp;useSSL=false
		 javax.jdo.option.ConnectionDriverName ==  com.mysql.jdbc.Driver
		 javax.jdo.option.ConnectionUserName == root
		 javax.jdo.option.ConnectionPassword ==  hive123456
```
c) 还有几个 property 需要配置一下（$HIVE_HOME 改成实际路径）
```bash
	hive.exec.local.scratchdir == $HIVE_HOME/tmp
	hive.downloaded.resources.dir ==  $HIVE_HOME/tmp/resources
	hive.querylog.location == $HIVE_HOME/tmp/querylog
	hive.server2.logging.operation.log.location == $HIVE_HOME/tmp/operation_logs
```
d) schematool -dbType mysql -initSchema (从 hive2.1 开始需要运行)

e) hive --service hiveserver2 （netstat -tpln | grep 10000），内置 metastore service。

f) 测试同上
	注意：该模式并不需要配置 hive.metastore.uris，我配置为 thrift://0.0.0.0:9083 后 hiveserver2 就一直启动不了。因为这表示连接本机的 metastore service，而该服务并没有在本机启动。

* 远程模式（Remote Mode）

像 local 模式那样，启动多个 hiveserver2 组成高可用集群就可以了（local 模式 metastore service 内置在 hiveserver2 中，没有 9083 端口服务），为什么还要单独启动 metastore service 呢？

![png3](https://github.com/wangruofanWRF/notes/blob/master/mesos/png/png3.png)

如图，如果 metastore service 还要对 Impala, HCatalog 等提供对外服务时，我们需要再启动 metastore service。可以启动多个节点，并使用同一个 hdfs 和同一个 metastore database(mysql)。
这种模式 hive metastore service 独自运行在 jvm 进程中，HiveServer2, HCatalog 以及其他进程通过 Thrift 网络与 metastore service 通信。所以，我们可以在一个或多个节点启动 metastore service (hive --service metastore, 不用配置 hive.metastore.uris，配置完全同 local mode， 如果是多台的话只需要执行一次 schematool -initSchema -dbType mysql <从 hive2.1 开始需要运行>), 在另一个或多个节点启动 hiveserver2 (hive –service hiveserver2, 需要指定远程 hive.metastore.uris： thrift://192.168.1.1:9083，thrift://192.168.1.2:9083，thrift://192.168.1.3:9083)， 用逗号分隔。

总结一下：
metastore database (mysql), metastore service , hiveserver2 可以在同一台机器上，也可以在不同的主机上，只是配置有些不同。

部署建议：
（方案一）需要使用 HCatalog, Impala 时
metastore database（mysql） 在一台主机，metastore service 在多台主机(远程连 metastore database)，另外部署多台高可用 hiveserver2 (通过 hive.metastore.uris 远程到多个 metastore service)。当然，也可以在一个节点上同时部署 metastore service 和 hiveserver2。
mysql(一台) ← hive –service metastore（多台） ← hive –service hiveserver2 (多台，使用 haproxy 或和 zookeeper 组成高可用集群)

（方案二）不使用 HCatalog, Impala 时
mysql(一台)  ← hive –service hiveserver2 (多台，内置 Metastore service, 使用 haproxy 或和 zookeeper 组成高可用集群)

### 3. hiveserver2 的高可用模式 （hive-site.xml 中修改）
hiveserver2 的高可用有两种方式，一种是用 haproxy 作负载均衡(过程略)，一种是用 zookeeper 作 leader 选举。也可以两种模式一起使用。
zookeeper 方式需要修改配置：
hive.server2.thrift.bind.host == 192.168.1.x (需要填写确切的主机 IP，不然 zookeeper 无法通过主机名发现彼此，除非添加 /etc/hosts 主机 IP 对应信息)
```bash
  hive.server2.support.dynamic.service.discovery == true
	hive.zookeeper.quorum == 192.168.1.1:2181，192.168.1.2:2181，192.168.1.3:2181
	hive.zookeeper.namespace == hiveserver2
```
	测试一下（我还是连接不上）：
```bash
  beeline -u
  jdbc:hive2://host1.com:2181,host2.com:2181,host3.com:2181;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2
  -n root
  -p hive123456
```
4. metastore service 的高可用
	很奇怪，为什么 metastore service 还有高可用！其实，metastore service 的高可用是针对 metastore client 端的，而不是针对 metastore server 端的。具体如下：
1) 启动多个独立的 metastore service (hive –service metastore), 但要求使用相同的 hdfs 和 metastore database (mysql).
2)metastore client 端（如 hiveserver2）在使用 metastore service 的时候指定多个地址，hive.metastore.uris == thrift://host1:9083,thrift://host2:9083,thrift://host3:9083 (逗号分隔)

4. hive/beeline 命令
a) hive 完全等价于 hive --service cli
b) beeline 完全等价于 hive –service beeline
b) hive 只支持本地连接， 而 beeline 支持本地和远程连接
c) hive 既可以连接 hiveserver2（hive –service hiveserver2, port:10000）, 又可以连接 metastore service(hive –service metastore, port: 9083)
d) beeline 连接的是 hiveserver2, hiveserver2 再连接到内置或者远程的 metastore service

3.版本
```bash
# 系统：centos 7
hive --service version： 1.2.1
java –version # 1.8.0
hadoop version # 2.7.2
```

4.主从节点
```bash
# cat /etc/hosts
192.168.1.122   clusterSlave1
192.168.1.124   clusterSlave3
192.168.1.126   clusterSlave5
```

5.主节点安装 mysql
```bash
## 只在clusterMaster 上安装mysql-server
yum install mysql-server -y
service mysqld start

## 设置密码
   mysql –u root -p
> set password 'root'@'localhost' = password('Hive.123456')
```

6.主节点配置 hive
```bash
## clusterMaster
## 下载并解压Hive-2.1.1
## vi /root/.bashrc
HIVE_HOME=/root/Cloud/apache-hive-2.1.1-bin
PATH=$PATH:$HIVE_HOME/bin


source /root/.bashrc

## cd $HIVE_HOME/conf
## cp hive-default.xml.template hive-site.xml
## vim hive-site.xml

<name>javax.jdo.option.ConnectionURL</name>
<value>jdbc:mysql://127.0.0.1:3306/hive?createDatabaseIfNotExist=true&amp;useSSL=false</value>

<name>javax.jdo.option.ConnectionDriverName</name>
<value>com.mysql.jdbc.Driver</value

<name>javax.jdo.option.ConnectionUserName</name>
<value>root</value>

## 192.168.1.121 mysql password: Hive.123456
<name>javax.jdo.option.ConnectionPassword</name>
<value>Hive.123456</value>

#######################

<name>hive.exec.local.scratchdir</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp</value>

<name>hive.downloaded.resources.dir</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp/resources</value>

<name>hive.querylog.location</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp/querylog</value>

<name>hive.server2.logging.operation.log.location</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp/operation_logs</value>

##################################

<name>hive.metastore.uris</name>
<value>thrift://clusterMaster:9083</value>

## Hive Web Interface
<name>hive.hwi.listen.host</name>
<value>0.0.0.0</value>

<name>hive.hwi.listen.port</name>
<value>9999</value>


$HADOOP_HOME/bin/hadoop fs -mkdir /tmp
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w /tmp
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse # hive.metastore.warehouse.dir
```

7.从节点
```bash
## 主节点clusterMaster
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.122/root/Cloud/
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.124/root/Cloud/
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.126/root/Cloud/
   ## 别忘了改/root/.bashrc

## 从hive2.1开始，安装配置好后需要在服务端(clusterMaster)初始化metastore，初始化完成后进入mysql验证一下
## dbType还有：derby
schematool -initSchema -dbType mysql

## 在服务端（clusterMaster）启动metastore服务
hive --service metastore &
hive

## 在所有slave节点上运行hive命令加以验证
## Running Hive CLI
hive

## Hive2 新命令行工具
## Running HiveServer2 and Beeline
hive --service hiveserver2 & # 或者是hiveserver2 &

## beeline -u jdbc:hive2://$HS2_HOST:$HS2_PORT
beeline -u jdbc:hive2://localhost:10000 -n root –p Hive.123456
(远程写IP)
```
###################### 以下略########################

```bash
## Hive Web Interface
bin/hive --service hwi &

## Running HCatalog
hcat_server.sh
hcat

## Running WebHCat (Templeton)
webhcat_server.sh
```

### 作者
本文档由尹仁强创建，由王若凡整理

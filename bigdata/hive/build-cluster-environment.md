# Hive 集群环境搭建
### 1.Hive 知识点
Hive 是构建在 Hadoop 之上的数据仓库平台。
Hive 是一个 SQL 解析引擎，它将 SQL 语句转换成 MapReduce 作业并在 Hadoop 上执行。
Hive 表是 hdfs 的一个文件目录，一个表对应一个目录名，如果有分区的话，则分区值对应目录名。
hive 不支持对数据的修改和添加。
使用 mysql 作为 hive 的元数据存储，减少了查询过程中执行语义检查的时间。

### 2.版本
```bash
# 系统：centos 7
# Hive version： 2.1.1
java –version # 1.8.0
hadoop version # 2.6.0
```

### 3.主从节点
```bash
# cat /etc/hosts
192.168.1.121   clusterMaster
192.168.1.122   clusterSlave1
192.168.1.124   clusterSlave3
192.168.1.126   clusterSlave5
```

### 4.主节点安装 mysql
```bash
## 只在clusterMaster 上安装 mysql-server
yum install mysql-server -y
service mysqld start

## 设置密码
   mysql –u root -p
> set password 'root'@'localhost' = password('Hive.123456')
```

### 5.主节点配置 hive
```bash
## clusterMaster
## 下载并解压 Hive-2.1.1
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

<name>hive.exec.local.scratchdir</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp</value>

<name>hive.downloaded.resources.dir</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp/resources</value>

<name>hive.querylog.location</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp/querylog</value>

<name>hive.server2.logging.operation.log.location</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp/operation_logs</value>

<name>hive.metastore.uris</name>
<value>thrift://clusterMaster:9083</value>

## Hive Web Interface
<name>hive.hwi.listen.host</name>
<value>0.0.0.0</value>

<name>hive.hwi.listen.port</name>
#<value>9999</value>


$HADOOP_HOME/bin/hadoop fs -mkdir /tmp
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w /tmp
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse # hive.metastore.warehouse.dir
```

### 6.从节点
```bash
## 主节点 clusterMaster
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.122/root/Cloud/
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.124/root/Cloud/
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.126/root/Cloud/
   ## 别忘了改 /root/.bashrc

## 从 hive2.1 开始，安装配置好后需要在服务端( clusterMaster )初始化 metastore，初始化完成后进入 mysql 验证一下
## dbType 还有：derby
schematool -initSchema -dbType mysql

## 在服务端（clusterMaster）启动 metastore 服务
hive --service metastore &
hive

## 在所有 slave 节点上运行 hive 命令加以验证
## Running Hive CLI
hive

## Hive2 新命令行工具
## Running HiveServer2 and Beeline
hive --service hiveserver2 & # 或者是 hiveserver2 &

## beeline -u jdbc:hive2://$HS2_HOST:$HS2_PORT
beeline -u jdbc:hive2://localhost:10000 -n root –p Hive.123456
(远程写 IP)

###################### 以下略 ########################

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

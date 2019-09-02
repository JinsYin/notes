# HIVE1.2.0配置
### 一．wget apache-hive-1.2.0-bin
（略）
### 二．配置hive
1.在主节点安装mysql-server
```sh
yum install mysql-server –y
service mysqld start
##设置密码
mysql –u root –p
set password ‘root’@’localhost’ = password(‘Hive.123456’)
```
2.主节点配置HIVE
a)vim hive-site.xml
```sh
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
<value>9999</value>

```
b)vim hive-env.sh
```sh
export HADOOP_HOME=/root/Cloud/hadoop-2.6.0
export HIVE_CONF_DIR=/root/Cloud/apache-hive-1.2.0-bin/conf
```
yc)配置dfs  
```sh
$HADOOP_HOME/bin/hadoop fs -mkdir /tmp
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w /tmp
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse # hive.metastore.warehouse.dir
```
d)把/hive/conf下的hive-site.xml cp到/spark/conf下

e)vim spark-env.sh
```sh
export SPARK_MASTER_IP=192.168.1.121
export SPARK_WORKER_MEMORY=6G

export SPARK_DIST_CLASSPATH=$(/root/Cloud/hadoop-2.6.0/bin/hadoop classpath)
export JAVA_HOME=/root/Cloud/jdk1.8.0_60
export CLASSPATH=$CLASSPATH:/root/Cloud/apache-hive-1.2.0-bin/lib
export SCALA_HOME=/root/Cloud/scala-2.11.7
export HADOOP_CONF_DIR=HADOOP_CONF_HOME=/root/Cloud/hadoop-2.6.0/etc/hadoop
export HIVE_CONF_DIR=/root/Cloud/apache-hive-1.2.0-bin/conf
```
### 三．从节点、
1.vim /root/.bashrc
```sh
export HIVE_HOME=/root/Cloud/apache-hive-1.2.0-bin
export PATH=$HIVE_HOME/bin:$PATH
export CLASS_PATH=$CALSSPATH:$HIVE_HOME/lib
```
2.主节点
  主节点clusterMaster
```sh
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.122/root/Cloud/
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.124/root/Cloud/
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.126/root/Cloud/
```
3.
### 四．启动hive
```sh
  ## 在服务端（clusterMaster）启动metastore服务
hive --service metastore &
hive

## 在所有slave节点上运行hive命令加以验证
## Running Hive CLI
hive
```
### 五．

### 作者
本文档由尹仁强创建，由王若凡整理

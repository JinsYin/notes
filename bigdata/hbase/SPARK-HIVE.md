# HIVE1.2.0 配置
### 一．wget apache-hive-1.2.0-bin
（略）
### 二．配置 hive
1.在主节点安装 mysql-server  
```bash
yum install mysql-server –y
service mysqld start
##设置密码
amysql –u root –pset password ‘root’@’localhost’ = password(‘Hive.123456’)
```
2.主节点配置 HIVE  
a)vim hive-site.xml
```bash  <name>javax.jdo.option.ConnectionURL</name>
<value>jdbc:mysql://127.0.0.1:3306/hive?createDatabaseIfNotExist=true&amp;useSSL=false</value>

<name>javax.jdo.option.ConnectionDriverName</name>
<value>com.mysql.jdbc.Driver</value

b<name>javax.jdo.option.ConnectionUserName</name>
 <value>root</value>

## 192.168.1.121 mysql password: Hive.123456
 <name>javax.jdo.option.ConnectionPassword</name>
<value>Hive.123456</value>


<name>hive.exec.local.scratchdir</name><value>/root/Cloud/apache-hive-2.1.1-bin/tmp</value>
<name>hive.downloaded.resources.dir</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp/resources</value>

<name>hive.querylog.location</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp/querylog</value>

<name>hive.server2.logging.operation.log.location</name>
<value>/root/Cloud/apache-hive-2.1.1-bin/tmp/operation_logs</value>
<name>hive.metastore.uris</name>`<value>thrift://clusterMaster:9083</value>

## Hive Web Interface
<name>hive.hwi.listen.host</name>
<value>0.0.0.0</value>

<name>hive.hwi.listen.port</name>
<value>9999</value>'
```  
b)vim hive-env.sh  
```bash
export HADOOP_HOME=/root/Cloud/hadoop-2.6.0
export HIVE_CONF_DIR=/root/Cloud/apache-hive-1.2.0-bin/conf 
```  

c)配置 dfs  
```bash
h$HADOOP_HOME/bin/hadoop fs -mkdir /tmp
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w /tmp
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse # hive.metastore.warehouse.dir  
``` 

d)把 /hive/conf 下的 hive-site.xml cp 到 /spark/conf 下   

e)vim spark-env.sh   
```bash
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
```bash
export HIVE_HOME=/root/Cloud/apache-hive-1.2.0-bin
export PATH=$HIVE_HOME/bin:$PATH
export CLASS_PATH=$CALSSPATH:$HIVE_HOME/lib
```
2.主节点  
  主节点 clusterMaster  
```bash
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.122/root/Cloud/
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.124/root/Cloud/
scp –r /root/Cloud//root/Cloud/apache-hive-2.1.1-bin/ root@192.168.1.126/root/Cloud/
```
3.  

### 四．启动 hive  
```bash
## 在服务端（clusterMaster）启动 metastore 服务
hive --service metastore &
hive

## 在所有 slave 节点上运行 hive 命令加以验证
## Running Hive CLI
hive  
```
### 五．  

### 作者
本文档由尹仁强创建，由王若凡整理

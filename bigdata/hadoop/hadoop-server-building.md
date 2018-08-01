# Hadoop2.6.0 在 centos6.7 中的集群搭建
### 一．准备工作

1.一台主节点，两台从节点 

a)YTclusterMaster 192.168.1.204  

b)YTclusterSlaver1 192.168.1.205  

c)YTclusterSlaver2 192.168.1.206 

2.小知识点  

a)查看 centos 的版本号：cat /etc/redhat-release     uname – a  

b)防火墙的开关  
http://blog.csdn.net/jemlee2002/article/details/7042991/  
i.查询防火墙状态  
```bash
service iptables status   
```
ii.停止防火墙   
```bash
service iptables stop  
```
iii.启动防火墙  
```bash
service iptables start  
```
iv.重启防火墙  
```bash
service iptables restart  
``
v.永久关闭防火墙  
```bash
chkconfig iptables off  
```
vi.永久关闭后启用  
```bash
chkconfig iptables on  
```
vii.编辑 /etc/sysconfig/iptables  
实例中要打开需要的端口比如 8080  

c)查看版本号  
查看 CentOS 的版本：cat /etc/redhat-release  

d)查看端口号
```bash
netstat -nap #会列出所有正在使用的端口及关联的进程/应用
netstat -tunlp |grep 22 #查看某一端口是否被占用
```
e)安装 openssh-clients  

f)查看进程 pid  
```bash
ps -ef|grep namenode
```
g)上网问题  

h)解压文件  tar –xvf file.tar  tar –xzvf file.tar.gz  
*.tar 用 tar –xvf 解压  
*.gz 用 gzip -d 或者 gunzip 解压  
*.tar.gz 和 *.tgz 用 tar –xzf 解压  
*.bz2 用 bzip2 -d 或者用 bunzip2 解压  
*.tar.bz2 用 tar –xjf 解压  
*.Z 用 uncompress 解压  
*.tar.Z 用tar –xZf 解压  
*.rar 用 unrar e解压  
*.zip 用 unzip 解压   

i)主机名和 root@YTclusterMaster 的区别  

j)tail –n #查看文件的指定行数  

3.

### 二．centos 的安装（略）

### 三．centos 前期配置  

装好 centos 后，设置静态 IP，修改主机名和 ip 地址，增加 ip 与主机映射  

1.修改主机名（分别在三台 centos 修改为 YTclusterMaster，YTclusterSlaver1，YTclusterSlaver2）  
vim /etc/hostname  
修改主机名：vim /etc/sysconfig/network  
NETWORKING=yes  
HOSTNAME=YTclusterMaster  

2.修改 ip 地址并设置静态 ip   （分别修改）
```bash
vim /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
HWADDR=92:13:FA:57:7C:28
TYPE=Ethernet
UUID=d401b102-37e1-42b1-b66b-eec6f65349a0
ONBOOT=yes #打开网卡
NM_CONTROLLED=yes
BOOTPROTO=static #设置为静态
IPADDR=192.168.1.204 #设置ip
PREFIX=24
GATEWAY=192.168.1.1 #设置网关
DNS1=192.168.1.1 #设置dns
DEFROUTE=yes
IPV4_FAILURE_FATAL=yes
IPV6INIT=no
```  

3.增加 ip 与主机映射  
 vim /etc/hosts  
192.168.1.204 YTclusterMaster  
192.168.1.205 YTclusterSlaver1  
192.168.1.206 YTclusterSlaver2  

4.把 hosts scp 到各个从节点  

5.完成后重启虚拟机 reboot  

6.网络时间同步问题  
```bash
ntpdate time.nist.gov #同步网络时间
yum install ntp –y #安装ntp软件包
```
### 四．ssh 免密码登录   

1.在每台 centos 下的根目录 root 下，创建 ssh 公钥  
a) ssh-keygen -t rsa  #连续回车，系统自动生成图形公钥  
b) 在 YTclusterMaster 中，进入.ssh 目录，并将公钥写到 authorized_keys：  
```bash
cat id_rsa.pub >> authorized_keys
ssh YTclusterSlaver1 cat id_rsa.pub >> authorized_keys
```
c)更改 authorized_keys 属性，使之不能被修改
```bash
chmod 600 authorized_keys
```
d)在 master 的 .ssh 目录中，将生成的 known_hosts 和 authorized_keys 复制到各个从节点
```bash
scp authorized_keys root@YTclusterSlaver1:/root/.ssh
scp known_hosts root@YTclusterSlaver1:/root/.ssh
```
e)  

### 五．JDK 安装配置  

1．配置 jdk
a)vim ~/.bashrc  

b)export JAVA_HOME=/root/Cloud/jdk1.8.0_60  
  export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib  
  export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH  
  
2．使配置生效   source ~/.bashrc  

3．验证 java   java -version    

### 六．Hadoop2.6 的安装配置
http://mirror.bit.edu.cn/apache/hadoop/common/hadoop-2.6.0/  

1.配置 hadoop 的环境变量  

a)vim ~/.bashrc  

b)export HADOOP_HOME=/root/Cloud/hadoop-2.6.0  
export PATH=$HADOOP_HOME/bin:$PATH  

c)source ~/.bashrc  

d)echo $HADOOP_HOME  

e) 验证 [root@YTclusterMaster ~]# hadoop
Usage: hadoop [--config confdir] COMMAND  

2.Hadoop集群配置  

在 /root/Cloud/hadoop-2.6.0/etc/hadoop 中  

a)配置hadoop-env.sh  

export HADOOP_PREFIX=/root/Cloud/hadoop-2.6.0  
export HADOOP_COMMON_HOME=${HADOOP_PREFIX}  
export HADOOP_HDFS_HOME=${HADOOP_PREFIX}  
export PATH=$PATH:$HADOOP_PREFIX/bin  
export PATH=$PATH:$HADOOP_PREFIX/sbin  
export HADOOP_MAPRED_HOME=${HADOOP_PREFIX}  
export YARN_HOME=${HADOOP_PREFIX}  
export HADOOP_CONF_HOME=${HADOOP_PREFIX}/etc/hadoop  
export YARN_CONF_DIR=${HADOOP_PREFIX}/etc/hadoop  
export JAVA_HOME=/root/Cloud/jdk1.8.0_60  

b)配置 core-site.xml 文件  

修改 Hadoop 核心配置文件 core-site.xml，这里配置的是 HDFS 的地址和端口号
```bash
<configuration>
        <property>
                <name>io.native.lib.avaliable</name>
                <value>true</value>
        </property>

        <property>
                <name>fs.default.name</name>
                <value>hdfs://YTclusterMaster:9000</value>
                <final>true</final>
        </property>

        <property>
                <name>hadoop.tmp.dir</name>
                <value>/root/Cloud/workspace/tmp</value>
        </property>
</configuration>
```
c)配置 hdfs-site.xml 文件  
修改 Hadoop 中 HDFS 的配置，配置的备份方式默认为 3  
```bash
<configuration>
        <property>
                <name>dfs.namenode.secondary.http-address</name>
                <value>YTclusterMaster:9001</value>
        </property>
        <property>
                <name>dfs.namenode.name.dir</name>
                <value>file:/root/Cloud/hadoop-2.6.0/dfs/name</value>
        </property>
        <property>
                <name>dfs.datanode.data.dir</name>
                <value>file:/root/Cloud/hadoop-2.6.0/dfs1/data</value>
        </property>
        <property>
                <name>dfs.replication</name>
                <value>2</value>
        </property>
        <property>
                <name>dfs.webhdfs.enabled</name>
                <value>true</value>
        </property>
        <property>
                <name>dfs.datanode.max.transfer.threads</name>
                <value>8192</value>
        </property>
</configuration>
```
d)配置 mapred-site.xml 文件
 mapred-site.xml.template 这里只有这个文件，需要把它重命名为 mapred-site.xml  
```bash
<configuration>
        <property>
                <name>mapreduce.framework.name</name>
                <value>yarn</value>
        </property>
        <property>
                <name>mapreduce.job.tracker</name>
                <value>hdfs://YTclusterMaster:9001</value>
                <final>true</final>
        </property>
        <property>
                <name>mapreduce.map.memory.mb</name>
                <value>1536</value>
        </property>
        <property>
                <name>mapreduce.map.java.opts</name>
                <value>-Xmx1024M</value>
        </property>
        <property>
                <name>mapreduce.reduce.memory.mb</name>
                <value>3072</value>
        </property>
        <property>
                <name>mapreduce.reduce.java.opts</name>
                <value>-Xmx2560M</value>
        </property>
        <property>
                <name>mapreduce.task.io.sort.mb</name>
                <value>512</value>
        </property>
        <property>
                <name>mapreduce.task.io.sort.factor</name>
                <value>100</value>
        </property>
        <property>
                <name>mapreduce.reduce.shuffle.parallelcopies</name>
                <value>50</value>
        </property>
        <property>
                <name>mapred.system.dir</name>
                <value>file:/root/Cloud/workspace/mapred/system</value>
                <final>true</final>
        </property>
        <property>
                <name>mapred.local.dir</name>
                <value>file:/root/Cloud/workspace/mapred/local</value>
                <final>true</final>
        </property>
</configuration>
```
e)配置 yarn-site.xml 文件
```bash
<configuration>
<!-- Site specific YARN configuration properties -->
        <property>
                <name>yarn.resourcemanager.address</name>
                <value>clusterMaster:8081</value>
        </property>
        <property>
                <name>yarn.resourcemanager.scheduler.address</name>
                <value>clusterMaster:8082</value>
        </property>
        <property>
                <name>yarn.resourcemanager.resource-tracker.address</name>
                <value>clusterMaster:8083</value>
        </property>
<property>
                <name>yarn.resourcemanager.webapp.address</name>
                <value>YTclusterMaster:7088</value>
      </property>
        <property>
                <name>yarn.nodemanager.aux-services</name>
                <value>mapreduce_shuffle</value>
        </property>
        <property>
                <name>yarn.nodemanager.auxservices.mapreduce.shuffle.class</name>
                <value>org.apache.hadoop.mapred.ShuffleHandler</value>
       </property>
</configuration>
```
f)配置 masters 文件（可省略）  
加入master机器：YTclusterMaster  

g)配置 slaves 文件（ Master 主机特有）  
YTclusterSlaver1  

h)Hadoop 配置完成  

3.验证  

a)格式化 namenode
./bin/hdfs namenode -format  

b)启动 hdfs  

c)启动 yarn  

4.启动 ./start-all.sh  

5.查看集群状态  ./hadoop dfsadmin -report  

### 七．遇到的问题  

1.yarn 中 resourcemanager 启动不了问题的解决  

查看日志  /root/Cloud/hadoop-2.6.0/logs      
tail -n 50 yarn-root-resourcemanager-YTclusterMaster.log  
解决办法  
ps aux|grep -i resourcemanager  查看主机master中的resourcemanager的进程个数  
用kill – 9 杀死相关进程  
sbin目录下重启yarn即可复现进行./stop-yarn.sh   ./start-yarn.sh  在主节点master上面即可出现resourcemanager进程  

2.Unable to load native-hadoop library  

a)系统中的 glibc 的版本和 libhadoop.so 需要的版本不一致导致的  

b)加载的 so 文件系统版本不对，32 的系统版本，而 hadoop 环境是 64 位 OS  

c) 解决办法：wget -c http://dl.bintray.com/sequenceiq/sequenceiq-bin/hadoop-native-64-2.6.0.tar  
解压到 /root/Cloud/hadoop-2.6.0/lib/native 中  

3.查看集群状态：./hdfs dfsadmin –report  

4.http://blog.sina.com.cn/s/blog_ad795db30102w4a8.html  

5.Hadoop上传文件的时候出现错误  

a)原因：Configured Capacity 也就是 datanode 没用分配容量   ./hadoop dfsadmin –report  

b)解决方法  

i.查看文件系统  df –hl  
ii.修改core-site.xml中的hadoop.tmp.dir的值  
iii.停止hadoop服务，重新格式化namenode  
iv.重启服务  

6.NodeManager did not stop gracefully after 5 seconds: kil  

a)hadoop-daemon.sh，yarn-daemon.sh 出问题
b)修改其脚本：yarn-daemon.sh 类似

![png1](https://github.com/wangruofanWRF/notes/blob/master/hadoop/hadoop/png/png1.png)  

7.  

### 八．启动集群  
sbin/start-all.sh  
./sbin/mr-jobhistory-daemon.sh start historyserver 需要手动启动，否则看不到 JobHistoryServer 进程  

1.HDFS 界面 http://192.168.1.204:50070/  
2.YARN 界面 http://192.168.1.204:9001/  
3.JobTrack 界面 http://192.168.1.204:7088/   

### 九．停止集群 
先停止 yarn：  
sbin/stop-yarn.sh  
再停止 hdfs：  
sbin/stop-dfs.sh  
在运行 JobHistoryServer的slave1上执行：  
停止 JobHistoryServer：  
sbin/mr-jobhistory-daemon.sh stop historyserver   

```bash
hadoop fs -mkdir /in/wordcount
hadoop fs -mkdir /out/
cat in1.txt
hadoop fs -put in1.txt /in/wordcount
hadoop jar hadoop-mapreduce-examples-2.4.0.jar wordcount /in/wordcount /out/out1
hadoop fs -cat /out/out4/part-r-00000
hadoop jar hadoop-mapreduce-examples-2.6.0.jar wordcount /in/wordcount /out/out6
[root@YTclusterMaster mapreduce]# hadoop fs -cat /out/out6/part-r-00000
```
### 作者
本文档由尹仁强创建，由王若凡整理

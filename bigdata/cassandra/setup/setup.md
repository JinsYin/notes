# Cassandra 集群搭建

## 准备工作

* JDK - Cassandra 3 要求 JDK 1.8
* Python - Cassandra 3 要求 Python 2.7

### 安装 JDK

```bash
# Ubuntu 14.04
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo apt-cache madison oracle-java*
sudo apt-get install -y oracle-java8-installer=8u111+8u111arm-1~webupd8~0
java -version
```

### 安装 Python

```bash
$ python --version
```

## Ubuntu

```bash
echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -

sudo apt-get update

sudo apt-get install cassandra
```

---

1. 安装JDK
jdk version: java8u111 (cassandra3.9要求java8)

# ubuntu 14.04安装oracle-java8 (非openjdk8)
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo apt-cache madison oracle-java*
sudo apt-get install oracle-java8-installer=8u111+8u111arm-1~webupd8~0 –y
java -version

2. Python版本
cassandra3要求python2.7

python --version

3. 安装Cassandra(single-node)
version: 3.9

## ubuntu 14.04
echo "deb http://www.apache.org/dist/cassandra/debian 39x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
sudo apt-get update
sudo apt-cache madison cassandra*
sudo apt-get install cassandra=3.9
cassandra –v
service cassandra start

## centos 7
## vim /etc/yum.repos.d/datastax.repo:
[datastax-ddc] 
name = DataStax Repo for Apache Cassandra
baseurl = http://rpm.datastax.com/datastax-ddc/3.9
enabled = 1
gpgcheck = 0

## centos 7
sudo yum update
sudo yum install datastax-ddc
sudo service cassandra start
nodetool status
4. Cassandra集群
（在所有节点执行以下操作）

## deteling default data
sudo service cassandra stop
sudo rm -rf /var/lib/cassandra/data/system/*

## configuring the cluster
## sudo vim /etc/cassandra/cassandra.yaml:
...
cluster_name: 'CassandraCluster'
...
listen_address: your_server_ip
...
seeds: "your_server_ip,your_server_ip_2,...your_server_ip_n"
...
endpoint_snitch: GossipingPropertyFileSnitch

##　/etc/cassandra/cassandra.yaml
auto_bootstrap: false

sudo service cassandra start
sudo nodetool status
cqlsh your_server_ip 9042

5. 其他操作




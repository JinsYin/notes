# Cassandra 主机集群

## 安装 JDK  

Cassandra 要求 Java 环境。下面安装 oracle-java-8（非 openjdk-8）：

```bash
# ubuntu 14.04
$ sudo add-apt-repository ppa:webupd8team/java -y
$ sudo apt-get update
$ sudo apt-cache madison oracle-java*
$ sudo apt-get install oracle-java8-installer=8u111+8u111arm-1~webupd8~0 –y
$ java -version
```

## Python 版本

Cassandra 3 要求 python 2.7

```bash
$ python --version
```

## 安装 Cassandra（single-node）

* Ubuntu 14.04

```bash
# ubuntu 14.04
$ echo "deb http://www.apache.org/dist/cassandra/debian 39x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
$ sudo apt-get update
$ sudo apt-cache policy cassandra*
$ sudo apt-get install cassandra=3.9
$ cassandra -v
$ service cassandra start
```

* Centos 7

```bash
$ cat /etc/yum.repos.d/datastax.repo
[datastax-ddc]
name = DataStax Repo for Apache Cassandra
baseurl = http://rpm.datastax.com/datastax-ddc/3.9
enabled = 1
gpgcheck = 0
```

```bash
$ sudo yum install datastax-ddc
$ sudo service cassandra start
$ nodetool status
```

## Cassandra 集群

（在所有节点执行以下操作）

```bash
# 删除默认数据
$ sudo service cassandra stop
$ sudo rm -rf /var/lib/cassandra/data/system/*
```

```
$ cat /etc/cassandra/cassandra.yaml
...
cluster_name: 'CassandraCluster'
...
listen_address: <your_server_ip>
...
seeds: "<your_server_ip>,<your_server_ip_2>,...<your_server_ip_n>"
...
endpoint_snitch: GossipingPropertyFileSnitch
...
auto_bootstrap: false
```

```bash
$ sudo service cassandra start
$ sudo nodetool status
$ cqlsh <your_server_ip> 9042
```

### 其他

对于读写大量本地文件的需求，可能需要修改 Linux 的最大线程数（nproc）或者最大文件打开数（nofile，默认：1024）。

* Linux 中临时修改

```bash
# 软:硬
$ ulimit -n 40960:40960 # nofile
$ ulimit -u 65535:65535 # nproc
$ ulimit -a
```

* Linux 中永久修改

```bash
```

* dockerd 中修改

```bash
$ dockerd --default-ulimit nofile=40960:40960 nproc=65535:65535
```

* docker 容器中修改

```bash
$ docker run -it --rm --ulimit nofile=40960:40960 --ulimit nproc=65535:65535 -d cassandra:3.9
```

> [Java reports an error saying there are too many open files](https://docs.datastax.com/en/landing_page/doc/landing_page/troubleshooting/cassandra/tooManyFiles.html)

## 贡献

本文档由 `尹仁强` 创建，由 `王若凡` 参与整理。
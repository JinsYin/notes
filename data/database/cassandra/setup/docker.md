# Cassandra 容器集群

## 方案一

使用 docker dridge 网桥

优点：方便，不占路由 IP
缺点：速度慢，且会出现访问权限问题

### 单机伪分布式

```sh
$ docker run -it --name cassandraOne --ip 172.17.0.2 --ulimit nofile=102400:102400 \
 -v /data/cassandra/cassandraOne:/var/lib/cassandra \
 -e CASSANDRA_CLUSTER_NAME=CassandraCluster \
 -e CASSANDRA_DC=dc1 \
 -e CASSANDRA_RACK=rack1 \
 -e CASSANDRA_BROADCAST_ADDRESS=192.168.1.17 \
 -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch \
 -p 7000:7000 \
 -p 7001:7001 \
 -p 7199:7199 \
 -p 9042:9042 \
 -d cassandra:3.9
```

```sh
$ docker run -it --name cassandraTwo --ip 172.17.0.3 --ulimit nofile=102400:102400 --link cassandraOne:cassandra \
 -v /data/cassandra/cassandraTwo:/var/lib/cassandra \
 -e CASSANDRA_CLUSTER_NAME=CassandraCluster \
 -e CASSANDRA_DC=dc1 \
 -e CASSANDRA_RACK=rack1 \
 -e CASSANDRA_BROADCAST_ADDRESS=192.168.1.17 \
 -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch \
 -p 7000:7000 \
 -p 7001:7001 \
 -p 7199:7199 \
 -p 9042:9042 \
 -d cassandra:3.9
```

---

* 部署

docker network create --driver=bridge --subnet=172.172.0.0/16 --gateway=172.172.0.1 cassandra-net

```sh
$ docker run -it --name cassandra-node-1 --net cassandra-net \
 --ip 172.172.0.2 --ulimit nofile=102400:102400 \
 -v cassandra-data-1:/var/lib/cassandra \
 -e CASSANDRA_CLUSTER_NAME=CassandraCluster \
 -e CASSANDRA_DC=dc1 \
 -e CASSANDRA_RACK=rack1 \
 -e CASSANDRA_BROADCAST_ADDRESS=172.172.0.2 \
 -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch \
 -p 7000:7000 \
 -p 7001:7001 \
 -p 7199:7199 \
 -p 9042:9042 \
 -d cassandra:3.9
```

```sh
$ docker run -it --name cassandra-node-2 --net cassandra-net \
 --ip 172.172.0.3 --ulimit nofile=102400:102400 --link cassandra-node-1:cassandra \
 -v cassandra-data-2:/var/lib/cassandra \
 -e CASSANDRA_CLUSTER_NAME=CassandraCluster \
 -e CASSANDRA_DC=dc1 \
 -e CASSANDRA_RACK=rack1 \
 -e CASSANDRA_BROADCAST_ADDRESS=172.172.0.3 \
 -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch \
 -d cassandra:3.9
```

以上，让 cassandraOne 容器的端口对外（7000,7001,7199,9042），让 cassandraTwo 可以 link 到 cassandraOne。
--link 的作用是服务发现，即帮助 cassandraTwo 发现 cassandraOne，可以在 cassandraTwo 中使用 `cat /etc/hosts` 验证一下。

* 集群状态

```sh
$ docker exec -it cassandra-node-1 nodetool status
```

* 客户端连接

```sh
$ docker run -it --rm --net cassandra-net cassandra:3.9 cqlsh 172.172.0.2 9042
```

* 遇到的问题

在某个节点（192.168.1.220）使用 192.168.1.17:9042 往集群中导数据时，会出现 `Failed to create connection pool` 的错误（即使是在主机 17 上同样也会报错），也就是外部无法访问 cassandraTwo，只能访问 cassandraOne。Github 上给出的答案是，我们不能在开发环境去访问生产环境的 docker bridge 集群。

解决办法：将程序部署到和 cassandraOne，cassandraTwo 同样的网段，即 172.17.0.0/16。如果你需要测试远程集群，你可以在部署一个节点。

## 方案二

使用路由方式

缺点：占用路由 IP
优点：速度快

* 介绍

假设宿主机 IP 为：192.168.1.17

以下方法为每个 docker 容器设置一个 192.168.1.0/24 网段的独立 IP 地址，而不是 172.17.0.1/16 的子网  
默认情况也会为其分配一个子网 IP，只是相当于为其设置了一个对外IP。（Google: "docker container set public ip address"）

* 申请 IP 地址

（需要在王遒慧那里申请空余的 IP，不过可以不设置设置 mac 地址）

```scala
$ ip addr add 192.168.1.221/32 dev eth0 # eth0 为宿主机网卡
```

* 集群部署

在 docker 上创建 cassandraOne，IP 地址为宿主机 IP

```scala
$ docker run -it --name cassandraOne --ulimit nofile=1024000:1024000 \
 -v /data/cassandra/cassandraOne:/var/lib/cassandra \
 -e CASSANDRA_DC=dc1 \
 -e CASSANDRA_RACK=rack1 \
 -e CASSANDRA_BROADCAST_ADDRESS=192.168.1.17
 -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch \
 -p 192.168.1.17:7000:7000 \
 -p 192.168.1.17:7001:7001 \
 -p 192.168.1.17:7199:7199 \
 -p 192.168.1.17:9042:9042 \
 -d cassandra:3.9
```

在 docker 上创建 cassandraTwo , IP 地址为刚刚申请的，需要设置 CASSANDRA_SEEDS 为宿主机 IP

```scala
$ docker run -it --name cassandraTwo --ulimit nofile=1024000:1024000 \
 -v /data/cassandra/cassandraTwo:/var/lib/cassandra \
 -e CASSANDRA_DC=dc1 \
 -e CASSANDRA_RACK=rack1 \
 -e CASSANDRA_BROADCAST_ADDRESS=192.168.1.221 \
 -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch \
 -e CASSANDRA_SEEDS=192.168.1.17 \
 -p 192.168.1.221:7000:7000 \
 -p 192.168.1.221:7001:7001 \
 -p 192.168.1.221:7199:7199 \
 -p 192.168.1.221:9042:9042 \
 -d cassandra:3.9
```

> https://yq.aliyun.com/articles/61950

## 方案三

使用 docker swarm overlay 网络

缺点：目前大公司都还没有在生产环境试验过
优点：方便，简单

## docker swarm 集群

* manager

```sh
$ docker swarm init
$ docker swarm join-token worker
$ docker swarm join-token manager
```

* worker

```sh
$ docker swarm join \
--token SWMTKN-1-36k9vo3odmvn3xzp6u3s39s8w0ww1ajcu1npahg37uy01gnqkx-32bxwaf80xwykwe5xtnihqez6 \
192.168.1.17:2377
```

### 部署

```sh
// manager 节点
$ docker service create --name cassandra --replicas 2 --publish 7000:7000 --publish 7001:7001 --publish 7199:7199 --publish 9042:9042 cassandra:3.9
```

## 方案四（推荐）

使用 calico 网络来取代其他容器网络，具体情况参考 docker 网络。

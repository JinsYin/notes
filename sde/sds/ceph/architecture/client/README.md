# Ceph 客户端

## 客户端访问集群需要哪些数据

* Ceph 配置文件（或者集群名和 Monitor 地址）
* Pool 名
* 用户名和 Secret Key 路径

## 客户端如何访问集群

1. 客户端访问 Monitor 以获取最新的 ClusterMap
2. 客户端提供对象名和 Pool 名，Ceph 根据 ClusterMap 和 CRUSH 算法计算出对象 PG 和 Primary OSD
3. 客户端连接 Primary OSD 执行读写操作
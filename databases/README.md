# 数据库

## 分类

* 缓存数据库
  * Redis
  * Memcache
* 键值数据库
  * etcd
  * zookeeper
* 关系数据库
  * MySQL
  * Oracle
  * SQL Server
* 文档数据库
  * MongoDB
  * CouchDB
* 列式数据库
  * Cassanda
  * HBase
* 图数据库

数据在存储中的基本单位为 `页`，这也是进行数据读取时候基本单位，一次读取就是一次 IO 操作

以sql server为例，一个数据页大小为8K，数据页中存储的是数据，数据是连续存储的

## 参考

* [DB-Engines Ranking](https://db-engines.com/en/ranking)

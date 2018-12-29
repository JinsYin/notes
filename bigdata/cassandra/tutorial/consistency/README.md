# 一致性

## 一致性级别（Consistency Level）

| Level  | 满足客户端请求的最少副本数 | 描述                       |
| ------ | -------------------------- | -------------------------- |
| ONE    | 1                          | 从最近的副本返回数据       |
| QUORUM | i                          | 从大多数副本中返回最新数据 |
| ALL    | n                          | 从所有副本中返回最新数据   |

对 Cassandra 默认用户（`cassandra`）而言，Cassandra 默认使用 `QUORUM`；对其他用户而言，Cassandra 使用 **ONE**。

## 追踪一致性变化

* 安装 ccm
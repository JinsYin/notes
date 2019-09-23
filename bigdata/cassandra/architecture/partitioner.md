# 分区器（Partitioner）

`分区器` 利用哈希算法计算每行数据的分区键（`Partition key`）得到相应的 token，而每个节点维护着一定的 token 范围，因此可以确定数据的第一份 replica 分布到集群中的哪个节点。

## 分区器类型

* Murmur3Partitioner（默认） - 基于 `NurmurHash` 算法的哈希值在集群中均匀分布数据。
* RandomPartitioner - 基于 `MD5` 算法的哈希值在集群中随机分布数据。
* ByteOrderedPartitioner - 通过关键字节（key bytes）以词汇方式保持有序的数据分布

## Key 类型

* `Partition Key` - 分区键；决定数据放置到哪个节点上
* `Clustering Key` - 集群键；用于在各个分区内的排序，决定了数据在分区上的位置
* `Primary Key` - 主键；决定数据行的唯一性

示例：

```sql
CREATE TABLE mytable {
    key_one text,
    key_two int,
    data text,
    PRIMARY KEY(key_one, key_two)
}
```

说明：

1. `key_one` 和 `key_two` 共同构成了 primary key
2. `key_one` 就是 partition key
3. `key_two` 就是 cluster key

## 参考

* [Cassandra 中分区键,复合键和集群键之间的区别？](https://codeday.me/bug/20170309/5182.html)

# Placement Group（PG）

增加 PG 的数量会改变 PG 到 OSD 的映射关系，但 PG 中的数据不会发生迁移。只有当增加 PGP 的数量时，数据才会真正发生迁移。

数据对象写入集群时，需要两次映射：Object --> PG，PG --> OSD set。每次映射都与其他对象无关。

## Object 与 PG

## PG 与 OSD

查询 PG 映射 OSD 的集合，即 PG 具体分配到 OSD 的归属：

```bash
$ POOL_ID=2

# 从左到右：PG 编号、PG 所映射到的 OSD 集合
$ ceph pg dump | grep "^${POOL_ID}\." | awk '{print $1 "\t" $17}'
dumped all
2.5 [0]
2.4 [0]
2.7 [0]
2.6 [0]
2.1 [0]
2.0 [0]
2.3 [0]
2.2 [0]
```

## PG 与 Pool
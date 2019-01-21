# Cluster Map

Cluster Map 包括：

| 类型        | 查看命令            | 描述                                                                    |
| ----------- | ------------------- | ----------------------------------------------------------------------- |
| Monitor Map | ceph mon dump       | 包含 `集群 fsid`、`monmap epoch`、`Monitor 位置`、`Monitor 地址和端口`  |
| OSD Map     | ceph osd dump       | 包含 `集群 fsid`、`Pool 列表`、`副本大小`、`PG 数量`、`OSD 列表及状态`  |
| PG Map      | ceph pg dump        | 包含 `PG 版本`、`时间戳`、`osdmap epoch`、`PG 详情`                     |
| CRUSH Map   | ceph osd crush dump | 包含 `存储设备列表`、`故障域层次结构`、`存储数据时所遍历层次结构的规则` |
| MDS Map     | ceph fs dump        | 包含 `mdsmap epoch`、`存储 Metadata 的 Pool`、`MDS 列表及状态`          |

## 参考

* <http://docs.ceph.com/docs/master/architecture/#cluster-map>
# ceph fs new

创建一个 Ceph 文件系统。

## 用法

创建 Ceph 文件系统之前，必须先创建两个存储池，一个用于存放元数据（metadata），一个用于存储数据（data）。集群默认创建了一个名为 `cephfs` 的文件系统，使用的是 `cephfs_data` 和 `ceph_metadata` 两个存储池。

```sh
# 必须事先创建两个存储池
$ ceph fs new <fs_name> <metadata_pool> <data_pool>
```

## 示例

```sh
# 创建所需的存储池
$ ceph osd pool create cfs_metadata 8 8 # 存放的数据通常只有几兆到几十兆（同时建议放到 SSD）
$ ceph osd pool create cfs_data 512 512

# 创建文件系统
$ ceph fs new cfs cfs_metadata cfs_data # ceph fs flag set enable_multiple true
```

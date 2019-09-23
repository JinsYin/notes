# Ceph Pool

## 查询 Pool

```sh
$ ceph osd pool ls
rbd
cephfs_data
cephfs_metadata
.rgw.root
default.rgw.control
default.rgw.meta
default.rgw.log
```

```sh
$ rados lspools
rbd
cephfs_data
cephfs_metadata
.rgw.root
default.rgw.control
default.rgw.meta
default.rgw.log
```

```sh
# 包含 Pool ID
$ ceph osd lspools
0 rbd,1 cephfs_data,2 cephfs_metadata,3 .rgw.root,4 default.rgw.control,5 default.rgw.meta,6 default.rgw.log,
```

## 创建 Pool

```txt
ceph osd pool create {pool-name} {pg-num} [{pgp-num}] [replicated] \
     [crush-ruleset-name] [expected-num-objects]
ceph osd pool create {pool-name} {pg-num}  {pgp-num}   erasure \
     [erasure-code-profile] [crush-ruleset-name] [expected_num_objects]
```

```sh
# osd pool create <poolname> <int[0-]> {<int[0-]>} {replicated|erasure} {<erasure_code_profile>} {<ruleset>} {<int>}
```

## 删除 Pool

```sh
$ ceph -n mon.0 --show-config | grep mon_allow_pool_delete
mon_allow_pool_delete = false

# 需要重启才能更新
$ ceph tell mon.* injectargs '--mon-allow-pool-delete=true'
injectargs:mon_allow_pool_delete = 'true' (not observed, change may require restart)
```

## Pool 统计

```sh
$ rados df
POOL_NAME           USED OBJECTS CLONES COPIES MISSING_ON_PRIMARY UNFOUND DEGRAED RD_OPS RD    WR_OPS WR
.rgw.root           2062       6      0      6                  0       0       0     36 24576      6 6144
cephfs_data            0       0      0      0                  0       0       0      0     0      0    0
cephfs_metadata     2246      21      0     21                  0       0       0      0     0     42 8192
default.rgw.control    0       8      0      8                  0       0       0      0     0      0    0
default.rgw.log        0     191      0    191                  0       0       0 108304  105M  72160    0
default.rgw.meta     235       2      0      2                  0       0       0      0     0      3 2048
rbd                    0       0      0      0                  0       0       0      0     0      0    0

total_objects    228
total_used       82221M
total_avail      30323M
total_space      109G
```

```sh
# 指定 Pool
$ rados df -p cephfs_metadata
```

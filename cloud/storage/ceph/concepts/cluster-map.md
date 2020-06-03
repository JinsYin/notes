# Cluster Map

<!--
The cluster map is a composite of maps, including the monitor map, the OSD map, the placement group map and the metadata server map.
-->

Ceph Minitor 负责维护集群的各类 Map 。Cluster Map 包含 `Minitor Map`、`OSD Map`、`PG Map`、`MDS Map`。

## Monitor Map

```sh
$ ceph mon dump
dumped monmap epoch 2
epoch 2 # Monitor 版本
fsid fc8092bc-82f5-4f58-8f4f-aac5b66eac66 # 集群 ID
last_changed 2018-07-10 08:17:09.608820 # 最近更新时间
created 2018-07-10 08:17:09.441251 # 创建时间
0: 192.168.8.220:6789/0 mon.Yin # Monitor 主机名、IP 地址和端口
```

## OSD Map

```sh
$ ceph osd dump
epoch 14 # OSD 版本
fsid fc8092bc-82f5-4f58-8f4f-aac5b66eac66 # 集群 ID
created 2018-07-10 08:17:09.611900  # 创建时间
modified 2018-07-10 08:17:22.265705 # 最近更新时间
flags sortbitwise,require_jewel_osds,require_kraken_osds,require_luminous_osds
full_ratio 0.95
backfillfull_ratio 0.9
nearfull_ratio 0.85
require_min_compat_client hammer
min_compat_client hammer 0.94 # 客户端最低版本
pool 0 'rbd' replicated size 1 min_size 1 crush_ruleset 0 object_hash rjenkins pg_num 64 pgp_num 64 last_change 2 flags hashpspool stripe_width 0 # Pool ID、Pool 名称、副本策略、副本数量、PG 数量、PGP 数量
pool 1 'cephfs_data' replicated size 1 min_size 1 crush_ruleset 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 5 flags hashpspool stripe_width 0
pool 2 'cephfs_metadata' replicated size 1 min_size 1 crush_ruleset 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 6 flags hashpspool stripe_width 0
pool 3 '.rgw.root' replicated size 1 min_size 1 crush_ruleset 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 7 owner 18446744073709551615 flags hashpspool stripe_width 0
pool 4 'default.rgw.control' replicated size 1 min_size 1 crush_ruleset 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 9 flags hashpspool stripe_width 0
pool 5 'default.rgw.meta' replicated size 1 min_size 1 crush_ruleset 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 11 owner 18446744073709551615 flags hashpspool stripe_width 0
pool 6 'default.rgw.log' replicated size 1 min_size 1 crush_ruleset 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 12 owner 18446744073709551615 flags hashpspool stripe_width 0
max_osd 1
osd.0 up   in  weight 1 up_from 6 up_thru 12 down_at 0 last_clean_interval [0,0) 192.168.8.220:6800/218 192.168.8.220:6801/218 192.168.8.220:6802/218 192.168.8.220:6803/218 exists,up dce0dd37-7579-4d2e-9bc3-6e864e4df0b4 # OSD ID、OSD 状态、权重、最新 clean 间隔、OSD 主机信息
```

## PG Map

```sh
$ ceph pg dump
Error EACCES: access denied

$ ceph auth get client.admin
exported keyring for client.admin
[client.admin]
    key = AQCFa0RbxhM8FxAAFQhxTfSLvdactjEdtCxt8g==
    auid = 0
    caps mds = "allow *"
    caps mon = "allow *"
    caps osd = "allow *"
```

```sh
# 缺少一个 mgr 'allow *'
$ ceph auth caps client.admin osd 'allow *' mds 'allow *' mon 'allow *' mgr 'allow *'

$ ceph pg dump
dumped all
version 13338  # PG 版本
stamp 0.000000
last_osdmap_epoch 0
last_pg_scan 14
full_ratio 0     # 空间使用比例
nearfull_ratio 0 # 接近占满比例
PG_STAT OBJECTS MISSING_ON_PRIMARY DEGRADED MISPLACED UNFOUND BYTES LOG  DISK_LOG STATE        STATE_STAMP                VERSION REPORTED UP  UP_PRIMARY ACTING ACTING_PRIMARY LAST_SCRUB SCRUB_STAMP                LAST_DEEP_SCRUB DEEP_SCRUB_STAMP
0.2d          0                  0        0         0       0     0    0        0 active+clean 2018-07-10 08:17:15.242624     0'0    13:17 [0]          0    [0]              0        0'0 2018-07-10 08:17:09.611912             0'0 2018-07-10 08:17:09.611912
0.2c          0                  0        0         0       0     0    0        0 active+clean 2018-07-10 08:17:15.242445     0'0    13:17 [0]          0    [0]              0        0'0 2018-07-10 08:17:09.611912             0'0 2018-07-10 08:17:09.611912
0.2b          0                  0        0         0       0     0    0        0 active+clean 2018-07-10 08:17:15.242718     0'0    13:17 [0]          0    [0]              0        0'0 2018-07-10 08:17:09.611912             0'0 2018-07-10 08:17:09.611912

6 191 0 0 0 0    0 24028 24028
5   2 0 0 0 0  235     2     2
4   8 0 0 0 0    0    40    40
3   6 0 0 0 0 2062     8     8
2  21 0 0 0 0 2246    37    37
1   0 0 0 0 0    0     0     0
0   0 0 0 0 0    0     0     0

sum 228 0 0 0 0 4543 24115 24115
OSD_STAT USED   AVAIL  TOTAL HB_PEERS PG_SUM PRIMARY_PG_SUM
0        81843M 30701M  109G       []    112            112
sum      81843M 30701M  109G
```

## MDS Map

```sh
$ ceph mds dump
dumped fsmap epoch 5
fs_name cephfs
epoch   5
flags   8
created 2018-07-10 08:17:14.430971
modified    2018-07-10 08:17:14.430971
tableserver 0
root    0
session_timeout 60
session_autoclose   300
max_file_size   1099511627776
last_failure    0
last_failure_osd_epoch  0
compat  compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object,5=mds uses versioned encoding,6=dirfrag is stored in omap,8=file layout v2}
max_mds 1
in  0
up  {0=4106} # MDS 状态
failed
damaged
stopped
data_pools  1       # 数据 Pool ID
metadata_pool   2   # 元数据 Pool ID
inline_data disabled
balancer
standby_count_wanted    0
4106:   192.168.8.220:6804/3351369903 '0' mds.0.4 up:active seq 3
```

## CRUSH Map

```sh
$ ceph osd crush dump
{
    # 存储设备信息
    "devices": [
        {
            "id": 0,
            "name": "osd.0"
        }
    ],
    # 故障域层次结构
    "types": [
        {
            "type_id": 0,
            "name": "osd"
        },
        {
            "type_id": 1,
            "name": "host"
        },
        {
            "type_id": 2,
            "name": "chassis"
        },
        {
            "type_id": 3,
            "name": "rack"
        },
        {
            "type_id": 4,
            "name": "row"
        },
        {
            "type_id": 5,
            "name": "pdu"
        },
        {
            "type_id": 6,
            "name": "pod"
        },
        {
            "type_id": 7,
            "name": "room"
        },
        {
            "type_id": 8,
            "name": "datacenter"
        },
        {
            "type_id": 9,
            "name": "region"
        },
        {
            "type_id": 10,
            "name": "root"
        }
    ],
    "buckets": [
        {
            "id": -1,
            "name": "default",
            "type_id": 10,
            "type_name": "root",
            "weight": 65536,
            "alg": "straw2",
            "hash": "rjenkins1",
            "items": [
                {
                    "id": -2,
                    "weight": 0,
                    "pos": 0
                },
                {
                    "id": -3,
                    "weight": 65536,
                    "pos": 1
                }
            ]
        },
        {
            "id": -2,
            "name": "localhost",
            "type_id": 1,
            "type_name": "host",
            "weight": 0,
            "alg": "straw2",
            "hash": "rjenkins1",
            "items": []
        },
        {
            "id": -3,
            "name": "Yin",
            "type_id": 1,
            "type_name": "host",
            "weight": 65536,
            "alg": "straw2",
            "hash": "rjenkins1",
            "items": [
                {
                    "id": 0,
                    "weight": 65536,
                    "pos": 0
                }
            ]
        }
    ],
    "rules": [
        {
            "rule_id": 0,
            "rule_name": "replicated_ruleset",
            "ruleset": 0,
            "type": 1,
            "min_size": 1,
            "max_size": 10,
            "steps": [
                {
                    "op": "take",
                    "item": -1,
                    "item_name": "default"
                },
                {
                    "op": "choose_firstn",
                    "num": 0,
                    "type": "osd"
                },
                {
                    "op": "emit"
                }
            ]
        }
    ],
    "tunables": {
        "choose_local_tries": 0,
        "choose_local_fallback_tries": 0,
        "choose_total_tries": 50,
        "chooseleaf_descend_once": 1,
        "chooseleaf_vary_r": 1,
        "chooseleaf_stable": 0,
        "straw_calc_version": 1,
        "allowed_bucket_algs": 54,
        "profile": "hammer",
        "optimal_tunables": 0,
        "legacy_tunables": 0,
        "minimum_required_version": "hammer",
        "require_feature_tunables": 1,
        "require_feature_tunables2": 1,
        "has_v2_rules": 0,
        "require_feature_tunables3": 1,
        "has_v3_rules": 0,
        "has_v4_buckets": 1,
        "require_feature_tunables5": 0,
        "has_v5_rules": 0
    },
    "choose_args": {}
}
```

## 注

We call each version an “epoch.”

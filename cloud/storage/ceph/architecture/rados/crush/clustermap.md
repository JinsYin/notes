# Cluster Map

Cluster Map 包括：

| 类型        | 查看命令            | 描述                                                                    |
| ----------- | ------------------- | ----------------------------------------------------------------------- |
| Monitor Map | ceph mon dump       | 包含 `集群 fsid`、`monmap epoch`、`每个 Monitor 的位置、名称地址和端口` |
| OSD Map     | ceph osd dump       | 包含 `集群 fsid`、`Pool 列表`、`副本大小`、`PG 数量`、`OSD 列表及状态`  |
| PG Map      | ceph pg dump        | 包含 `PG 版本`、`时间戳`、`osdmap epoch`、`PG 详情`                     |
| CRUSH Map   | ceph osd crush dump | 包含 `存储设备列表`、`故障域层次结构`、`存储数据时所遍历层次结构的规则` |
| MDS Map     | ceph fs dump        | 包含 `mdsmap epoch`、`存储 Metadata 的 Pool`、`MDS 列表及状态`          |

## Monitor Map 示例

```bash
$ ceph mon dump

dumped monmap epoch 1
epoch 1
fsid fa0f3ae2-291d-487f-b12b-5544aebf6ccd
last_changed 2019-04-17 09:32:20.235616
created 2019-04-17 09:32:20.235616
0: 192.168.16.2:6789/0 mon.Yin
```

## OSD Map 示例

```bash
$ ceph osd dump

epoch 17
fsid fa0f3ae2-291d-487f-b12b-5544aebf6ccd
created 2019-04-17 09:32:20.356069
modified 2019-04-17 09:32:37.942704
flags sortbitwise,recovery_deletes,purged_snapdirs
crush_version 2
full_ratio 0.95
backfillfull_ratio 0.9
nearfull_ratio 0.85
require_min_compat_client jewel
min_compat_client jewel
require_osd_release mimic
pool 1 'rbd' replicated size 1 min_size 1 crush_rule 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 4 flags hashpspool stripe_width 0
pool 2 'cephfs_data' replicated size 1 min_size 1 crush_rule 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 7 flags hashpspool stripe_width 0 application cephfs
pool 3 'cephfs_metadata' replicated size 1 min_size 1 crush_rule 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 7 flags hashpspool stripe_width 0 application cephfs
pool 4 '.rgw.root' replicated size 1 min_size 1 crush_rule 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 9 owner 18446744073709551615 flags hashpspool stripe_width 0 application rgw
pool 5 'default.rgw.control' replicated size 1 min_size 1 crush_rule 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 12 flags hashpspool stripe_width 0 application rgw
pool 6 'default.rgw.meta' replicated size 1 min_size 1 crush_rule 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 14 owner 18446744073709551615 flags hashpspool stripe_width 0 application rgw
pool 7 'default.rgw.log' replicated size 1 min_size 1 crush_rule 0 object_hash rjenkins pg_num 8 pgp_num 8 last_change 16 flags hashpspool stripe_width 0 application rgw
max_osd 1
osd.0 up   in  weight 1 up_from 4 up_thru 15 down_at 0 last_clean_interval [0,0) 192.168.16.2:6801/385 192.168.16.2:6802/385 192.168.16.2:6803/385 192.168.16.2:6804/385 exists,up b34b4a7c-87a6-4481-9dc2-c5def85b22f4
```

## PG Map 示例

```bash
$ ceph pg dump

dumped all
version 36831
stamp 2019-04-18 06:00:00.036279
last_osdmap_epoch 0
last_pg_scan 0
PG_STAT OBJECTS MISSING_ON_PRIMARY DEGRADED MISPLACED UNFOUND BYTES LOG  DISK_LOG STATE        STATE_STAMP                VERSION REPORTED UP  UP_PRIMARY ACTING ACTING_PRIMARY LAST_SCRUB SCRUB_STAMP                LAST_DEEP_SCRUB DEEP_SCRUB_STAMP           SNAPTRIMQ_LEN
7.5          25                  0        0         0       0     0 3030     3030 active+clean 2019-04-17 09:32:36.942188 17'4930  17:7365 [0]          0    [0]              0        0'0 2019-04-17 09:32:35.932453             0'0 2019-04-17 09:32:35.932453             0
3.1           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:28.893632     0'0    16:17 [0]          0    [0]              0        0'0 2019-04-17 09:32:27.352916             0'0 2019-04-17 09:32:27.352916             0
1.3           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:26.356443     0'0    16:19 [0]          0    [0]              0        0'0 2019-04-17 09:32:25.261341             0'0 2019-04-17 09:32:25.261341             0
2.0           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:27.360502     0'0    16:18 [0]          0    [0]              0        0'0 2019-04-17 09:32:26.350237             0'0 2019-04-17 09:32:26.350237             0
4.6           2                  0        0         0       0  1073    2        2 active+clean 2019-04-17 09:32:29.896178    10'2    16:27 [0]          0    [0]              0        0'0 2019-04-17 09:32:28.886562             0'0 2019-04-17 09:32:28.886562             0
5.7           1                  0        0         0       0     0    8        8 active+clean 2019-04-17 09:32:32.916080    16'8 17:14748 [0]          0    [0]              0        0'0 2019-04-17 09:32:31.905171             0'0 2019-04-17 09:32:31.905171             0
6.4           1                  0        0         0       0     8    1        1 active+clean 2019-04-17 09:32:34.927319    16'1    16:11 [0]          0    [0]              0        0'0 2019-04-17 09:32:33.913170             0'0 2019-04-17 09:32:33.913170             0
7.4          29                  0        0         0       0     0 3070     3070 active+clean 2019-04-17 09:32:36.942584 17'5670  17:8477 [0]          0    [0]              0        0'0 2019-04-17 09:32:35.932453             0'0 2019-04-17 09:32:35.932453             0
3.0           4                  0        0         0       0     0    8        8 active+clean 2019-04-17 09:32:28.893819    12'8    16:25 [0]          0    [0]              0        0'0 2019-04-17 09:32:27.352916             0'0 2019-04-17 09:32:27.352916             0
1.2           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:26.357014     0'0    16:19 [0]          0    [0]              0        0'0 2019-04-17 09:32:25.261341             0'0 2019-04-17 09:32:25.261341             0
2.1           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:27.359921     0'0    16:18 [0]          0    [0]              0        0'0 2019-04-17 09:32:26.350237             0'0 2019-04-17 09:32:26.350237             0
4.7           2                  0        0         0       0    92    3        3 active+clean 2019-04-17 09:32:29.896925    10'3    16:38 [0]          0    [0]              0        0'0 2019-04-17 09:32:28.886562             0'0 2019-04-17 09:32:28.886562             0
5.6           1                  0        0         0       0     0    8        8 active+clean 2019-04-17 09:32:32.915810    16'8 17:14748 [0]          0    [0]              0        0'0 2019-04-17 09:32:31.905171             0'0 2019-04-17 09:32:31.905171             0
6.5           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:34.927869     0'0    16:10 [0]          0    [0]              0        0'0 2019-04-17 09:32:33.913170             0'0 2019-04-17 09:32:33.913170             0
7.7          23                  0        0         0       0     0 3011     3011 active+clean 2019-04-17 09:32:36.943138 17'4011  17:5978 [0]          0    [0]              0        0'0 2019-04-17 09:32:35.932453             0'0 2019-04-17 09:32:35.932453             0
6.6           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:34.927211     0'0    16:10 [0]          0    [0]              0        0'0 2019-04-17 09:32:33.913170             0'0 2019-04-17 09:32:33.913170             0
3.3           3                  0        0         0       0    34    5        5 active+clean 2019-04-17 09:32:28.893420    12'5    16:22 [0]          0    [0]              0        0'0 2019-04-17 09:32:27.352916             0'0 2019-04-17 09:32:27.352916             0
2.2           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:27.360937     0'0    16:18 [0]          0    [0]              0        0'0 2019-04-17 09:32:26.350237             0'0 2019-04-17 09:32:26.350237             0
1.1           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:26.356419     0'0    16:19 [0]          0    [0]              0        0'0 2019-04-17 09:32:25.261341             0'0 2019-04-17 09:32:25.261341             0
4.4           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:29.895824     0'0    16:15 [0]          0    [0]              0        0'0 2019-04-17 09:32:28.886562             0'0 2019-04-17 09:32:28.886562             0
5.5           2                  0        0         0       0     0   16       16 active+clean 2019-04-17 09:32:32.915247   16'16 17:29490 [0]          0    [0]              0        0'0 2019-04-17 09:32:31.905171             0'0 2019-04-17 09:32:31.905171             0
7.6          24                  0        0         0       0     0 3062     3062 active+clean 2019-04-17 09:32:36.943040 17'4562  17:6838 [0]          0    [0]              0        0'0 2019-04-17 09:32:35.932453             0'0 2019-04-17 09:32:35.932453             0
6.7           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:34.926975     0'0    16:10 [0]          0    [0]              0        0'0 2019-04-17 09:32:33.913170             0'0 2019-04-17 09:32:33.913170             0
3.2           0                  0        0         0       0     0    1        1 active+clean 2019-04-17 09:32:28.893672    12'1    16:18 [0]          0    [0]              0        0'0 2019-04-17 09:32:27.352916             0'0 2019-04-17 09:32:27.352916             0
2.3           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:27.360371     0'0    16:18 [0]          0    [0]              0        0'0 2019-04-17 09:32:26.350237             0'0 2019-04-17 09:32:26.350237             0
1.0           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:26.356657     0'0    16:19 [0]          0    [0]              0        0'0 2019-04-17 09:32:25.261341             0'0 2019-04-17 09:32:25.261341             0
4.5           1                  0        0         0       0   736    1        1 active+clean 2019-04-17 09:32:29.895828    10'1    16:30 [0]          0    [0]              0        0'0 2019-04-17 09:32:28.886562             0'0 2019-04-17 09:32:28.886562             0
5.4           1                  0        0         0       0     0    8        8 active+clean 2019-04-17 09:32:32.914934    16'8 17:14748 [0]          0    [0]              0        0'0 2019-04-17 09:32:31.905171             0'0 2019-04-17 09:32:31.905171             0
7.2          26                  0        0         0       0     0 3071     3071 active+clean 2019-04-17 09:32:36.942716 17'4871  17:7291 [0]          0    [0]              0        0'0 2019-04-17 09:32:35.932453             0'0 2019-04-17 09:32:35.932453             0
2.7           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:27.360325     0'0    16:18 [0]          0    [0]              0        0'0 2019-04-17 09:32:26.350237             0'0 2019-04-17 09:32:26.350237             0
1.4           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:26.356592     0'0    16:19 [0]          0    [0]              0        0'0 2019-04-17 09:32:25.261341             0'0 2019-04-17 09:32:25.261341             0
3.6           2                  0        0         0       0     0    4        4 active+clean 2019-04-17 09:32:28.893581    17'4    17:21 [0]          0    [0]              0        0'0 2019-04-17 09:32:27.352916             0'0 2019-04-17 09:32:27.352916             0
4.1           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:29.896122     0'0    16:15 [0]          0    [0]              0        0'0 2019-04-17 09:32:28.886562             0'0 2019-04-17 09:32:28.886562             0
5.0           1                  0        0         0       0     0    8        8 active+clean 2019-04-17 09:32:32.915299    16'8 17:14751 [0]          0    [0]              0        0'0 2019-04-17 09:32:31.905171             0'0 2019-04-17 09:32:31.905171             0
6.3           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:34.926956     0'0    16:10 [0]          0    [0]              0        0'0 2019-04-17 09:32:33.913170             0'0 2019-04-17 09:32:33.913170             0
7.3          22                  0        0         0       0     0 3082     3082 active+clean 2019-04-17 09:32:36.941935 17'3582  17:5324 [0]          0    [0]              0        0'0 2019-04-17 09:32:35.932453             0'0 2019-04-17 09:32:35.932453             0
2.6           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:27.359721     0'0    16:18 [0]          0    [0]              0        0'0 2019-04-17 09:32:26.350237             0'0 2019-04-17 09:32:26.350237             0
1.5           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:26.356592     0'0    16:19 [0]          0    [0]              0        0'0 2019-04-17 09:32:25.261341             0'0 2019-04-17 09:32:25.261341             0
3.7           4                  0        0         0       0   566    7        7 active+clean 2019-04-17 09:32:28.893618    12'7    16:24 [0]          0    [0]              0        0'0 2019-04-17 09:32:27.352916             0'0 2019-04-17 09:32:27.352916             0
4.0           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:29.895887     0'0    16:15 [0]          0    [0]              0        0'0 2019-04-17 09:32:28.886562             0'0 2019-04-17 09:32:28.886562             0
5.1           1                  0        0         0       0     0    8        8 active+clean 2019-04-17 09:32:32.915864    16'8 17:14748 [0]          0    [0]              0        0'0 2019-04-17 09:32:31.905171             0'0 2019-04-17 09:32:31.905171             0
6.2           1                  0        0         0       0   288    2        2 active+clean 2019-04-17 09:32:34.927026    16'2    16:14 [0]          0    [0]              0        0'0 2019-04-17 09:32:33.913170             0'0 2019-04-17 09:32:33.913170             0
7.0          26                  0        0         0       0     0 3044     3044 active+clean 2019-04-17 09:32:36.942122 17'4444  17:6642 [0]          0    [0]              0        0'0 2019-04-17 09:32:35.932453             0'0 2019-04-17 09:32:35.932453             0
3.4           5                  0        0         0       0  1526    8        8 active+clean 2019-04-17 09:32:28.893307    12'8    16:25 [0]          0    [0]              0        0'0 2019-04-17 09:32:27.352916             0'0 2019-04-17 09:32:27.352916             0
2.5           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:27.360424     0'0    16:18 [0]          0    [0]              0        0'0 2019-04-17 09:32:26.350237             0'0 2019-04-17 09:32:26.350237             0
1.6           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:26.356090     0'0    16:19 [0]          0    [0]              0        0'0 2019-04-17 09:32:25.261341             0'0 2019-04-17 09:32:25.261341             0
4.3           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:29.895946     0'0    16:15 [0]          0    [0]              0        0'0 2019-04-17 09:32:28.886562             0'0 2019-04-17 09:32:28.886562             0
5.2           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:32.916132     0'0    16:12 [0]          0    [0]              0        0'0 2019-04-17 09:32:31.905171             0'0 2019-04-17 09:32:31.905171             0
6.1           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:34.927159     0'0    16:10 [0]          0    [0]              0        0'0 2019-04-17 09:32:33.913170             0'0 2019-04-17 09:32:33.913170             0
7.1          32                  0        0         0       0     0 3088     3088 active+clean 2019-04-17 09:32:36.943118 17'5188  17:7764 [0]          0    [0]              0        0'0 2019-04-17 09:32:35.932453             0'0 2019-04-17 09:32:35.932453             0
3.5           4                  0        0         0       0   160    6        6 active+clean 2019-04-17 09:32:28.893769    12'6    16:23 [0]          0    [0]              0        0'0 2019-04-17 09:32:27.352916             0'0 2019-04-17 09:32:27.352916             0
2.4           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:27.359664     0'0    16:18 [0]          0    [0]              0        0'0 2019-04-17 09:32:26.350237             0'0 2019-04-17 09:32:26.350237             0
1.7           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:26.356953     0'0    16:19 [0]          0    [0]              0        0'0 2019-04-17 09:32:25.261341             0'0 2019-04-17 09:32:25.261341             0
4.2           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:29.896993     0'0    16:15 [0]          0    [0]              0        0'0 2019-04-17 09:32:28.886562             0'0 2019-04-17 09:32:28.886562             0
5.3           1                  0        0         0       0     0    8        8 active+clean 2019-04-17 09:32:32.916577    16'8 17:14748 [0]          0    [0]              0        0'0 2019-04-17 09:32:31.905171             0'0 2019-04-17 09:32:31.905171             0
6.0           0                  0        0         0       0     0    0        0 active+clean 2019-04-17 09:32:34.927951     0'0    16:10 [0]          0    [0]              0        0'0 2019-04-17 09:32:33.913170             0'0 2019-04-17 09:32:33.913170             0

7 207 0 0 0 0    0 24458 24458
6   2 0 0 0 0  296     3     3
5   8 0 0 0 0    0    64    64
1   0 0 0 0 0    0     0     0
2   0 0 0 0 0    0     0     0
3  22 0 0 0 0 2286    39    39
4   5 0 0 0 0 1901     6     6

sum 244 0 0 0 0 4483 24570 24570
OSD_STAT USED    AVAIL   TOTAL  HB_PEERS PG_SUM PRIMARY_PG_SUM
0        1.0 GiB 9.0 GiB 10 GiB       []     56             56
sum      1.0 GiB 9.0 GiB 10 GiB
```

## CRUSH Map

```bash
$ ceph osd crush dump

{
    "devices": [
        {
            "id": 0,
            "name": "osd.0"
        }
    ],
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
            "weight": 642,
            "alg": "straw2",
            "hash": "rjenkins1",
            "items": [
                {
                    "id": -2,
                    "weight": 642,
                    "pos": 0
                }
            ]
        },
        {
            "id": -2,
            "name": "Yin",
            "type_id": 1,
            "type_name": "host",
            "weight": 642,
            "alg": "straw2",
            "hash": "rjenkins1",
            "items": [
                {
                    "id": 0,
                    "weight": 642,
                    "pos": 0
                }
            ]
        }
    ],
    "rules": [
        {
            "rule_id": 0,
            "rule_name": "replicated_rule",
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
        "chooseleaf_stable": 1,
        "straw_calc_version": 1,
        "allowed_bucket_algs": 54,
        "profile": "jewel",
        "optimal_tunables": 1,
        "legacy_tunables": 0,
        "minimum_required_version": "jewel",
        "require_feature_tunables": 1,
        "require_feature_tunables2": 1,
        "has_v2_rules": 0,
        "require_feature_tunables3": 1,
        "has_v3_rules": 0,
        "has_v4_buckets": 1,
        "require_feature_tunables5": 1,
        "has_v5_rules": 0
    },
    "choose_args": {}
}
```

## MDS Map

```bash
$ ceph fs map

dumped fsmap epoch 5
e5
enable_multiple, ever_enabled_multiple: 0,0
compat: compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object,5=mds uses versioned encoding,6=dirfrag is stored in omap,8=no anchor table,9=file layout v2,10=snaprealm v2}
legacy client fscid: 1

Filesystem 'cephfs' (1)
fs_name cephfs
epoch   5
flags   12
created 2019-04-17 09:32:27.749897
modified        2019-04-17 09:32:33.920068
tableserver     0
root    0
session_timeout 60
session_autoclose       300
max_file_size   1099511627776
min_compat_client       -1 (unspecified)
last_failure    0
last_failure_osd_epoch  0
compat  compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object,5=mds uses versioned encoding,6=dirfrag is stored in omap,8=no anchor table,9=file layout v2,10=snaprealm v2}
max_mds 1
in      0
up      {0=4117}
failed
damaged
stopped
data_pools      [2]
metadata_pool   3
inline_data     disabled
balancer
standby_count_wanted    0
4117:   192.168.16.2:6805/1573267578 'demo' mds.0.4 up:active seq 3
```

## 参考

* <http://docs.ceph.com/docs/master/architecture/#cluster-map>
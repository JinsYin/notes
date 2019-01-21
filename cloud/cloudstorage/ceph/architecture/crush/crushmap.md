# CRUSH Map

Cluster map：集群视图，显示mon map，osd map，pg map，crush map
cluster map有一个视图版本号（`epoch`），版本号越大越新，mon集群互相通信发现有高版本便更新自己的视图

## 查看

* 文本方式

```bash
$ ceph osd getcrushmap -o crushmap_compiled_file

# 可读
$ crushtool -d crushmap_compiled_file -o crushmap_decompiled_file
```

* 命令行方式

```bash
% ceph osd crush dump
```

## tunables

```plain
tunable choose_local_tries 0
tunable choose_local_fallback_tries 0
tunable choose_total_tries 50
tunable chooseleaf_descend_once 1
tunable chooseleaf_vary_r 1
tunable chooseleaf_stable 1
tunable straw_calc_version 1
tunable allowed_bucket_algs 54
```

```bash
$ ceph osd crush show-tunables
{
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
}
```

## devices

```plain
device 0 osd.0 class hdd
device 1 osd.1 class ssd
device 2 osd.2 class nvme
```

## types

```plain
type 0 osd
type 1 host
type 2 chassis
type 3 rack
type 4 row
type 5 pdu
type 6 pod
type 7 room
type 8 datacenter
type 9 region
type 10 root
```

## buckets

```json
host Yin {
    id -3           # do not change unnecessarily
    id -4 class hdd         # do not change unnecessarily
    # weight 0.010
    alg straw2
    hash 0  # rjenkins1
    item osd.0 weight 0.010
}
root default {
    id -1           # do not change unnecessarily
    id -2 class hdd         # do not change unnecessarily
    # weight 0.010
    alg straw2
    hash 0  # rjenkins1
    item Yin weight 0.010
}
```

## rules

```plain
rule replicated_rule {
    id 0
    type replicated
    min_size 1
    max_size 10
    step take default
    step choose firstn 0 type osd
    step emit
}
```
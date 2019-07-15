# CRUSH

本质上，CRUSH 算法是通过 `存储设备的权重` 来计算数据对象的分布的。

## CRUSH 算法

<!--
Storage cluster clients and each Ceph OSD Daemon use the CRUSH algorithm to efficiently compute information about data location.
-->

Ceph 客户端和 OSD Daemon 使用 CRUSH 算法计算数据位置信息，而不用查找表。

## CRUSH 层次结构（hierarchy）

## CRUSH bucket

### 故障域类型（Failure Domain Type）

* osd (or device)
* host
* chassis
* rack
* row
* pdu
* pod
* room
* datacenter
* region
* root

```bash
$ ceph osd crush tree
...

$ ceph osd crush dump
[
    {
        "id": -1,
        "name": "default",
        "type": "root",
        "type_id": 10,
        "items": [
            {
                "id": -2,
                "name": "localhost",
                "type": "host",
                "type_id": 1,
                "items": []
            },
            {
                "id": -3,
                "name": "Yin",
                "type": "host",
                "type_id": 1,
                "items": [
                    {
                        "id": 0,
                        "name": "osd.0",
                        "type": "osd",
                        "type_id": 0,
                        "crush_weight": 1.000000,
                        "depth": 2
                    }
                ]
            }
        ]
    }
]
```

## 备份策略

* 简单副本（Simple Replicated）
* 纠删码（Erasure Code, EC）

## 数据分发策略（Data Distribution Policy）

* 故障域隔离 - 同一份数据的不同副本分布在不同的故障域，降低数据损坏的风险
* 负载均衡 - 数据能够均匀地分布在磁盘容量不等的存储节点，避免部分节点空闲或超载
* 控制节点加入、离开时引起的数据迁移量

### CRUSH Ruleset

```bash
$ ceph osd crush rule ls
[
    "replicated_ruleset",
    "erasure-code"
]

$ ceph osd crush rule dump
[
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
                "item_name": "default" # 以 default root 为入口
            },
            {
                "op": "choose_firstn",
                "num": 0,
                "type": "osd" # 隔离域为 "osd" 级，即不同副本在不同 OSD 上
            },
            {
                "op": "emit" # 提交
            }
        ]
    },
    {
        "rule_id": 1,
        "rule_name": "erasure-code",
        "ruleset": 1,
        "type": 3,
        "min_size": 3,
        "max_size": 3,
        "steps": [
            {
                "op": "set_chooseleaf_tries",
                "num": 5
            },
            {
                "op": "set_choose_tries",
                "num": 100
            },
            {
                "op": "take",
                "item": -1,
                "item_name": "default"
            },
            {
                "op": "chooseleaf_indep",
                "num": 0,
                "type": "host"
            },
            {
                "op": "emit"
            }
        ]
    }
]
```
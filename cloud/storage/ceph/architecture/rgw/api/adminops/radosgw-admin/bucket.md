# RADOSGW Bucket 管理

## 要求

* 创建 Bucket 之前需要先创建 S3 用户（即 `user`），也就是 bucket 必须有用户来管理
* 一个用户（`user`）可以创建多个 Bucket，一个 Bucket 只属于一个用户

## 命令

| 子命令 | 描述 |
| ------ | ---- |
|        |

```sh
# 列出所有 bucket
$ radosgw-admin bucket list

# bucket 中的所有对象
$ radosgw-admin bucket list --bucket=<bucket>
```


```
 bucket list                list buckets (specify --allow-unordered for
                             faster, unsorted listing)
  bucket limit check         show bucket sharding stats
  bucket link                link bucket to specified user
  bucket unlink              unlink bucket from specified user
  bucket stats               returns bucket statistics
  bucket rm                  remove bucket
  bucket check               check bucket index
  bucket reshard             reshard bucket
  bucket rewrite             rewrite all objects in the specified bucket
  bucket sync disable        disable bucket sync
  bucket sync enable         enable bucket sync

```

```sh
$ radosgw-admin bucket stats --bucket="ais"
-------------------------------------------
{
    "bucket": "ais",
    "zonegroup": "3425c803-1cc9-47e9-b617-51549dbe1751",
    "placement_rule": "default-placement",
    "explicit_placement": {
        "data_pool": "",
        "data_extra_pool": "",
        "index_pool": ""
    },
    "id": "5f42457c-6805-45e0-b424-766525dad22e.64610.2",
    "marker": "5f42457c-6805-45e0-b424-766525dad22e.64610.2",
    "index_type": "Normal",
    "owner": "s3demo",
    "ver": "0#2",
    "master_ver": "0#0",
    "mtime": "2019-06-14 03:08:42.652124",
    "max_marker": "0#",
    "usage": {
        "rgw.main": {
            "size": 7,
            "size_actual": 4096,
            "size_utilized": 7,
            "size_kb": 1,
            "size_kb_actual": 4,
            "size_kb_utilized": 1,
            "num_objects": 1
        }
    },
    "bucket_quota": {
        "enabled": false,
        "check_on_raw": false,
        "max_size": -1,
        "max_size_kb": 0,
        "max_objects": -1
    }
}
```

## Bucket 策略

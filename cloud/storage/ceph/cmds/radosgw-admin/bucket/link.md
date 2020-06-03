# radosgw-admin bucket link

链接/转移 Bucket 给指定用户。

```sh
# "bit" bucket 属于 "jjyy" 用户，将 "bit" 链接给 "jins" 用户
$ radosgw-admin bucket link --bucket="bit" --bucket-id="f7d077de-6a11-462a-be1d-074f8a5263b5.4122.1" --uid="jins"
```

```sh
# 此时 "bit" bucket 属于 jins 用户
$ radosgw-admin bucket stats --bucket="bit"
{
    "bucket": "bit",
    "zonegroup": "048fff23-4530-420d-9acb-7d06d6893188",
    "placement_rule": "default-placement",
    "explicit_placement": {
        "data_pool": "",
        "data_extra_pool": "",
        "index_pool": ""
    },
    "id": "f7d077de-6a11-462a-be1d-074f8a5263b5.4122.1",
    "marker": "f7d077de-6a11-462a-be1d-074f8a5263b5.4122.1",
    "index_type": "Normal",
    "owner": "jins", # -_-
    "ver": "0#2",
    "master_ver": "0#0",
    "mtime": "2019-10-18 08:49:07.127217",
    "max_marker": "0#",
    "usage": {
        "rgw.main": {
            "size": 146188,
            "size_actual": 147456,
            "size_utilized": 146188,
            "size_kb": 143,
            "size_kb_actual": 144,
            "size_kb_utilized": 143,
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

```sh
# 貌似不成功
$ radosgw-admin bucket unlink --bucket="bit" --bucket-id="f7d077de-6a11-462a-be1d-074f8a5263b5.4122.1" --uid="jins"
```

实测发现：

* "jjyy" 用户不再拥有 "bit" 桶，相当于转移给了 "jins" 用户（s3cmd 可能出现看不见 "bit" 桶，但是能够访问该桶）

# radosgw-admin bucket stats

```sh
# 所有 Bucket
$ radosgw-admin bucket stats
[
    {
        "bucket": "yin",
        "zonegroup": "048fff23-4530-420d-9acb-7d06d6893188",
        "placement_rule": "default-placement",
        "explicit_placement": {
            "data_pool": "",
            "data_extra_pool": "",
            "index_pool": ""
        },
        "id": "f7d077de-6a11-462a-be1d-074f8a5263b5.4122.2",
        "marker": "f7d077de-6a11-462a-be1d-074f8a5263b5.4122.2",
        "index_type": "Normal",
        "owner": "jjyy",
        "ver": "0#1",
        "master_ver": "0#0",
        "mtime": "2019-10-18 08:30:34.845337",
        "max_marker": "0#",
        "usage": {},
        "bucket_quota": {
            "enabled": false,
            "check_on_raw": false,
            "max_size": -1,
            "max_size_kb": 0,
            "max_objects": -1
        }
    },
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
        "owner": "jjyy",
        "ver": "0#2",
        "master_ver": "0#0",
        "mtime": "2019-10-18 08:07:33.331855",
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
]
```

```sh
# 特定 Bucket
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
    "owner": "jjyy",
    "ver": "0#2",
    "master_ver": "0#0",
    "mtime": "2019-10-18 08:07:33.331855",
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

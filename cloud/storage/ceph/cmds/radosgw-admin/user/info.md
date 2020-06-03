# radosgw-admin user info

```sh
$ radosgw-admin user info --uid="jjyy"
{
    "user_id": "jjyy",
    "display_name": "Ceph demo user",
    "email": "",
    "suspended": 0,
    "max_buckets": 1000,
    "auid": 0,
    "subusers": [],
    "keys": [
        {
            "user": "jjyy",
            "access_key": "jjyy",
            "secret_key": "jjyy"
        }
    ],
    "swift_keys": [],
    "caps": [
        {
            "type": "buckets",
            "perm": "*"
        },
        {
            "type": "metadata",
            "perm": "*"
        },
        {
            "type": "usage",
            "perm": "*"
        },
        {
            "type": "users",
            "perm": "*"
        }
    ],
    "op_mask": "read, write, delete",
    "default_placement": "",
    "placement_tags": [],
    "bucket_quota": {
        "enabled": false,
        "check_on_raw": false,
        "max_size": -1,
        "max_size_kb": 0,
        "max_objects": -1
    },
    "user_quota": {
        "enabled": false,
        "check_on_raw": false,
        "max_size": -1,
        "max_size_kb": 0,
        "max_objects": -1
    },
    "temp_url_keys": [],
    "type": "rgw",
    "mfa_ids": []
}
```

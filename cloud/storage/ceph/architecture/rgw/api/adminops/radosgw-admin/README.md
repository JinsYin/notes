# RADOSGW-ADMIN

`radosgw-admin` 是针对 RADOSGW 服务的命令行管理工具，用于用户和 Bucket 等资源的管理。

## 目录

* 用户管理
* 配额管理
* Bucket 管理

## 安装配置

* 安装特定版本

```sh
# CentOS
$ yum install ceph-radosgw

# Ubuntu
$ apt-get install radosgw
```

* 配置 Keyring

## 重命名

```sh
# 永久别名
$ echo "alias rgwadm='radosgw-admin'" >> ~/.bashrc

# 立即生效
$ source ~/.bashrc
```

## 用户管理

## 权限管理

```sh
# 允许读取、修改用户信息
$ radosgw-admin caps add --uid=s3demo --caps="users=*"
{
    "user_id": "s3demo",
    "display_name": "S3 Demo User",
    "email": "",
    "suspended": 0,
    "max_buckets": 1000,
    "auid": 0,
    "subusers": [],
    "keys": [
        {
            "user": "s3demo",
            "access_key": "NA7IWV1AL5R7MNCMEZKP",
            "secret_key": "KdlGTV1m0A2hqohiUk9Y1gcr08AxxE6ISj6Wu0s0"
        }
    ],
    "swift_keys": [],
    "caps": [
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
    "type": "rgw"
}
```

```sh
# 添加 s3demo 用户对所有 usage 信息的读写权限
$ radosgw-admin caps add --uid=s3demo --caps="usage=read,write"
{
    "user_id": "s3demo",
    "display_name": "S3 Demo User",
    "email": "",
    "suspended": 0,
    "max_buckets": 1000,
    "auid": 0,
    "subusers": [],
    "keys": [
        {
            "user": "s3demo",
            "access_key": "NA7IWV1AL5R7MNCMEZKP",
            "secret_key": "KdlGTV1m0A2hqohiUk9Y1gcr08AxxE6ISj6Wu0s0"
        }
    ],
    "swift_keys": [],
    "caps": [
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
    "type": "rgw"
}
```

##

## Python 库

使用 admin 接口同样需要 S3 的权限认证

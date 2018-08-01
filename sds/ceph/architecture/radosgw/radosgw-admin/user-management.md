# 用户管理

## 用户类型

| 用户类型    | 用户属性                                          | 描述                                                                                |
| ----------- | ------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **user**    | user ID（`uid`）、`display-name`、`email` address | 体现 S3 接口的用户（以下统一为 `S3 user`）                                          |
| **subuser** | subuser ID（`subuser`）、`access` level           | 体现 Swfit 接口的用户（以下统一为 `Swift subuser`）；`subuser` 和 `user` 是相关联的 |

## 创建用户

### 创建一个 S3 user

```bash
$ radosgw-admin user create --uid="s3demo" --display-name="S3 Demo User" --email="s3demo@gmail.com"
{
    "user_id": "s3demo",
    "display_name": "S3 Demo User",
    "email": "s3demo@gmail.com",
    "suspended": 0,
    "max_buckets": 1000,
    "auid": 0,
    "subusers": [],
    "keys": [
        {
            "user": "s3demo",
            "access_key": "2PGA536VQV3CYJFR4XEK", # S3 Access Key
            "secret_key": "xmqMUqTVNBwlBlXkkoUIzbcuHws9itS2Y0hkQzBt" # S3 Secret Key
        }
    ],
    "swift_keys": [],
    "caps": [],
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

### 为 S3 user 创建一个 Swift subuser

* 必须指定 user ID、subuser ID，以及 subuser 的访问级别
* subuser 的默认命名规则是 `<user-name>:<subuser-name>`（创建时可以省略 user-name）

```bash
$ radosgw-admin subuser create --uid="s3demo" --subuser="s3demo:swiftdemo" --access=[read | write | readwrite | full]
{
    "user_id": "s3demo",
    "display_name": "S3 demo user",
    "email": "",
    "suspended": 0,
    "max_buckets": 1000,
    "auid": 0,
    "subusers": [
        {
            "id": "s3demo:swiftdemo", # <user-name>:<subuser-name>
            "permissions": "full-control"
        }
    ],
    "keys": [
        {
            "user": "s3demo",
            "access_key": "AAYGBK6N0VVIIS5Y87ZX",
            "secret_key": "UoPBZliTWyQdtnOy3we1MCuKNbmrkcOu5ofzg2mV"
        }
    ],
    "swift_keys": [
        {
            "user": "s3demo:swiftdemo",
            "secret_key": "knwtVJYMyybNHVlnr0FncCYOijn0V9nWwWZ2mTGA"
        }
    ],
    "caps": [],
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

## 查看用户信息

```bash
# 查看用户信息
$ radosgw-admin user info --uid="s3demo"
```

## 修改用户信息

```bash
# 修改 S3 user 信息
$ radosgw-admin user modify --uid="s3demo" --display-name="Jins Yin"

# 修改 Swift subuser 信息
$ radosgw-admin user modify --uid="s3demo" --subuser="s3demo:swiftdemo" --access=readwrite
```

## 启用/暂停用户

* 默认是启用的

```bash
# 暂停
$ radosgw-admin user suspend --uid='s3demo'

# 验证
$ radosgw-admin user info --uid='s3demo' | grep 'suspended'
  "suspended": 1,

# 启用
$ radosgw-admin user enable --uid='s3demo'
```

## 删除用户

```bash
# 删除 S3 user
$ radosgw-admin user rm --uid="s3demo"

# 删除 Swift user
$ radosgw-admin subuser rm ---subuser=swiftdemo2""
```

## 列出用户

```bash
# 列出用户
$ radosgw-admin user list
[
    "jjyy",
    "s3demo"
]
```

## 创建/删除 key

| 参数选项             | 描述                                       |
| -------------------- | ------------------------------------------ |
| `--key-type=<type>`  | 指定秘钥类型；可选值：`s3`、`swift`        |
| `--access-key=<key>` | 手动指定 S3 Access Key                     |
| `--secret-key=<key>` | 手动指定 S3 Secret Key 或 Swift Secret Key |
| `--gen-access-key`   | 自动生成 S3 Access Key                     |
| `--gen-secret`       | 自动生成 S3 Secret Key 或 Swift Secret Key |

S3 API - access key、secret key
Swift API - secret key（password）

```bash
# 为 S3 user 创建一对 access-key、secret-key（每个 S3 user 可以创建多个密钥对）
# 密钥对必须 5 位数及以上
$ radosgw-admin key create --uid="s3demo" --key-type=s3 --access-key="s3jjyy" --secret-key="s3jjyy"

# 为 Swift subuser 创建一个 secret-key（每个 Swift subuser 只能有一个 secret-key）
$ radosgw-admin key create --subuser="s3demo:swiftdemo" --key-type=swift --secret-key="jjyy"
```

```bash
# 移除 S3 密钥对（指定 Access Key 即可）
$ radosgw-admin key rm --uid='s3demo' --key-type=s3 --access-key="s3jjyy"

# 移除 Swift Secret Key
$ radosgw-admin key rm --subuser="s3demo:swiftdemo" --key-type=swift
```

## 添加/删除管理功能（Administrative Capabilities）

Ceph 集群提供了一个管理 API，使用户能够通过 REST API 执行管理功能。默认不能访问该 API 。

```plaintext
// '*' == 'read,write'
--caps="[users|buckets|metadata|usage|zone]=[*|read|write|read,write]"
```

```bash
# 为 S3 user 添加管理功能
$ radosgw-admin caps add --uid="s3demo" --caps="buckets=*"
```

```bash
# 移除管理功能
$ radosgw-admin caps rm --uid="s3demo" --caps="buckets=write"
```

## 参考

* [USER MANAGEMENT](http://docs.ceph.com/docs/master/radosgw/admin/#user-management)
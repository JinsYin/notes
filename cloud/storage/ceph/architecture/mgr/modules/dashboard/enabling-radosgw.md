# 实现管理 RADOSGW

如果想在 Dashboard 中使用 RADOSGW 的管理功能（此处 Dashboard 是客户端，RADOSGW 是服务端），需要提供带有 `system` 标志（即对 RADOSGW 服务有管理权限）的用户登录凭证（Access Key 和 Secret Key）。

* 语法

```sh
# 创建带有管理权限的 RADOSGW 新用户，从输出结果中获取 access_key 和 secret_key
$ radosgw-admin user create --uid=<user_id> --display-name=<display_name> --system

# 对于已存在的具有管理权限的 RADOSGW 用户，直接获取 access_key 和 secret_key
$ radosgw-admin user info --uid=<user_id> | grep -E "access_key|secret_key"

# dashboard 模块设置用于管理 RADOSGW 的用户凭证
$ ceph dashboard set-rgw-api-access-key <access_key>
$ ceph dashboard set-rgw-api-secret-key <secret_key>

# dashboard 将尝试从 Ceph Manager 的 service map 中获取并设置 RADOSGW 的主机和端口，如有需求可以手动设置
$ ceph dashboard set-rgw-api-host <host>
$ ceph dashboard set-rgw-api-port <port>
```

* 实验

```sh
$ radosgw-admin user create --uid="dashboard" --display-name="Ceph Manager Dashboard" --system

$ radosgw-admin user info --uid="dashboard" | grep -E "access_key|secret_key"
-----------------------------------------------------------------------------
"access_key": "CIZ6NKUYE0Z6LGJT5H04",
"secret_key": "JOMeb2bRD8F4JLsmfye699h4DsWN8QB9Z1acOUB8"

$ ceph dashboard set-rgw-api-access-key CIZ6NKUYE0Z6LGJT5H04
$ ceph dashboard set-rgw-api-secret-key JOMeb2bRD8F4JLsmfye699h4DsWN8QB9Z1acOUB8

# 测试发现，以下信息可能必须配置
$ ceph dashboard set-rgw-api-host 192.168.1.175 # 不支持多个，所以最好在 RGW 前增加一个 LB
$ ceph dashboard set-rgw-api-port 8080

# 如果配置没有立即生效，可以重新加载 dashboard 模块
$ ceph mgr module disable dashboard && ceph mgr module enable dashboard
```

```sh
# 查询存储在 MON 配置数据库中的信息
$ ceph config-key ls
--------------------
[
    ......
    "config/mgr/mgr/dashboard/RGW_API_ACCESS_KEY",
    "config/mgr/mgr/dashboard/RGW_API_HOST",
    "config/mgr/mgr/dashboard/RGW_API_PORT",
    "config/mgr/mgr/dashboard/RGW_API_SECRET_KEY",
    "config/mgr/mgr/dashboard/RGW_API_USER_ID",
    ......
]
```

* 截图

开启前：
开启后：

# RADOSGW 配额管理

Ceph 对象网关允许你为用户和用户所拥有的 Bucket 设置配额。配额包括 `Bucket 的最大对象数` 和 `Bucket 可容纳的最大存储大小`。

| 配额参数        | 描述                                          |
| --------------- | --------------------------------------------- |
| `--bucket`      | 为用户所拥有的 Bucket 指定配置                |
| `--max-objects` | 指定对象的最大数量                            |
| `--max-size`    | 指定配额大小；单位：`B/K/M/G/T`（默认是 `B`） |
| `--quota-scopy` | 设置配额的范围；可选项：`bucket`、`user`      |

## 默认配额

可以在配置中设置默认配额，它将作用于新用户。

```sh
$ vi ceph.conf
[client.radosgw.{instance-name}]
rgw bucket default quota max objects
rgw bucket default quota max size
rgw user default quota max objects
rgw user default quota max size
```

## 设置 user 配额

```sh
# Template
$ radosgw-admin quota set --quota-scope=user --uid=<uid> [--max-objects=<num objects>] [--max-size=<max size>]
```

```sh
# 为 "s3demo" 用户设置总共 5GB 和 1024 个对象的配额
$ radosgw-admin quota set --quota-scope=user --uid="s3demo" --max-objects=1024 --max-size=5G
```

## 启用/关闭 user 配额

```sh
# 启用
$ radosgw-admin quota enable --quota-scope=user --uid="s3demo"

# 关闭
$ radosgw-admin quota disable --quota-scope=user --uid="s3demo"
```

## 设置 Bucket 配额

```sh
# Template
$ radosgw-admin quota set --quota-scope=bucket --uid=<uid> [--max-objects=<num objects>] [--max-size=<max size]
```

```sh
# 为 "s3demo" 用户所拥有的 Bucket 设置 5GB 和 1024 个对象
$ radosgw-admin quota set --quota-scope=bucket --uid="s3demo" --max-objects=1024 --max-size=5G
```

## 启用/关闭 Bucket 配额

```sh
# 启用
$ radosgw-admin quota enable --quota-scope=bucket --uid="s3demo"

# 关闭
$ radosgw-admin quota disable --quota-scope=bucket --uid="s3demo"
```

## 查看用户的配额信息

```sh
% radosgw-admin user info --uid=<uid>
```

## 配额统计

```sh
# 查看用户的使用统计（默认是异步更新的）
$ radosgw-admin user stats --uid="s3demo"

# 手动更新所有用户和所有 bucket 的配额统计
$ radosgw-admin user stats --uid="s3demo" --sync-stats
```

## 参考

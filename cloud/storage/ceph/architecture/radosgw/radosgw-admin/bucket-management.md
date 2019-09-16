# Bucket 管理

```bash
$ radosgw-admin user bucket list
$ radosgw-admin user bucket stats
```

注意事项：尽管每个 S3 用户都可以创建 Bucket，但是 Bucket 名必须是唯一的；换句话说，如果 u-1 用户创建了 s3://data 桶，u-2 用户不能再创建该桶。
#!/usr/bin/env python3

import boto
import boto.s3.connection

s3_host = '192.168.8.220'
s3_port = 8080  # or: 7480
s3_bucket = 'nextcloud'
access_key = 'jjyy'
secret_key = 'jjyy'

"获取 S3 连接"
conn = boto.connect_s3(
    host=s3_host,
    port=s3_port,
    aws_access_key_id=access_key,
    aws_secret_access_key=secret_key,
    is_secure=False,
    calling_format=boto.s3.connection.OrdinaryCallingFormat()
)

"创建一个 Bucket"
bucket = conn.create_bucket(s3_bucket)

"列出所有的 Bucket"
for bucket in conn.get_all_buckets():
    print('Bucket Name: %s, Creation Date:%s' %
          (bucket.name, bucket.creation_date))

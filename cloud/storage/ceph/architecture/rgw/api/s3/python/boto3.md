# S3 for Python - boto3

## 安装

```sh
# 安装最新版本
$ pip install -U boto3
```

## 示例

```python
import boto3

s3_endpoint = 'http://192.168.8.220:8080'
s3_access_key = 'jjyy'
s3_secret_key = 'jjyy'
s3_bucket = 'mybucket'
s3_region = 'CN' # optional

s3 = boto3.client('s3', region_name=s3_region, endpoint_url=s3_endpoint, aws_access_key_id=s3_access_key, aws_secret_access_key=s3_secret_key)

'''创建一个 Bucket'''
s3.create_bucket(Bucket=s3_bucket)

'''列出所有的 Bucket'''
response = s3.list_buckets()
buckets = [bucket['Name'] for bucket in response['Buckets']]
print("Bucket List: %s" % buckets)

'''上传文件到 Bucket'''
filename = '/tmp/file.txt'
s3.upload_file(filename, s3_bucket, 'file.txt')
```

## 参考

* [Amazon S3 Examples](https://boto3.readthedocs.io/en/latest/guide/examples.html)
* [S3](https://boto3.readthedocs.io/en/stable/reference/services/s3.html)
* [github.com/boto/boto3](https://github.com/boto/boto3)

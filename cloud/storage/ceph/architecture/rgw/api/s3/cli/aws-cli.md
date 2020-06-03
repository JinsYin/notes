# aws-cli

## 安装

```sh
# Pip
$ pip install -U awscli
```

## 配置

```sh
$ vi ~/.aws/config
[default]
region = CN
output = json

[profile ceph]
aws_access_key_id=jjyy
aws_secret_access_key=jjyy
s3 =
  endpoint-url = http://192.168.8.220:8080
```

## 测试

```sh
$ aws --endpoint-url http://192.168.8.220:8080 s3 ls

# export AWS_ENDPOINT_URL="http://192.168.8.220:8080"
$ aws s3 ls
```

```sh
$ aws --profile ceph s3 ls
```

## 参考

* [github.com/aws/aws-cli](https://github.com/aws/aws-cli)
* [Ability to specify endpoint-url in profile](https://github.com/aws/aws-cli/issues/1270)
* [On Ceph RGW/S3 Object Versioning](https://ceph.io/planet/on-ceph-rgw-s3-object-versioning/)

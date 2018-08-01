# aws-cli

## 安装

```bash
# Pip
$ pip install -U awscli
```

## 配置

```bash
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

```bash
aws --endpoint-url http://192.168.8.220:8080 s3 ls

# export AWS_ENDPOINT_URL="http://192.168.8.220:8080"
$ aws s3 ls
```

```bash
aws --profile ceph s3 ls
```

## 参考

* [github.com/aws/aws-cli](https://github.com/aws/aws-cli)
* [Ability to specify endpoint-url in profile](https://github.com/aws/aws-cli/issues/1270)
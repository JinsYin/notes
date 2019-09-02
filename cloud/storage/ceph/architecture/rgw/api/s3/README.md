# Ceph 对象网关之 S3 API

> S3 非常适合处理非结构化数据（图片、视频）

## 术语

* Region：用于标识数据存储的物理区域，如中国区、欧洲区
* Service：S3 提供给用户的虚拟存储空间；每个虚拟存储空间可拥有多个 Bucket
* Bucket：存放 Object 的容器；RGw 中每个用户最多可以创建 `1000` 个 Bucket，每个 Bucket 可以存放无数个 Object
* Object：

## 测试 S3

## 运行 S3

* <https://github.com/jubos/fake-s3>
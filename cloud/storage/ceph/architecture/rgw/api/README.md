# Ceph 对象网关 API

Radosgw（librgw）接口：

* Swift API: 为 OpenStack Swift API 提供的对象存储功能
* S3 API：为 Amazon S3 API 提供的对象存储功能
* Admin API：原生 API，应用程序可以直接使用它获取访问存储系统的权限以管理存储系统

要访问 Ceph 的对象存储系统，可以利用 librgw 和 librados 库。其中，直接使用 librados 访问 Ceph 对象存储速度会更快。

## 目录

* 管理 API
  * radosgw-admin
* S3 API
  * cli
    * aws-cli
    * aws-shell
    * s3cmd
  * java
  * python
* Swift API
  * python

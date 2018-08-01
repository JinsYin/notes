# Rados Gateway：对象存储

Ceph 对象网关用于存储　docker image；  
Ceph 对象网关m默认运行在 Civetweb（默认端口7480）上, 而不再是　Apache　和　FastCGI　之上。

>[有云Ceph课堂：使用CivetWeb快速搭建RGW](https://www.ustack.com/blog/civetweb/?belong=industry-news)

## API 系统

Radosgw（librgw）接口：

* Swift API: 为 OpenStack Swift API 提供的对象存储功能
* S3 API：为 Amazon S3 API 提供的对象存储功能
* Admin API：原生 API，应用程序可以直接使用它获取访问存储系统的权限以管理存储系统

要访问 Ceph 的对象存储系统，可以利用 librgw 和 librados 库。其中，直接使用 librados 访问 Ceph 对象存储速度会更快。

## 安装

实际发现 jewel 版本在 `ceph-deploy install` 安装 ceph 的时候默认已经安装了 ceph-radosgw 组件，但直接使用 ceph 源来安装 ceph 时不会自动安装 ceph-radosgw 组件，可以使用 `rpm -qa | grep ceph` 来检查以下安装了到底安装了哪些 ceph 组件。

```bash
# ceph-deploy 节点
$ cd /ceph-cluster
$ ceph-deploy install --rgw <gateway-node1> [<gateway-node2> ...] # ruguo
$ ceph-deploy admin <gateway-node1> [<gateway-node2> ...]　# 添加为管理节点
```

```bash
# radosgw 节点
$ rpm -qa | grep ceph-radosgw # 检查是否安装完成
$ yum install -y ceph-radosgw # 可选，如果没有安装成功，可以使用该命令安装
```


## 新建网关实例

```bash
# ceph-deploy 节点
$ cd /ceph-cluster
$ ceph-deploy rgw create <gateway-node1> [<gateway-node2> ...] # 创建 rgw 实例
```

```bash
# rgw 服务默认端口　7480
http://gateway-node1:7480
```

```bash
# rgw 节点
$ netstat -tpln | grep radosgw
```

## 修改默认端口 (暂时不修改)

```bash
# ceph-deploy 节点
$ cd /ceph-cluster
$ cat ceph.conf
...
[client.rgw.centos-11]
rgw_frontends = "civetweb port=8000"
```

```bash
# 更新配置到 rgw 节点
$ ceph-deploy --overwrite-conf config push <gateway-node> [<other-nodes>]
```

```bash
# rgw 节点
$ systemctl restart ceph-radosgw@rgw.centos-11.service　# 重启 rgw 服务
$ systemctl status ceph-radosgw@rgw.centos-11.service
```







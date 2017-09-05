# Ceph 对象网关

Ceph　对象网关用于存储　docker image；  
Ceph 对象网关m默认运行在 Civetweb（默认端口7480）上, 而不再是　Apache　和　FastCGI　之上。

>[有云Ceph课堂：使用CivetWeb快速搭建RGW](https://www.ustack.com/blog/civetweb/?belong=industry-news)


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


# 修改默认端口 (暂时不修改)

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


## 使用网关

为使用 REST 接口，首先需要为 S3 接口创建一个初始 Ceph 对象网关用户，然后为 Swift 接口创建一个子用户，最后需要验证创建的用户是否可以访问网关。
　　
以下操作均在 ceph 管理节点上操作。
　　
1. 为　S3　访问创建　radosgw　用户
```bash
$ radosgw-admin user create --uid="registry" --display-name="Docker Registry User" # keys.access_key 和 keys.secret_key 用来访问时作验证
$ radosgw-admin user info --uid="registry" # 查看rgw 用户信息
$ rados lspools # 创建用户后会新增几个 pool
```

2. 为 Swift 接口创建一个子用户
```bash
# 使用这种方式访问集群，需要新建一个 Swift 子用户，创建用户包含以下两个步骤
$ radosgw-admin subuser create --uid="registry" --subuser=registry:swift --access=full　# 新建 Swift 用户
$ radosgw-admin key create --subuser=registry:swift --key-type=swift --gen-secret # 创建　secret key　（重复执行会更新 secret_key）
```

3. 访问验证

测试S3访问
```bash
# 测试脚本将连接 radosgw, 新建一个新的 bucket 并列出所有的 buckets
$ yum install -y python-boto # 安装 python-boto 包
$ vi s3test.py # 修改access_key, secret_key 和 host
$ python s3test.py # 输出: my-new-bucket 2015-02-16T17:09:10.000Z
```

测试 Swift 访问
```bash
# 安装swift客户端 (CentOS)
$ yum install -y python-setuptools
$ easy_install pip
$ pip install --upgrade setuptools
$ pip install --upgrade python-swiftclient
```

```bash
# 安装swift客户端 (Ubuntu)
$ apt-get install -y python-setuptools
$ easy_install pip
$ pip install --upgrade setuptools
$ pip install --upgrade python-swiftclient
```

```bash
# 输出: my-new-bucket)
# swift -A http://{IP ADDRESS}:{port}/auth/1.0 -U registry:swift -K '{swift_secret_key}' list
$ swift -A http://192.168.1.11:7480/auth/1.0 -U registry:swift -K 'fcq..' list
$ swift -A http://192.168.1.11:7480/auth/1.0 -U registry:swift -K 'fcq..' stat -v
```

## 部署 registry

我基于官方的 registry 镜像重新构建了一个镜像（registry-ceph），允许修改端口和/或使用　ceph　的对象存储来存储镜像，而不是存储在本地。同时，这个镜像也可以作为普通 registry 用。

使用 ceph 对象存储
```bash
$ docker run -itd --name registry-ceph -p 80:80 -e HTTP_PORT=80 \
-e STORAGE_SWIFT_AUTHURL="http://192.168.1.11:7480/auth/v1" \ 
-e STORAGE_SWIFT_USERNAME="registry:swift" \
-e STORAGE_SWIFT_PASSWORD="NyINaRDvoFiZUAaCUHsNz6Nzu6glbn729rfDqh7r" \
registry-ceph:2.6.0
```

作普通镜像用
```bash
$ docker run -itd --name registry-ceph -p 80:80 -e HTTP_PORT=80 registry-ceph:2.6.0
```

检查
```bash
# web
curl http://localhost/v2/_catalog
```

```bash
# 尝试上传镜像（docker daemon 设置 --insecure-registry 192.168.1.0/24 并重启）
$ docker tag alpine:3.5 192.168.1.11/alpine:3.5
$ docker push 192.168.1.11/alpine:3.5
$ docker rmi 192.168.1.11/alpine:3.5 && docker pull 192.168.1.11/alpine:3.5
```

```bash
# 检查一下容器中 /var/lib/registry 对应的 volume 是否为空， 数据应该都存在　ceph　中才对
$ rados ls --pool default.rgw.buckets.data | grep repositories/alpine | grep 3.5
```

有误
```bash
# 删除镜像 （通过删除对象来删除镜像） 
$ rados ls --pool default.rgw.buckets.data | grep repositories/alpine
$ obj=$(rados ls --pool default.rgw.buckets.data | grep repositories/alpine)
$ if [ -n "${obj}" ]; then rados rm ${obj} --pool default.rgw.buckets.data; fi
$ rados ls --pool default.rgw.buckets.data | grep repositories/alpine # 检查
```


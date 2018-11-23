# 使用 Swift 部署 Docker Registry

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
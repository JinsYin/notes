# Ceph RBD：RADOS 块设备

在使用 mesos/marathon 来编排 docker 任务过程中发现，数据存储存在很大问题，典型的是数据无法共享、无法随容器一起迁移。所以决定使用 ceph 块存储 rbd 来存储 docker volume，不过还需要一个 volume driver。

## 插件

目前，基于此设计的插件主要有两个：
-[codedellemc/rexray](https://github.com/codedellemc/rexray)
-[contiv/volplugin](https://github.com/contiv/volplugin)

最终，考虑到 emc 的强（niu）大（bi），我选择了 rexray 来作为 volume driver。不过还需要注意以下几点：
1. 使用 rexray 插件的节点要求必须是 ceph admin 节点（ceph-deploy admin node1）。
2. The Ceph RBD driver only works when the client and server are on the same node. There is no way for a centralized libStorage server to attach volumes to clients, therefore the libStorage server must be running on each node that wishes to mount RBD volumes.

rexray
>文档： http://rexrayconfig.codedellemc.com
>版本： 0.9.1

## 安装

```sh
$ curl -sSL https://dl.bintray.com/emccode/rexray/install | sh -s -- list # 查询版本
$ curl -sSL https://dl.bintray.com/emccode/rexray/install | sh -s -- list stable # 查询稳定版
$ curl -sSL https://dl.bintray.com/emccode/rexray/install | sh -s -- stable 0.9.1 # 安装指定版本
$ rexray version # 查询版本信息
```

创建配置文件 （自动生成配置：http://rexrayconfig.codedellemc.com/）
```sh
$ cat /etc/rexray/config.yml # 默认 pool 为 docker （我这里去除了日志输出）
rexray:
  logLevel: debug
libstorage:
  logging:
    level: debug
    httpRequests: true
    httpResponses: true
libstorage:
  service: rbd
rbd:
  defaultPool: docker
```

rexray 并不会根据配置文件自动创建 pool, 需要在 ceph 中手动创建。
```sh
$ ceph osd pool create docker 64 64 # 创建一个名为 docker 的 pool
$ ceph osd pool ls
```

启动 rexray 服务
```sh
$ systemctl restart rexray # 同：rexray service start
$ systemctl enable rexray # 开机自启动
$ systemctl status rexray # 同：rexray service status
```

## 插件升级

```sh
$ rm -f /run/docker/plugins/rexray.sock
$ curl -sSL https://dl.bintray.com/emccode/rexray/install | sh -s -- stable 0.9.1
$ systemctl restart docker
```

## 容器安装（过）

我试着基于 rexray 插件构建了一个 docker 镜像`rexray-ceph`，来使用 ceph 块存储，不过并`未实验成功`。

```sh
$ docker run -itd --name rexray-ceph --net=host --privileged -v /run/docker/plugins:/run/docker/plugins -v /var/run/rexray:/var/run/rexray -v /var/run/docker.sock:/var/run/docker.sock -v /var/run/libstorage:/var/run/libstorage -v /var/lib/rexray:/var/lib/rexray -v /var/lib/libstorage:/var/lib/libstorage -v /var/run/docker:/var/run/docker -v /dev:/dev rexray-ceph:0.9.1
```

## 应用

```sh
$ docker volume create --driver rexray --name test # 使用默认 pool 创建卷
$ docker volume create --driver rexray --name testpool.test # 非默认 pool（需要先创建好 pool）
$ docker volume ls # 查看卷
$ rexray volume -f error ls # 查看卷
```

使用 docker 命令部署应用
```sh
# 如果卷 nginx_data 不存在的话会被自动创建， 卷默认大小为 16GB
$ docker run -it --name web -p 8000:80 --volume-driver=rexray -v nginx_data:/usr/share/nginx -d nginx:1.11.9-alpine
```

使用 docker 命令部署应用并对卷配额 （aufs、overlay/2均不支持配额，见 ceph-error.md）
```sh
# devicemapper 支持配额，调整卷大小为 20GB
$ docker run -it --name web -p 8000:80 --volume-driver=rexray -v nginx_data:/usr/share/nginx --storage-opt=size=20 -d nginx:1.11.9-alpine
```

使用 marathon 部署应用
```
$ docker volume rm nginx_data
$ curl -XPOST 'http://marathon.mesos:8080/v2/apps' -H 'Content-Type: application/json' -d '{
    "id": "nginx",
    "mem": 32.0,
    "cpus": 0.2,
    "instances": 1,
    "constraints": [["hostname", "LIKE", "192.168.111.199"]],
    "container": {
        "docker": {
            "image": "nginx:1.11.9-alpine",
            "forcePullImage": false,
            "network": "BRIDGE",
            "portMappings": [
                { "containerPort": 80, "hostPort": 0, "servicePort": 10080, "protocol": "tcp" }
            ],
            "parameters": [
                { "key": "volume-driver", "value": "rexray" },
                { "key": "volume", "value": "nginx_data:/data/www" }
            ]
        }
    },
    "healthChecks": [
        { "protocol": "TCP", "portIndex": 0, "path": "/" }
    ]
}'
```

## 相关命令

查看 `本机` docker volume 与 rbd image 的映射关系
```sh
$ rbd showmapped
```

查看 `本机` docker volume 与 rbd image 的挂载情况
```sh
$ df -h
```

查看 rbd image 的监听情况
```sh
$ rbd status docker/cassandra_data_3 # docker 是 ceph pool, cassandra_data_3 是 docker volume
```

卸载挂载点
```sh
$ rexray volume umount hdfs_datanode_3 # 等价于： umount /var/lib/libstorage/volumes/hdfs_datanode_3 加上 rbd unmap docker/hdfs_datanode_3
```

卸载所有 ceph 块设备
```sh
$ umount $(df -h | awk '{print $1}' | grep '/dev/rbd*')
$ df -h
```

卸载挂载点后，卷依然不能用，还需要取消 docker volume 与 rbd image 的映射关系，取消映射关系后将不在被监听
```sh
$ rbd unmap /dev/rbd5 # /dev/rbd5 是 docker/cassandra_data_3 映射的块设备
$ rbd status docker/cassandra_data_3
```

取消所有映射关系
```sh
$ allmap=$(rbd showmapped | awk '{if (NR>1){print $5}}');
$ for m in ${allmap[@]}; do rbd unmap $m; done;
$ rbd showmapped
```

删除所有 rexray 卷
```sh
$ docker volume rm $(docker volume ls | grep rexray | awk '{print $2}')
```

```sh
$ rexray volume rm --force $(docker volume ls | grep rexray | awk '{print $2}')
```

## 性能测试

（略）

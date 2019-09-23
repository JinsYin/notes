# Docker 部署 Ceph

使用容器部署更加便于测试和体验 Ceph 的新功能。

## Latest

```sh
$ ceph -rf /etc/ceph && docker rm -f ceph

# 最新版本
$ docker run -d --name ceph --net=host --restart=always \
  -e MON_IP=192.168.8.220 \
  -e CEPH_PUBLIC_NETWORK=192.168.8.0/24 \
  -e CEPH_DEMO_UID=jjyy \
  -e CEPH_DEMO_ACCESS_KEY=jjyy \
  -e CEPH_DEMO_SECRET_KEY=jjyy \
  -v /etc/ceph:/etc/ceph \
  ceph/daemon:latest demo
```

## Mimic

```sh
$ ceph -rf /etc/ceph && docker rm -f ceph-mimic

# 目前最新版本为 Mimic (13.2.x)
$ docker run -d --name ceph-mimic --net=host --restart=always \
  -e MON_IP=192.168.8.220 \
  -e CEPH_PUBLIC_NETWORK=192.168.8.0/24 \
  -e CEPH_DEMO_UID=jjyy \
  -e CEPH_DEMO_ACCESS_KEY=jjyy \
  -e CEPH_DEMO_SECRET_KEY=jjyy \
  -v /etc/ceph:/etc/ceph \
  ceph/daemon:latest-mimic demo
```

相关进程及服务：

| 进程名       | 端口   | 协议     | 备注                          |
| ------------ | ------ | -------- | ----------------------------- |
| 1 `radosgw`  | 8080   | Swift/S3 | Ceph Rados Gateway (civetweb) |
| 1 `ceph-mgr` | 6800   | HTTP     | Ceph Manager Daemon           |
| 1 `ceph-mon` | 6789   | ~        | Ceph Monitor                  |
| 1 `ceph-mds` | 6805   | ~        | Ceph Metadata Server          |
| 4 `ceph-osd` | 6801 ~ | ~        | Ceph OSD                      |
| 1 `python`   | 5000   | HTTP     | Ceph Nano                     |
| 1 `python`   | 7000   | HTTP     | Ceph Nano                     |

## Luminous

```sh
$ ceph -rf /etc/ceph && docker rm -f ceph-luminous

# Luminous（当前版本：12.2.7）
$ docker run -d --name ceph-luminous --net=host \
  -e MON_IP=192.168.8.220 \
  -e CEPH_PUBLIC_NETWORK=192.168.8.0/24 \
  -e CEPH_DEMO_UID=jjyy \
  -e CEPH_DEMO_ACCESS_KEY=jjyy \
  -e CEPH_DEMO_SECRET_KEY=jjyy \
  -v /etc/ceph:/etc/ceph \
  ceph/daemon:latest-luminous demo

# Luminous（没有 radosgw）
$ docker run -d --name ceph-luminous --net=host --restart=always \
  -e MON_IP=192.168.8.220 \
  -e CEPH_PUBLIC_NETWORK=192.168.8.0/24 \
  -e CEPH_DEMO_UID=jjyy \
  -e CEPH_DEMO_ACCESS_KEY=jjyy \
  -e CEPH_DEMO_SECRET_KEY=jjyy \
  -v /etc/ceph:/etc/ceph \
  ceph/demo:tag-build-master-luminous-centos-7

# Luminous（没有测试成功，版本为 12.0.3）
$ docker run -d --name ceph-luminous --net=host \
  -e MON_IP=192.168.8.220 \
  -e CEPH_PUBLIC_NETWORK=192.168.8.0/24 \
  -e CEPH_DEMO_UID=jjyy \
  -e CEPH_DEMO_ACCESS_KEY=jjyy \
  -e CEPH_DEMO_SECRET_KEY=jjyy \
  -v /etc/ceph:/etc/ceph \
  ceph/daemon:tag-build-master-luminous-centos-7 demo
```

## Jewel

```sh
$ ceph -rf /etc/ceph && docker rm -f ceph-jewel

# Jewel
$ docker run -d --name ceph-jewel --net=host --restart=always \
  -e MON_IP=192.168.8.220 \
  -e CEPH_PUBLIC_NETWORK=192.168.8.0/24 \
  -e CEPH_DEMO_UID=jjyy \
  -e CEPH_DEMO_ACCESS_KEY=jjyy \
  -e CEPH_DEMO_SECRET_KEY=jjyy \
  -v /etc/ceph:/etc/ceph \
  ceph/demo:latest

# 老是崩溃
$ docker run -d --name ceph-jewel --net=host --restart=always \
  -e MON_IP=192.168.8.220 \
  -e CEPH_PUBLIC_NETWORK=192.168.8.0/24 \
  -e CEPH_DEMO_UID=jjyy \
  -e CEPH_DEMO_ACCESS_KEY=jjyy \
  -e CEPH_DEMO_SECRET_KEY=jjyy \
  -v /etc/ceph:/etc/ceph \
  ceph/daemon:latest-jewel demo
```

## 检查（Mimic 为例）

```sh
# docker logs -f ceph-mimic
```

```sh
# 容器中（磁盘剩余空间大于 30%）
$ docker exec -it ceph-mimic ceph -s
cluster:
  id:     d3268f3f-5339-436f-b8c9-534fcd1f549a
  health: HEALTH_OK

services:
  mon:        1 daemons, quorum Yin
  mgr:        Yin(active)
  mds:        cephfs-1/1/1 up  {0=demo=up:active}
  osd:        1 osds: 1 up, 1 in
  rbd-mirror: 1 daemon active
  rgw:        1 daemon active

data:
  pools:   6 pools, 48 pgs
  objects: 214  objects, 4.7 KiB
  usage:   1.0 GiB used, 9.0 GiB / 10 GiB avail
  pgs:     48 active+clean
```

```sh
# 宿主机上（从 luminous 发行版开始必须安装较新的 ceph-common）
$ sudo apt-get install -y ceph-common && sudo ceph -s # ubuntu
$ sudo yum install -y ceph-common && sudo ceph -s     # centos
```

## 监控（Mimic 为例）

```sh
# Ceph manager dashboard
$ google-chrome http://127.0.0.1:7000
```

```sh
# Ceph Nano
$ google-chrome http://127.0.0.1:5000
```

## 参考

* [The new Ceph container demo is super dope!](https://ceph.com/planet/the-new-ceph-container-demo-is-super-dope/)
* [ceph/demo - Docker Hub](https://hub.docker.com/r/ceph/demo/)

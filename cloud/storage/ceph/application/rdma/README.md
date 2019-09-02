# RDMA

## 检查 Ceph 版本是否有 RDMA 支持

```sh
$ strings /usr/bin/ceph-osd | grep -i rdma
```

## 查看 IB/网络设备

```sh
# IB 设备：mlx4_0
# 网络设备：ib0
$ ibdev2netdev
mlx4_0 port 1 ==> ib0 (Up)
```

## rbd 模块不支持 rbd 映射

```md
rbd map -o   image-spec | snap-spec

Maps the specified image to a block device via the rbd kernel module


Only mapping via rbd kernel module is not supported as rbd kernel module doesn’t support RDMA.


As mentioned below mapping via rbd-nbd module should be used.
```

## 配置 Ceph

```sh
$ cat /etc/ceph/ceph.conf
[global]

// for setting frontend and backend to RDMA
ms_type = async+rdma

// for setting backend only to RDMA
ms_cluster_type = async+rdma

//set a device name according to IB or ROCE device used, e.g.
ms_async_rdma_device_name = mlx4_0

// for better performance if using LUMINOUS 12.2.x release
ms_async_rdma_polling_us = 0

//Set local GID for ROCEv2 interface used for CEPH
//The GID corresponding to IPv4 or IPv6 networks
//should be taken from show_gids command output
//This parameter should be uniquely set per OSD server/client
//Not defining this parameter limits the network to RoCEv1
//That means no routing and no congestion control (ECN)
ms_async_rdma_local_gid=0000:0000:0000:0000:0000:ffff:6ea8:0138
```

## 参考

* [Bring Up Ceph RDMA - Developer's Guide](https://community.mellanox.com/docs/DOC-2721)
# RBD

块设备：基于块的存储设备，类似于磁盘。块是一个有序字节，通常一个块的大小为 `512` 字节。

## 附加方式

* Kernel 内置的 RBD 模块（简称 KRBD）
* QUME 模拟器调用 LIBRBD 库

### KRBD

```bash
# 查询 RBD 模块是否已经加载
$ lsmod | grep rbd

# 若无，需手动加载
$ modprobe rbd

# 查看 RBD 模块信息
$ modinfo rbd
filename:       /lib/modules/4.4.0-121-generic/kernel/drivers/block/rbd.ko
license:        GPL
description:    RADOS Block Device (RBD) driver
author:         Jeff Garzik <jeff@garzik.org>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
author:         Alex Elder <elder@inktank.com>
srcversion:     607EECF6F299D1D6ECEB269
depends:        libceph
intree:         Y
vermagic:       4.4.0-121-generic SMP mod_unload modversions retpoline 
parm:           single_major:Use a single major number for all rbd devices (default: false) (bool)
```

```bash
# 创建一个 10GB 的块设备（Ceph 中叫做 ”镜像“）
$ rbd create image_01 --size 10240 # 默认的 "rbd" Pool
$ rbd create kube/image_02 --size 10240
$ rbd create image_02 --size 10240 -p kube

# 查看块设备
$ rbd ls # rbd list
$ rbd ls kube
$ rbd ls -p kube

$ rbd info image_01 # 默认的 "rbd" pool
$ rbd info rbd/image_01
$ rbd info image_01 -p rbd
```

映射到客户端操作系统：

```bash
$ rbd map image_01

# 查看映射的块设备
$ rbd showmapped

$ ls /dev/rbd*

# 取消映射
$ rbd unmap /dev/rbd0
```
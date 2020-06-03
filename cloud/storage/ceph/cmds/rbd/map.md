# rbd map | rbd showmapped | rbd unmap

（用作 rbd 客户端）

## rbd map

`rbd map` 命令将块设备镜像映射到内核模块，并且会自动加载 `rbd` 内核模块（如果尚未加载的话）。

```sh
sudo rbd map {pool-name}/{image-name} --id {user-name} # /etc/ceph/client.{user-name}.keyring
```

```sh
# 要求使用 cephx 创建相应的认证文件
$ sudo rbd map rbd/myimage --id admin --keyring /path/to/keyring
$ sudo rbd map rbd/myimage --id admin --keyfile /path/to/file
```

## rbd showmapped

显示本机映射的块设备镜像。

## rbd unmap

取消块设备镜像映射。

## 示例

```sh
$ sudo rbd map rbdpool/nbd --id admin # /etc/ceph/client.admin.keyring
```

```sh
$ rbd showmapped
id pool    image snap device
0  rbdpool nbd   -    /dev/rbd0
```

```sh
$ tree /dev/rbd*
/dev/rbd0
/dev/rbd
└── rbdpool
    └── nbd -> ../../rbd0
```

```sh
$ rbd unmap /dev/rbd/rbdpool/nbd
```

```sh
$ lsmod | grep rbd
rbd                    83728  1
libceph               301687  1 rbd
```

```sh
$ modinfo rbd
filename:       /lib/modules/3.10.0-862.el7.x86_64/kernel/drivers/block/rbd.ko.xz
license:        GPL
description:    RADOS Block Device (RBD) driver
author:         Jeff Garzik <jeff@garzik.org>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
author:         Alex Elder <elder@inktank.com>
retpoline:      Y
rhelversion:    7.5
srcversion:     3486A669C909DC30C49A49C
depends:        libceph
intree:         Y
vermagic:       3.10.0-862.el7.x86_64 SMP mod_unload modversions
signer:         CentOS Linux kernel signing key
sig_key:        3A:F3:CE:8A:74:69:6E:F1:BD:0F:37:E5:52:62:7B:71:09:E3:2B:96
sig_hashalgo:   sha256
parm:           single_major:Use a single major number for all rbd devices (default: false) (bool)
```

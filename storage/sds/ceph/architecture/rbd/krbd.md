# RBD Kernel Module

## 加载 rbd 模块

使用 rbd 命令可以映射一个镜像为内核模块。映射前需要先加载 rbd 内核模块。

```bash
# 加载
$ modprobe rbd

# 校验
$ lsmod | grep rbd
Module                  Size  Used by
rbd                    83889  0
libceph               282661  1 rbd
```

## 映射块设备

```bash
# rbd map {pool-name}/{image-name} --id {user-name} --keyring {/path/to/keyring}
$ rbd map rbd/foo --id admin --keyring /etc/ceph/ceph.client.admin.keyring
/dev/rbd0
```

```bash
# 如果映射错误，查看错误日志
$ dmesg | tail # 或 journalctl -f
rbd: image foo: image uses unsupported features: 0x38

$ rbd info rbd/foo
rbd image 'foo':
    size 1024 MB in 256 objects
    order 22 (4096 kB objects)
    block_name_prefix: rbd_data.10176b8b4567
    format: 2
    features: layering, exclusive-lock, object-map, fast-diff, deep-flatten
    flags:

# 如果出现如上问题，有两种解决办法
# 1. 重新创建镜像
$ rbd create --size 1024 rbd/foo --image-feature layering
# 2. 创建镜像修改配置文件
$ vi /etc/ceph/ceph.conf
rbd default features = 3

# features 变了
$ rbd info rbd/foo
rbd image 'foo':
    size 1024 MB in 256 objects
    order 22 (4096 kB objects)
    block_name_prefix: rbd_data.10276b8b4567
    format: 2
    features: layering
    flags:
```

> 客户端需要两个文件：/etc/ceph/ceph.conf 和 /etc/ceph/ceph.client.admin.keyring

## 查看已映射的块设备

```bash
$ rbd showmapped
id pool image snap device
0  rbd  foo   -    /dev/rbd0
```

```bash
$ ls /dev/rbd0
/dev/rbd0

$ ls /dev/rbd/rbd/foo
/dev/rbd/rbd/foo
```

## 取消块设备映射

```bash
# rbd unmap /dev/rbd/{poolname}/{imagename}
$ rbd unmap /dev/rbd/rbd/foo
$ rbd unamp /dev/rbd0
```

## 参考

* [KERNEL MODULE OPERATIONS](http://docs.ceph.com/docs/master/rbd/rbd-ko/)
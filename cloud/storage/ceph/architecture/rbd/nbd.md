# rbd-nbd

rbd-nbd 是个 RADOS 块设备镜像的客户端，与 rbd 内核模块相似。它把 rbd 镜像映射为 nbd（Network Block Device），可以像本地设备一样使用。

## 对比 RBD

与 RBD 内核模块相比，NBD 有许多优点：

* RBD-KO 开发和特性的添加必须要经过稳定的内核
* RBD-KO 开发慢于 librbd，如果要与 librbd 开发保持同步，需要时间和努力
* NBD 已经很好地集成到内核多年，是大多数现今的内核的一部分

## 安装

```sh
# Debian/Ubuntu
$ apt-get install rbd-nbd=12.2.6* nbd
```

```sh
# RHEL/CentOS
$ yum install -y nbd rbd-nbd-12.2.6* nbd
```

## 加载内核模块

* Debian/Ubuntu

基于 Debian 的系统，在执行映射等操作时 NBD 内核模块会自动被加载。

```sh
# 手动加载
$ modprobe nbd

# 检查
$ lsmod | grep nbd
nbd         20480  1
```

* RHEL/CentOS

CentOS 系统目前还没有将 NBD 模块集成到内核中，所以手动编译。具体做法：1.先编译新 Kernel（版本与系统 Kernel 相同）并集成 NBD 模块；2.再将 NBD 模块拷贝到系统 Kernel。

```sh
$ modprobe nbd
modprobe: FATAL: Module nbd not found.
```

安装 rpmbuild 及相关依赖：

```sh
$ yum install -y rpm-build
$ yum install -y m4 net-tools bc xmlto asciidoc hmaccalc newt-devel perl pesign elfutils-devel binutils-devel bison audit-libs-devel numactl-devel pciutils-devel ncurses-devel libtiff perl-ExtUtils-Embed java-devel python-devel gcc
```

```sh
$ useradd builder
$ groupadd builder

$ su builder && cd /home/builder

$ wget http://vault.centos.org/7.4.1708/updates/Source/SPackages/kernel-3.10.0-693.21.1.el7.src.rpm
$ rpm -ivh kernel-3.10.0-693.21.1.el7.src.rpm
```

```sh
# Build Preparation
mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros
cd ~/rpmbuild/SPECS
rpmbuild -bp --target=$(uname -m) kernel.spec
```

编译：

```sh
cd ~/rpmbuild/BUILD/kernel-3.10.0-693.21.1.el7/linux-3.10.0-693.21.1.el7.x86_64/
make menuconfig
```

```sh
make prepare && make modules_prepare && make
make M=drivers/block -j8
modinfo drivers/block/nbd.ko
cp drivers/block/nbd.ko /lib/modules/3.10.0-693.21.1.el7.x86_64/extra/
depmod -a && sudo modprobe nbd
```

> <https://stackoverflow.com/questions/45419526/how-to-load-network-block-device-on-centos7>

## 创建块设备

创建块设备依然需要使用 `rbd` 命令：

```sh
# rbd create {pool-name}/{image-name}
$ rbd create rbd/foo
```

## 映射块设备

映射 RBD 镜像为网络块设备：

```sh
$ rbd-nbd map rbd/foo
2018-08-10 09:30:25.060131 7f3bc78adc40 -1 asok(0x562605b528a0) AdminSocketConfigObs::init: failed: AdminSocket::bind_and_listen: failed to bind the UNIX domain socket to '/var/run/ceph/ceph-client.admin.asok': (17) File exists
/dev/nbd0
```

## 罗列网络块设备

```sh
$ rbd-nbd list-mapped
pid    pool image snap device
479826 rbd  foo   -    /dev/nbd0
```

## 取消映射

```sh
$ rbd-nbd unmap /dev/nbd0
```

## 测试

检查 NBD 设备是否已连接的一种办法是检查其大小：

```sh
# 如果未连接，则显示 0
$ blockdev --getsize64 /dev/nbd0
1073741824
```

## 注意

如果执行 `rbd-nbd` 操作过程中，出现如下问题：

解决办法：

```sh
$ vi /etc/ceph/ceph.conf
[client]
    log file = /var/log/ceph/ceph-$name.log
    admin socket = /var/run/ceph/ceph-$name.$pid.asok
```

> <https://github.com/ceph/ceph/pull/12433>

## 参考

* [Connect to a remote block device using NBD](http://www.microhowto.info/howto/connect_to_a_remote_block_device_using_nbd.html)
* [ceph rbd：nbd 原理](https://www.jianshu.com/p/bb9d14bd897c)

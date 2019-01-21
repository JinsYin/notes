# CephFS

## MDS

```bash
$ ceph mds stat
e8: cephfs-1/1/1 up fs1-0/0/1 up {[cephfs:0]=0=up:active}
```

## CephFS 文件系统

### 查询文件系统

```bash
$ ceph fs ls
name: cephfs, metadata pool: cephfs_metadata, data pools: [cephfs_data ]
```

```bash
$ ceph fs get cephfs
Filesystem 'cephfs' (1)
fs_name cephfs
epoch   5
flags   8
created 2018-07-10 08:17:14.430971
modified    2018-07-10 08:17:14.430971
tableserver 0
root    0
session_timeout 60
session_autoclose   300
max_file_size   1099511627776
last_failure    0
last_failure_osd_epoch  0
compat  compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object,5=mds uses versioned encoding,6=dirfrag is stored in omap,8=file layout v2}
max_mds 1
in  0
up  {0=4106}
failed
damaged
stopped
data_pools  1
metadata_pool   2
inline_data disabled
balancer
standby_count_wanted    0
4106:   192.168.8.220:6804/3351369903 '0' mds.0.4 up:active seq 3
```

### 创建文件系统

MDS 需要使用两个 Pool，一个用来存储数据，一个用来存储元数据。Luminous 发行版自动创建了两个 Pool：`cephfs_data`、`cephfs_data`。目前，创建多个文件系统还是实验阶段。

```bash
# 创建 Pool
$ ceph osd pool create <meatadata_pool_name> <pg_num>
$ ceph osd pool create <data_pool_name> <pg_num>
```

```bash
# 允许创建多个文件系统
$ ceph fs flag set enable_multiple true --yes-i-really-mean-it

# 创建一个文件系统
$ ceph fs new <fs_name> <meatadata_pool_name> <data_pool_name>
new fs with metadata pool 11 and data pool 10
```

### 删除文件系统

```bash
$ ceph fs rm
```

### 挂载文件系统

Linux 中挂载 Ceph FS 有两种方式：`Kernel Module` 和 `FUSE`（Filesystem in Userspace）。

#### Kernel 内核模块方式

要求 Linux 安装 `ceph` 或 `ceph-common` 软件包。

```bash
$ mkdir -p /tmp/mycephfs

# 客户端不需要认证时
$ mount -t ceph 192.168.8.220:6789:/ /tmp/mycephfs

# 客户端认证，需要提供 admin 和认证私钥
$ mount -t ceph -o name=admin,secret=NA7IWV1AL5R7MNCMEZKP 192.168.8.220:6789:/ /tmp/mycephfs

$ df -h | grep ceph
```

```bash
# 开机自动挂载
$ vi /etc/fstab
192.168.8.220:6789:/ /tmp/mycephfs ceph noatime 0 2
```

#### FUSE 方式

要求 Linux 安装 `ceph-fuse` 软件包。

```bash
# CentOS
$ yum install ceph-fuse

# Ubuntu
$ apt-get install ceph-fuse
```

```bash
% mkdir -p /tmp/ceph_fuse
% ceph-fuse -m 192.168.8.220:6789:/ /tmp/ceph_fuse
```

```bash
# 开机自动挂载
$ vi /etc/fstab
id=admin,conf=/etc/ceph/ceph.conf/tmp/ceph_fuse fuse.ceph defaults 0 0
```

## NFS & Samba

* [The CephFS Gateways - Samba and NFS-Ganesha](https://fosdem.org/2018/schedule/event/cephfs_gateways/attachments/slides/2636/export/events/attachments/cephfs_gateways/slides/2636/cephfs_samba_and_nfs.pdf)
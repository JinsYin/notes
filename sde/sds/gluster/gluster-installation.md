# GlusterFS 安装部署

## 系统环境

* CentOS 7.3
* Kernel 3.10.0-327.22.2.el7.x86_64
* GlusterFS 3.12.6

* 节点分配

| ip            | hostname   | 用途   | disk     | 组件                        |
| 192.168.1.221 | gluster1   | 存储   | /dev/sdb | glusterfs glusterfs-server |
| 192.168.1.222 | gluster2   | 存储   | /dev/sdb | glusterfs glusterfs-server |
| 192.168.1.223 | gluster3   | 存储   | /dev/sdb | glusterfs glusterfs-server |
| 192.168.1.224 | gclient    | 客户端  | 无       | glusterfs glusterfs-fuse   |

* 组件描述

| 组件              | 端口   |
| glusterfs        |       |
| glusterfs-server | 24007 |
| glusterfs-fuse   |       |
| glusterfs-rdma   |       |


## 安装准备（所有节点）

* 关闭防火墙

`glusterd` 守护进程默认监听 tcp/24007 端口，但在 gluster 节点上还不止开放该端口，因为每增加一个 brick 就会新开一个端口（用 `gluster volume status` 命令查看）。

```bash
$ systemctl stop firewalld
$ systemctl disable firewalld
```

* 关闭 selinux

```bash
# 临时
$ setenforce 1

# 永久（重启生效）
$ sed -i 's|SELINUX=enforcing|SELINUX=disabled|g' /etc/selinux/config
```

* 修改主机名

```bash
$ hostnamectl --static set-hostname <hostname>
```

* 配置 DNS 或 hosts

如果使用 hostname 加入 Gluster 节点到集群，必须确保所有节点都可以解析 hostname，`包括客户端节点`。另外，也可以直接使用 IP 地址加入节点到集群。

```bash
$ vi /etc/hosts
192.168.1.221 gluster1
192.168.1.222 gluster2
192.168.1.223 gluster3
```


## 安装 GlusterFS

### 添加安装源

```bash
# 添加 EPEL 源
$ yum install -y epel-release

# 添加 GlusterFS 源（312 是大版本，因为我们要安装的 GlusterFS 的版本为 3.12.6）
$ yum install -y centos-release-gluster312
```

### 安装组件

* server

```bash
# 查看组件版本
$ yum list glusterfs --show-duplicates

# 安装指定版本
$ gversion=3.12.6

# 依赖 glusterfs glusterfs-api glusterfs-fuse
$ yum install -y glusterfs-server-${gversion}*

# 检查安装的软件包
$ rpm -qa | grep glusterfs
centos-release-gluster312-1.0-1.el7.centos.noarch
glusterfs-client-xlators-3.12.6-1.el7.x86_64
glusterfs-server-3.12.6-1.el7.x86_64
glusterfs-cli-3.12.6-1.el7.x86_64
glusterfs-3.12.6-1.el7.x86_64
glusterfs-fuse-3.12.6-1.el7.x86_64
glusterfs-libs-3.12.6-1.el7.x86_64
glusterfs-api-3.12.6-1.el7.x86_64
```

* client

客户端需要安装 `glusterfs-fuse` 等软件包以支持 GlusterFS 文件系统的挂载。

```bash
# 安装指定版本
$ gversion=3.12.6

# 依赖 glusterfs
$ yum install -y glusterfs-fuse-${gversion}* glusterfs-rdma-${version}

# 检查安装的软件包
$ rpm -qa | grep gluster
centos-release-gluster312-1.0-1.el7.centos.noarch
glusterfs-libs-3.12.6-1.el7.x86_64
glusterfs-client-xlators-3.12.6-1.el7.x86_64
glusterfs-3.12.6-1.el7.x86_64
glusterfs-fuse-3.12.6-1.el7.x86_64
```


## 运行服务

```bash
# 启动 glusterfs server
$ systemctl start glusterd
$ systemctl enable glusterd

# 查看状态
$ systemctl status -l glusterd

# 查看端口
$ netstat -tpln | grep glusterd
tcp    0    0    0.0.0.0:24007    0.0.0.0:*    LISTEN    9448/glusterd

# 排查日志
$ journalctl -f -u glusterd
```


## 集群管理

### 磁盘准备（gluster 节点）

如果是实验环境且没有额外的存储盘，可以跳过此步骤，通过创建本地目录（`mkdir -p /data/gluster`）来代替。如果是生产环境，最好先对磁盘组建 RAID 。

```bash
# 创建主分区
$ fdisk /dev/sdb
n => p => 1 => Enter => Enter => Enter => p => w

# 格式化分区
$ mkfs.ext4 /dev/sdb1

# 如果格式化为 xfs，需要先安装 xfsprogs
$ yum install -y xfsprogs

# 挂载磁盘
$ mkdir -p /data/gluster
$ mount /dev/sdb1 /data/gluster

# 开机自动挂载
$ echo "/dev/sdb1 /data/gluster ext4 defaults 0 0" | tee --append /etc/fstab
```

### 创建存储池

* 加入集群（gluster1 节点）

在 Gluster 集群中的任一节点上依次加入其他节点，它会自动在其他节点上连接 peer 节点。

```bash
$ gluster peer probe gluster2
$ gluster peer probe gluster3
```

* 查看集群状态（gluster1 节点）

```bash
$ gluster peer status
Number of Peers: 2

Hostname: gluster2
Uuid: a2b01b4e-87a9-4f9a-9ed6-3fe271b2f5bd
State: Peer in Cluster (Connected)

Hostname: gluster3
Uuid: d986ae16-ba82-40ad-9bf3-51a88d5be6ce
State: Peer in Cluster (Connected)
```

* 查看存储池（gluster1 节点）

```bash
$ gluster pool list
UUID                                  Hostname   State
a2b01b4e-87a9-4f9a-9ed6-3fe271b2f5bd  gluster2   Connected
d986ae16-ba82-40ad-9bf3-51a88d5be6ce  gluster3   Connected
7fefc5c9-c80d-4101-9be1-afa80b435142  localhost  Connected
```

* 踢出集群（可选）

```bash
$ gluster peer detach gluster3
```


## Volume 管理

* 创建 brick（gluster2 & gluster3）

在两个节点上创建 brick（目录）。如果没有手动创建，它会自动创建。

```bash
$ mkdir -p /data/gluster/gv0
```

* 创建 volume（任一节点）

```bash
# ２ 个副本容易脑裂，使用 force 跳过
$ gluster volume create gv0 replica 2 gluster2:/data/gluster/gv0 gluster3:/data/gluster/gv0 force
volume create: gv0: success: please start the volume to access data
```

存储目录 /data/gluster 必须事先创建好，brick（/data/gluster/gv0）会自动创建。

* 启动 volume（任一节点）

为了访问数据需要先启动 volume。如果启动失败，可以查看 /var/log/glusterfs 目录下的日志文件。

```bash
$ gluster volume start gv0
```

* 查看 volume 信息

```bash
$ gluster volume info gv0
Volume Name: gv0
Type: Replicate
Volume ID: f15af55c-6823-4368-9e50-23d56af4b656
Status: Started
Snapshot Count: 0
Number of Bricks: 1 x 2 = 2
Transport-type: tcp
Bricks:
Brick1: gluster2:/data/gluster/gv0
Brick2: gluster3:/data/gluster/gv0
Options Reconfigured:
transport.address-family: inet
nfs.disable: on
performance.client-io-threads: off
```

* 查看 volume 状态

```bash
$ gluster volume status
Status of volume: gv0
Gluster process                             TCP Port  RDMA Port  Online  Pid
------------------------------------------------------------------------------
Brick gluster2:/data/gluster/gv0            49152     0          Y       28251
Brick gluster3:/data/gluster/gv0            49152     0          Y       16185
Self-heal Daemon on localhost               N/A       N/A        Y       27145
Self-heal Daemon on gluster3                N/A       N/A        Y       16206
Self-heal Daemon on gluster2                N/A       N/A        Y       28272

Task Status of Volume gv0
------------------------------------------------------------------------------
There are no active volume tasks
```


## 性能调优

```bash
# 开启指定 volume 的配额
$ gluster volume quota gv0 enable

# 限制 volume 根目录的最大可用空间
$ gluster volume quota gv0 limit-usage / 80

# 设置缓存 4 GB
$ gluster volume set gv0 performance.cache-size 4GB

# 开启异步，后台操作
$ gluster volume set gv0 performance.flush-behind on

# 设置 io 线程 32
$ gluster volume set gv0 performance.io-thread-count 32

# 设置回写（写数据时间，先写缓存内，在写入磁盘）
$ gluster volume set gv0 performance.write-behind on
```


安装 GlusterFS 客户端并 mount GlusterFS 文件系统（客户端必须加入 gluster fs hosts 否则会报错）

```bash
$ yum install -y glusterfs glusterfs-fuse

$ mkdir -p /mnt/gluster
$ mount -t glusterfs gluster1:/gv0 /mnt/gluster

# 查看挂载情况
$ df -h /mnt/gluster
Filesystem      Size  Used Avail Use% Mounted on
gluster1:/models   42G   15G   28G  34% /mnt/gluster

# 测试挂载路径
$ cd /mnt/gluster
$ for i in `seq -w 10`; do mkdir $i; done

# 测试存储路径
$ ll /data/gluster
```


## GlusterFS 客户端

* 客户端挂载

```bash
# 挂载 GlusterFS 文件系统
$ mkdir -p /mnt/gluster/gv0
$ mount -t glusterfs gluster3:/gv0 /mnt/gluster/gv0 # 可以使用 IP 地址

# 查看挂载容量
$ df -h | grep /mnt/gluster/gv0
gluster3:/gv0    42G    19G    24G    44%    /mnt/gluster/gv0

# 查看挂载详情
$ cat /proc/mounts | grep /mnt/gluster/gv0
gluster3:/gv0 /mnt/gluster/gv0 fuse.glusterfs rw,relatime,user_id=0,group_id=0,default_permissions,allow_other,max_read=131072 0 0

# 自动挂载
$ echo "gluster3:/gv0 /mnt/gluster/gv0 glusterfs defaults,_netdev 0 0" | tee --append /etc/fstab
$ mount -a # 生效

# 手动卸载
$ umount -t glusterfs gluster3:/gv0
```


## 测试

```bash
[root@gclient ~]# for i in `seq -w 1 3`; do cp -rp /var/log/messages /mnt/gluster/messages-$i; done

[root@gclient ~]# ll /mnt/gluster
-rw------- 1 root root 2094147866 2月  28 13:56 messages-1
-rw------- 1 root root 2094149601 2月  28 13:57 messages-2
-rw------- 1 root root 2094152922 2月  28 13:57 messages-3

[root@gluster2 ~]# ll /data/gluster/gv0
-rw------- 2 root root 2094147866 2月  28 13:56 messages-1
-rw------- 2 root root 2094149601 2月  28 13:57 messages-2
-rw------- 2 root root 2094152922 2月  28 13:57 messages-3

[root@gluster3 ~]# ll /data/gluster/gv0
-rw------- 2 root root 2094147866 2月  28 13:56 messages-1
-rw------- 2 root root 2094149601 2月  28 13:57 messages-2
-rw------- 2 root root 2094152922 2月  28 13:57 messages-3
```


## 其他

* 日志

```bash
$ tail -f /var/log/glusterfs/glusterd.log

$ tail -f /var/log/glusterfs/glustershd.log
```


## 参考

* [Install and Configure GlusterFS on CentOS 7 / RHEL 7](https://www.itzgeek.com/how-tos/linux/centos-how-tos/install-and-configure-glusterfs-on-centos-7-rhel-7.html)
* [Gluster Quickstart](https://wiki.centos.org/SpecialInterestGroup/Storage/gluster-Quickstart)
* [Installing GlusterFS - a Quick Start Guide](http://docs.gluster.org/en/latest/Quick-Start-Guide/Quickstart)
* [分布式存储之 GlusterFS](https://www.liuliya.com/archive/733.html)
* [CentOS 7 安装 GlusterFS](http://www.cnblogs.com/jicki/p/5801712.html)
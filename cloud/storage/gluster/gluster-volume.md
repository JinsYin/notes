# GlusterFS Volume

## 卷类型

| 模式 | 解释 | 描述 |
| DHT |

* 分布式卷（默认模式），利用 hash 算法将文件随机存储到某一个节点。缺点是没有冗余，极易导致数据丢失。
* 复制卷，即 AFR，创建 volume 时指定 replica x 数量：将文件复制到 replicas x 个节点中（类似 RAID 1）
* 条带卷，即 Striped，创建 volume 时指定 stripe x 数量：将文件切割成数据库，分布存储到 stripe x 个节点中（类似 RAID 0）
* 分布式复制卷（DHT 和 AFR 的组合），最少需要 4 台服务器才能创建。创建 volume 时 replica 2 server = 4 个节点。
* 分布式条带卷（DHT 和 Striped 的组合），最少需要 4 台服务器才能创建。创建 volume 时 stripe 2 server = 4 个节点。
* 条带复制卷（Stripe 与 AFR 的组合），最少需要 4 个节点才能创建。创建 volume 是 stripe 2 replica 2 server = 4 个节点
* 三种模式混合。至少需要 8 个节点。stripe 2 replica 2，每 4 个节点组成一组。

```sh
# 分布式卷
$ gluster volume create gv1 gluster1:/data/gluster/gv1 gluster2:/data/gluster/gv1 gluster3:/data/gluster/gv1 force

# 复制卷
$ gluster volume create test-volume replica 2 transport tcp server1:/exp1 server2:/exp2

# 条带卷
$ gluster volume create test-volume stripe 2 transport tcp server1:/exp1 server2:/exp2

# 分布式复制卷
$ gluster volume create test-volume replica 2 server1:/exp1 server2:/exp2 server3:/exp3 server4:/exp4

# 分布式条带卷
$ gluster volume create test-volume stripe 2 transport tcp server1:/exp1 server2:/exp2 server3:/exp3 server4:/exp4

# 条带复制卷
$ gluster volume create test-volume stripe 2 replica 2 transport tcp server1:/exp1 server2:/exp2 server3:/exp3 server4:/exp4

# 三种模式混合
$ gluster volume create test-volume stripe 2 replica 2 transport tcp server1:/exp1 server2:/exp2 server3:/exp3 server4:/exp4 server5:/exp5 server6:/exp6 server7:/exp7 server8:/exp8
```


## Volume 管理

* 基本操作

```sh
# 创建 volume
$ gluster volume create gv0 replica 2 gluster2:/data/gluster/gv0 gluster3:/data/gluster/gv0

# 启动 volume
$ gluster volume start gv0

# 删除 volume
$ gluster volume stop gv0 && gluster volume delete gv0
```

* 卷的状态

```sh
$ gluster volume status gv0
Status of volume: gv0
Gluster process                             TCP Port  RDMA Port  Online  Pid
------------------------------------------------------------------------------
Brick gluster2:/data/gluster/gv0            49152     0          Y       28251
Brick gluster3:/data/gluster/gv0            49152     0          Y       16185
Self-heal Daemon on localhost               N/A       N/A        Y       16206
Self-heal Daemon on gluster1                N/A       N/A        Y       27145
Self-heal Daemon on gluster2                N/A       N/A        Y       28272

Task Status of Volume gv0
------------------------------------------------------------------------------
There are no active volume tasks
```

* heal（修复）

```sh
# 启动完全修复
$ gluster volume heal gv0 full
Launching heal operation to perform full self heal on volume gv0 has been successful
Use heal info commands to check status.

# 查看需要修复的文件
$ gluster volume heal gv0 info
Brick gluster2:/data/gluster/gv0
Status: Connected
Number of entries: 0

Brick gluster3:/data/gluster/gv0
Status: Connected
Number of entries: 0

# 查看修复成功的文件
$ gluster volume heal gv0 info split-brain
Brick gluster2:/data/gluster/gv0
Status: Connected
Number of entries in split-brain: 0

Brick gluster3:/data/gluster/gv0
Status: Connected
Number of entries in split-brain: 0
```

* quota

Quota 功能主要是对挂载点下的某个目录进行容量限制，如 `/mnt/gluster/gdir`，而不是对卷的容量进行限制。

```sh
# 激活 quota 功能
$ gluster volume quota gv0 enable
volume quota : success

# 关闭 quota 功能
$ gluster volume quota gv0 disable
Disabling quota will delete all the quota configuration. Do you want to continue? (y/n) y
volume quota : success

# 目录限制
$ gluster volume quota gv0 limit-usage /gdir 10MB
volume quota : success

# quota 信息列表
$ gluster volume quota gv0 list [/gdir]
Path    Hard-limit    Soft-limit    Used    Available    Soft-limit exceeded?    Hard-limit exceeded?
-----------------------------------------------------------------------------------------------------
/gdir   10.0MB        80%(8.0MB)    0Bytes  10.0MB       No                      No

# 移除目录限制
$ gluster volume quota gv0 remove /gdir
volume quota : success
```

* brick

```sh
# 移除 brick
$ gluster volume remove-brick gv0 replica 2 gluster3:/data/gluster/gv0 force
```


## NFS & Samba

* nfs

```sh
# 开放 nfs
$ gluster volume set gv0 nfs.disable off
Gluster NFS is being deprecated in favor of NFS-Ganesha Enter "yes" to continue using Gluster NFS (y/n) y
volume set: success
```

* samba

http://www.mamicode.com/info-detail-1925105.html

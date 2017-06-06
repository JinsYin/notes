# Ceph 集群部署

在所有 osd 节点上准备号磁盘。

## 磁盘准备

```bash
# 格式化磁盘格式为 xfs
$ mkfs.xfs -f /dev/sdb
$ mkfs.xfs -f /dev/sdc
```

```bash
# 挂载
$ mkdir -p /ceph/osd && mkdir -p /ceph/journal
$ mount /dev/sdb /ceph/osd # sdb 作 ceph 数据盘
$ mount /dev/sdc /ceph/journal # sdc 作 ceph 日志盘（强烈建议使用 SSD）
$ chown ceph:ceph -R /ceph/osd # 见 ceph-error.md
$ chown ceph:ceph -R /ceph/journal # 见 ceph-error.md
```

```bash
# 开机自动挂载
# 第一个数字表示 dump 选项：0 不备份，1 备份，2 备份（比 1 重要性小）
# 第二个数字表示是否在启东市用 fsck 校验分区：０ 不校验，１ 校验，２ 校验（比 １ 晚校验）
$ cat /etc/fstab | grep 'osd'
/dev/sdb　/ceph/osd xfs　defaults　0 0
/dev/sdc　/ceph/journal xfs　defaults　0 0
```

```bash
# 查看挂载信息
$ mount -l
$ lsblk
```

## 创建集群

除特别说明外，以下操作均在 ceph-admin 节点上进行。

```bash
# 创建工作目录
$ mkdir /ceph-cluster && cd /ceph-cluster
```

```bash
# 【如果出错可以清除配置、卸载 ceph，重头再来】
$ ceph-deploy purge {ceph-node} [{ceph-node}]
$ ceph-deploy purgedata {ceph-node} [{ceph-node}]
$ ceph-deploy forgetkeys
```

```bash
# 创建一个新集群
$ ceph-deploy new {initial-monitor-node(s)}
```

```bash
# 修改配置 ceph.conf（默认值参考: http://docs.ceph.com/docs/master/rados/configuration/pool-pg-config-ref/）
$ cat ceph.conf
[global]
...
osd pool default size = 2   # 副本数，默认３
osd pool default min size = 1
osd pool default pg num = 8
osd pool default pgp num = 8
public network = 192.168.111.0/24   # 用于客户端读写数据
cluster network = 10.0.0.0/24   # 可选，用于 osd 节点之间同步数据和发送心跳包
```

```ceph
# 安装 ceph （ceph-base，ceph-common，ceph-mds，ceph-mon，ceph-osd，ceph-selinux）
$ ceph-deploy install {all-nodes} # 为所使用 ceph 块存储，所有 docker 节点都一个安装 ceph 
```

```bash
#　配置初始 monitor(s)，并收集所有密钥
$ ceph-deploy mon create-initial
$ ls -alh # 完成上述操作后，当前目录会出现以下密钥环
{cluster-name}.client.admin.keyring
{cluster-name}.bootstrap-osd.keyring
{cluster-name}.bootstrap-mds.keyring
{cluster-name}.bootstrap-rgw.keyring
```

```bash
# 在所有 ceph-mon 节点上校验进程是否启动（6789）
$ netstat -tpln | grep ceph-mon
```

```bash
# 检查 mon 状态 
$ ceph mon stat
$ ceph mon dump
$ ceph mon_status -f json-pretty
$ ceph quorum_status -f json-pretty 
```

```bash
# 启动 ceph osd （ceph-deploy osd create 表示准备并激活）
$ ceph-deploy osd prepare {ceph-node}:/ceph/osd:/ceph/journal # 准备 osd
$ ceph-deploy osd activate centos192:/ceph/osd:/ceph/journal # 激活 osd
```

```bash
# 在各 ceph osd 节点检查服务是否启动
$ netstat -tpln | grep 'ceph-osd'
$ ceph osd tree # osd 结构
$ ceph osd dump
$ ceph osd stat
```

```bash
# 添加管理节点 （用 ceph-deploy 把配置文件和 admin 密钥拷贝到各节点，这样执行 ceph 命令时就无需指定 monitor 地址和 ceph.client.admin.keyring 了）
# 为了使用 ceph 快存储，所有 docker 都需要设置为管理节点
$ ceph-deploy admin {nodes}
```

```bash
# 各节点都需要确保对 ceph.client.admin.keyring 有正确的操作权限
$ chmod +r /etc/ceph/ceph.client.admin.keyring
```

```bash
# 集群校验 （http://docs.ceph.org.cn/rados/operations/monitoring/）
$ ceph health
$ ceph status # ceph -s
$ ceph -w # 实时观察
$ ceph df # 集群使用情况（容量、存储池等）
```


## 集群扩容（可选）

除特别说明外，以下操作均在 ceph-deploy 节点上进行。
  
添加 osd
```bash
$ cd /ceph-cluster
$ ceph-deploy osd prepare {ceph-node}:/ceph/osd:/ceph/journal # 准备 osd
$ ceph-deploy osd activate {ceph-node}:/ceph/osd:/ceph/journal # 激活 osd
```

```bash
# 新增 osd 后， ceph 集群会重新均衡，把归置组迁移到新的 osd 
$ ceph -w
```

添加元数据服务器
```bash
# 至少需要一个元数据服务器才能使用 CephFS
$ ceph-deploy mds create {ceph-node(s)}
```

>Note: 当前生产环境下的 Ceph 只能运行一个元数据服务器。你可以配置多个，但现在我们还不会为多个元数据服务器的集群提供商业支持。

添加 rgw 例程
```
# 要使用 ceph 的对象网关组件，必须部署 RGW 例程 （默认监听 7480 端口）
$ ceph-deploy rgw create {ceph-node}
```

添加 monitors
```bash
#　monitor 应该是奇数个 （删除用ceph-deploy mon remove）
$ ceph-deploy mon add centos191 # 添加
$ ceph quorum_status -f json-pretty
```

## 存入/检出对象数据





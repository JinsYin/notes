# Ceph 集群部署

在所有 osd 节点上准备号磁盘。

## 磁盘准备

```sh
# 格式化磁盘格式为 xfs
$ mkfs.xfs -f /dev/sdb
$ mkfs.xfs -f /dev/sdc
```

```sh
# 挂载
$ mkdir -p /ceph/osd && mkdir -p /ceph/journal
$ mount /dev/sdb /ceph/osd # sdb 作 ceph 数据盘
$ mount /dev/sdc /ceph/journal # sdc 作 ceph 日志盘（强烈建议使用 SSD）
$
$ # 设置所有者（默认 ceph 用户是不存在的，但安装好 ceph 的节点会自动添加一个 ceph 用户，所以这里有点悖论）
$ chown ceph:ceph -R /ceph/osd # 见 ceph-error.md
$ chown ceph:ceph -R /ceph/journal # 见 ceph-error.md
```

```sh
# 开机自动挂载
# 第一个数字表示 dump 选项：0 不备份，1 备份，2 备份（比 1 重要性小）
# 第二个数字表示是否在启东市用 fsck 校验分区：０ 不校验，１ 校验，２ 校验（比 １ 晚校验）
$ cat /etc/fstab | grep 'osd'
/dev/sdb /ceph/osd xfs defaults 0 0
/dev/sdc /ceph/journal xfs defaults 0 0
```

```sh
# 查看挂载信息
$ mount -l
$ lsblk
```

## 创建集群

除特别说明外，以下操作均在 ceph-admin 节点上进行。

```sh
$ # 切换到 cephme 用户
$ su - cephme

$ # 创建工作目录
$ mkdir ~/ceph-cluster && cd ~/ceph-cluster
```

```sh
$ # 【如果出错可以清除配置、卸载 ceph，重头再来】（Ceph Admin 节点上）
$ ceph-deploy purge {ceph-node} [{ceph-node}]
$ ceph-deploy purgedata {ceph-node} [{ceph-node}]
$ ceph-deploy forgetkeys

$ # 如果是在 Ceph 节点上
$ yum remove -y -q ceph ceph-release ceph-common ceph-radosgw
$ rm -rf --one-file-system -- /var/lib/ceph
$ rm -rf --one-file-system -- /etc/ceph/
```

```sh
$ # 创建一个新集群
$ # ceph-deploy new {initial-monitor-node(s)}
$ ceph-deploy new ceph-node-1 ceph-node-2 ceph-node-3
```

```sh
# 修改配置 ceph.conf（默认值参考: http://docs.ceph.com/docs/master/rados/configuration/pool-pg-config-ref/）
$ cat ceph.conf
[global]
...
osd pool default size = 2 # 副本数，默认３
osd pool default min size = 1
osd journal size = 0 # 因为后面使用的日志盘是块设备，所以这里设置为 0，确保使用整块盘
public network = 192.168.1.0/24 # 用于客户端读写数据
cluster network = 10.1.2.0/24   # 可选，用于 osd 节点之间同步数据和发送心跳包
```

配置解释：

```
osd journal：OSD 日志路径，可以是路径也可以是块设备。OSD 日志默认和 Ceph OSD 数据存储在同一个盘默认路径：/var/lib/ceph/osd/$cluster-$id/journal。每台机器的日志盘符可能不一样，所有不应该在 [global] 中设置，而是单独设置。
osd journal size：默认值为 5120。如果设置的是 0 且指定的路径是块设备，整个块设备都会被用作日志盘
```

* **安装 ceph**

下面的 ceph-deploy 命令默认会安装 jewel 发行版中最新版本的 ceph，如果要安装指定版本的 ceph 只能通过 ceph 源（或者 rpm）来安装。另外，会在安装好 ceph 的节点上自动添加一个 ceph 用户。

```sh
$ # 安装 ceph （ceph-base，ceph-common，ceph-mds，ceph-mon，ceph-osd，ceph-selinux）
$ # 默认使用的是官方源，可以选择使用阿里源
$ # 为所使用 ceph 块存储，所有 docker 节点都一个安装 ceph
$ # ceph-deploy install {all-nodes} --release=jewel
$ ceph-deploy instasll ceph-node-1 ceph-node-2 ceph-node-3 --release=jewel
$
$ # 使用阿里源安装 ceph（根据需要决定是否要使用 https）
$ ceph-deploy install {all-nodes} --release=jewel --repo-url=http://mirrors.aliyun.com/ceph/rpm-jewel/el7 --gpg-url=http://mirrors.aliyun.com/ceph/keys/release.asc
$
$ # 安装好后会自动添加一个 Ceph 源
$ cat /etc/yum.repos.d/ceph.repo
```

通过指定的 Ceph 源来安装：

```sh
$ # 方法一：在所有 ceph 节点都添加 ceph 官方源 （$basearch 就是这样的，请检查一下）
$ rpm -Uvh https://download.ceph.com/rpm-jewel/el7/noarch/ceph-release-1-1.el7.noarch.rpm
$ cat /etc/yum.repos.d/ceph.repo
[Ceph]
name=Ceph packages for $basearch
baseurl=http://download.ceph.com/rpm-jewel/el7/$basearch
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc

[Ceph-noarch]
name=Ceph noarch packages
baseurl=http://download.ceph.com/rpm-jewel/el7/noarch
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc

[ceph-source]
name=Ceph source packages
baseurl=http://download.ceph.com/rpm-jewel/el7/SRPMS
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc
```

```sh
$ # 方法二：在所有 ceph 节点都添加 ceph 阿里源 （推荐）
$ vi /etc/yum.repos.d/ceph-aliyun.repo
[ceph]
name=Ceph packages for $basearch
baseurl=http://mirrors.aliyun.com/ceph/rpm-jewel/el7/$basearch
enabled=1
priority=2
gpgcheck=1
type=rpm-md
gpgkey=https://mirrors.aliyun.com/ceph/keys/release.asc

[ceph-noarch]
name=Ceph noarch packages
baseurl=http://mirrors.aliyun.com/ceph/rpm-jewel/el7/noarch
enabled=1
priority=2
gpgcheck=1
type=rpm-md
gpgkey=https://mirrors.aliyun.com/ceph/keys/release.asc

[ceph-source]
name=Ceph source packages
baseurl=http://mirrors.aliyun.com/ceph/rpm-jewel/el7/SRPMS
enabled=0
priority=2
gpgcheck=1
type=rpm-md
gpgkey=https://mirrors.aliyun.com/ceph/keys/release.asc
```

```sh
$ # 在需要安装 ceph 的节点上安装 jewel 发行版本中的最新版，目前还没有实现安装指定版本，主要是依赖无法安装指定的版本
$ yum install -y ceph
```

* **启动 mon**

```sh
$ # 配置初始 monitor(s)，并收集所有密钥
$ ceph-deploy mon create-initial
$ ls -alh # 完成上述操作后，当前目录会出现以下密钥环
{cluster-name}.client.admin.keyring
{cluster-name}.bootstrap-osd.keyring
{cluster-name}.bootstrap-mds.keyring
{cluster-name}.bootstrap-rgw.keyring
```

```sh
$ # 在所有 ceph-mon 节点上校验进程是否启动（6789）
$ netstat -tpln | grep ceph-mon
```

```sh
$ # 检查 mon 状态
$ ceph mon stat
$ ceph mon dump
$ ceph mon_status -f json-pretty
$ ceph quorum_status -f json-pretty
```

```sh
$ # 如果是新的磁盘应该先擦除（不是格式化）
$ # ceph-deploy disk zap {ceph-node}:/dev/sdb {ceph-node}:/dev/sdc
$
$ # 在节点上进行擦除
$ ceph-disk zap /dev/sdc
$
$ # 启动 ceph osd （ceph-deploy osd create 表示准备并激活）
$
$ # 准备 osd（如果前面的磁盘没有格式化，prepare 的时候会自动格式化）
$ ceph-deploy osd prepare {ceph-node}:/ceph/osd:/ceph/journal
$
$ # 激活 osd （有时，prepare 的时候也会自动激活）
$ ceph-deploy osd activate {ceph-node}:/ceph/osd:/ceph/journal

$ ceph-deploy osd activate {ceph-node}:/dev/sdd1:/dev/ssd1
```

```sh
$ # 在各 ceph osd 节点检查服务是否启动
$ netstat -tpln | grep 'ceph-osd'
$ ceph osd tree # osd 结构
$ ceph osd dump
$ ceph osd stat
```

```sh
$ # 添加管理节点 （用 ceph-deploy 把配置文件和 admin 密钥拷贝到各节点，这样执行 ceph 命令时就无需指定 monitor 地址和 ceph.client.admin.keyring 了）
$ # 为了使用 ceph 块存储，所有 docker 都需要设置为管理节点
$ ceph-deploy admin {nodes}
```

```sh
# 各节点都需要确保对 ceph.client.admin.keyring 有正确的操作权限
$ chmod +r /etc/ceph/ceph.client.admin.keyring
```

```sh
# 集群校验 （http://docs.ceph.org.cn/rados/operations/monitoring/）
$ ceph health
$ ceph status # ceph -s
$ ceph -w # 实时观察
$ ceph df # 集群使用情况（容量、存储池等）
```


## 集群扩容（可选）

除特别说明外，以下操作均在 ceph-deploy 节点上进行。

添加 osd
```sh
$ cd /ceph-cluster
$
$ # 如果是新的磁盘应该先擦除（不是格式化）
$ # ceph-deploy disk zap {ceph-node}:/dev/sdb {ceph-node}:/dev/sdc
$
$ # 准备 osd（如果前面的磁盘没有格式化，prepare 的时候会自动格式化）
$ ceph-deploy osd prepare {ceph-node}:/ceph/osd:/ceph/journal
$
$ # 激活 osd （有时，prepare 的时候也会自动激活）
$ ceph-deploy osd activate {ceph-node}:/ceph/osd:/ceph/journal
```

```sh
# 新增 osd 后， ceph 集群会重新均衡，把归置组迁移到新的 osd
$ ceph -w
```

添加元数据服务器
```sh
$ # 至少需要一个元数据服务器才能使用 CephFS
$ ceph-deploy mds create {ceph-node(s)}
```

>Note: 当前生产环境下的 Ceph 只能运行一个元数据服务器。你可以配置多个，但现在我们还不会为多个元数据服务器的集群提供商业支持。

添加 rgw 例程
```sh
$ # 要使用 ceph 的对象网关组件，必须部署 RGW 例程 （默认监听 7480 端口）
$ ceph-deploy rgw create {ceph-node}
```

添加 monitors
```sh
# monitor 应该是奇数个 （删除用ceph-deploy mon remove）
$ ceph-deploy mon add centos191 # 添加
$ ceph quorum_status -f json-pretty
```

## 存入/检出对象数据

#参考

* [OSD CONFIG REFERENCE](http://docs.ceph.com/docs/master/rados/configuration/osd-config-ref/)
* [增加/删除 OSD](http://docs.ceph.org.cn/rados/deployment/ceph-deploy-osd/)
* [通过 ceph-deploy 安装不同版本 ceph](http://blog.sina.com.cn/s/blog_14f1ca3a20102wn7s.html)

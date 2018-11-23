# Ceph 错误整理

## 错误 1

安装 ceph 过程报错
```bash
$ ceph-deploy install <ceph-node(s)>
[ceph_deploy][ERROR ] RuntimeError: NoSectionError: No section: 'ceph'
```

解决办法（ceph-admin 节点上操作）
```bash
# 方法 1
$ yum remove ceph-release
```

```bash
# 方法 2
$ mv /etc/yum.repos.d/ceph.repo /etc/yum.repos.d/ceph-repo.repo
```

>http://www.virtualtothecore.com/en/adventures-with-ceph-storage-part-5-install-ceph-in-the-lab/
>http://www.jianshu.com/p/bbd4545161b0?nomobile=yes


## 错误 2

安装 ceph 过程中连接超时
```bash
$ ceph-deploy install <ceph-node(s)>
Timeout to connect to ......
```

解决方法

```
# 在所有 ceph 节点都添加 ceph 官方源 （$basearch 就是这样的，请检查一下）
$ vi /etc/yum.repos.d/ceph.repo
[ceph]
name=Ceph packages for $basearch
baseurl=http://download.ceph.com/rpm-jewel/el7/$basearch
enabled=1
priority=2
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc

[ceph-noarch]
name=Ceph noarch packages
baseurl=http://download.ceph.com/rpm-jewel/el7/noarch
enabled=1
priority=2
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc

[ceph-source]
name=Ceph source packages
baseurl=http://download.ceph.com/rpm-jewel/el7/SRPMS
enabled=0
priority=2
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc
```

```bash
# 在所有对应节点安装 ceph
$ yum install snappy leveldb gdisk python-argparse gperftools-libs -y # 安装依赖
$ yum list ceph --showduplicates # 查看相应版本
$ yum install -y ceph-10.2.7 # 安装指定版本
$ rpm -qa | grep ceph  | wc -l # 共 11 个软件包
```

> http://docs.ceph.org.cn/install/install-storage-cluster/


## 错误 3

独立安装 ceph 的时候，linux 库文件、依赖文件找不到。

```bash
$ # 即使安装最新版本也可能出错
$ yum install ceph-10.2.7
Error: Package: 1:librbd1-10.2.7-0.el7.x86_64 (ceph)
           Requires: liblttng-ust.so.0()(64bit)
Error: Package: 1:ceph-common-10.2.7-0.el7.x86_64 (ceph)
           Requires: libbabeltrace.so.1()(64bit)
Error: Package: 1:librgw2-10.2.7-0.el7.x86_64 (ceph)
           Requires: libfcgi.so.0()(64bit)
Error: Package: 1:librados2-10.2.7-0.el7.x86_64 (ceph)
           Requires: liblttng-ust.so.0()(64bit)
Error: Package: 1:ceph-base-10.2.7-0.el7.x86_64 (ceph)
           Requires: liblttng-ust.so.0()(64bit)
Error: Package: 1:ceph-common-10.2.7-0.el7.x86_64 (ceph)
           Requires: libbabeltrace-ctf.so.1()(64bit)
 You could try using --skip-broken to work around the problem
 You could try running: rpm -Va --nofiles --nodigest
```

执行以下命令：

```bash
$ yum install -y yum-utils \
&& yum-config-manager --add-repo https://dl.fedoraproject.org/pub/epel/7/x86_64/ \
&& yum install --nogpgcheck -y epel-release \
&& rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 \
&& rm -f /etc/yum.repos.d/dl.fedoraproject.org*
```

```bash
$ release="jewel"
$ version="10.2.6"

$ rpm --import 'https://download.ceph.com/keys/release.asc'
$ rpm -Uvh http://download.ceph.com/rpm-${release}/el7/noarch/ceph-release-1-1.el7.noarch.rpm

# 安装指定版本（注意顺序）
$ yum install libradosstriper1-${version} librgw2-${version} ceph-common-${version}
```

## 错误 4

ceph activate 激活 osd 是提示没有权限
```bash
$ ceph-deploy activate ceph-node-1:/ceph/osd
error creating empty object store in /ceph/osd: (13) Permission denied
```

原因
```
ceph-deploy prepare 准备 osd 时，会默认为 ceph-node-1:/ceph/osd 等目录添加 `ceph:ceph`权限的文件，而创建 /ceph/osd 目录时的权限是 root:root。
```

解决办法
```bash
$ chown ceph:ceph -R /ceph/osd # 方法 1（推荐）
$ chown root:root -R /ceph/osd # 方法 2
```

>http://www.jianshu.com/p/bbd4545161b0?nomobile=yes


## 错误 5

健康检查是提示：too many PGs per OSD
```bash
$ ceph -s
HEALTH_WARN too many PGs per OSD
```

原因
```
创建的 pool 过多或者 pool 指定的 pg 过多
```

解决办法
```
1. 增加 osd
2. 减少每个 osd 的 pg 数量
```


## 错误 6

初始创建集群时错误
```bash
$ ceph-deploy new centos202 centos203 centos204 centos205 centos206
Some monitors have still not reached quorum
Some monitors have still not reached quorum
Some monitors have still not reached quorum
```

问题
```
在重新执行部署 ceph 过程中（配置发生了变化）执行`ceph-deploy mon create-initial`时一直报错： Some monitors have still not reached quorum。

即便覆写配置也会出错（ceph-deploy --overwrite-conf config push centos202 centos203 centos204 centos205 centos206）
```

解决办法
```bash
# 方法 1： 修改配置文件 ceph.conf 试试（实测无用）
auth_cluster_required = none
auth_service_required = none
auth_client_required = none
```

```bash
# 方法 2
# 实测发现 5 个 mon 会出现这个问题，改为 3 个 mon 后问题居然解决了（总感觉是个 bug），如果 mon 不够的话再添加。
$ ceph-deploy new centos202 centos203 centos204 # 先 3 个 mon
$ ceph-deploy mon add --addr 192.168.111.205 centos205 # 再添加 2 个 mon
$ ceph-deploy mon add --addr 192.168.111.206 centos206
```

```bash
$ # 
$ cat ceph.conf
...
filestore_xattr_use_omap = true
$
$ #
$ ceph-deploy --overwrite-conf mon create-initial
```

## 错误 7

使用 rexray 插件对 docker 卷配额时错误
```
# 部署应用并配额
$ docker run -it --name web -p 8000:80 --volume-driver=rexray -v nginx_data:/usr/share/nginx --storage-opt=size=10 -d nginx:1.11.9-alpine
Error response from daemon: --storage-opt is not supported for overlay
```

问题
```
我希望部署应用的同时自动创建卷并配额，但是 aufs 和 overlay/2 存储驱动都不支持配额（自动创建卷是支持的）
```

解决办法
```bash
# 方法　1
$ docker volume create --driver rexray --opt=size=20 --name nginx_data # 创建卷并指定容量为 20GB
$ docker run -it --name web -p 8000:80 --volume-driver=rexray -v nginx_data:/usr/share/nginx -d nginx:1.11.9-alpine　# 使用创建好的卷部署应用
```

```
# 方法 2： 不使用 overlay/2, 改用 devicemapper （暂时还在考虑中）
因为我们使用的是 ceph 作数据存储，所以貌似使用 overlay/2 和 devicemapper 并没有多大的区别。
```

## 错误 8

时间不同步
```bash
$ ceph -s
HEALTH_WARN clock skew detected on mon.centos206
```

解决办法
```bash
$ ntpdate cn.pool.ntp.org # 同步时间
$ systemctl restart ntpd.service && systemctl enable ntpd.service # 重启 ntpd
```


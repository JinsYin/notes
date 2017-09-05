# Ceph 安装准备

## 准备工作

* 统一用户

官方建议部署 Ceph 时单独创建一个用户并使该用户具有 sudo 权限（因为 ceph-deploy 不支持中途输入密码），而不建议使用 `root` 用户。虽然直接使用 `root` 可以简化很多操作，但也容易被黑客暴力破解，所以我在部署过程中单独创建了一个 `cephme` 用户，你可以根据自己的需求加以修改，但不能是 `ceph` 用户。

* 系统环境

CentOS Release | Linux Kernel        | OS FSType     | OSD FSType |
-------------- | ------------------- | ------------- | ---------- |
7.3.1611       | 3.10.0-514.26.2.el7 | xfs（或 ext4） | xfs        |

* 集群分布

ip           | hostname    | role                      | components       |
------------ | ----------- | ------------------------- | ---------------- |
192.168.1.10 | ceph-admin  | ceph-osd                  | ceph ceph-deploy |
192.168.1.11 | ceph-node-1 | ceph-osd ceph-mon radosgw | ceph ceph-radosgw |
192.168.1.12 | ceph-node-2 | ceph-osd ceph-mon         | ceph |
192.168.1.13 | ceph-node-3 | ceph-osd ceph-mon         | ceph |

其中，上面的 ceph 包括 ceph-base、ceph-common、ceph-selinux、ceph-osd、ceph-mon、ceph-osd、ceph-mds 等组件（rpm -qa | grep ceph*）。

> 注意：直接通过源来安装 ceph 时默认不会安装 ceph-radosgw、ceph-release 等组件，而通过 ceph-deploy install 命令来安装时会自动安装。

* 开机自动联网

CentOS 的网络接口默认是关闭的，如果 Ceph 集群重启守护进程将无法正常通信。所以，需要确保开机就能自动打开网络接口，使 Ceph 守护进程正常通信。

```bash
$ # （所有节点）
$ 
$ # 先检查究竟使用的是哪个网络接口
$ sudo yum install -y net-tools
$ ifconfig
$
$ # 确保 ONBOOT=yes，否则修改它（em1 是网卡接口名，每台机器都可能不一样）
$ cat /etc/sysconfig/network-scripts/ifcfg-em1 | grep 'ONBOOT'
ONBOOT=yes
```

* 确保连通性

ceph-admin 节点配置完 hosts 文件后，需要确保可以 ping 通 Ceph 节点的主机名（hostname -s）。

* 防火墙

Ceph Monitors 之间默认使用 `6789` 端口通信， OSD 之间默认使用 `6800:7300` 这个范围内的端口通信。如果开启了防火墙，需要允许相应的入站请求，以确保客户端能与 Ceph 节点上的守护进程正常通信。另外，防火墙配置需要是永久规则，这样重启后规则才会依然有效。

CentOS 7 默认使用 `firewalld` 来代替 `iptables` 管理防火墙。如果 Ceph 节点之间没有开放通信端口，服务将无法正常启动，最典型的是 `ceph-deploy mon create-initial` 部署 Ceph Mon 时会因无法正常通信导致 `[ERROR] Some monitors have still not reached quorum` 等错误，相应的其他守护进程也会无法正常部署。你有 3 种方式来管理防火墙:

1. 直接关闭防火墙

```bash
$ sudo systemctl stop firewalld
$ sudo systemctl disable firewalld

$ sudo systemctl stop iptables
$ sudo systemctl disable iptables
```

2. 使用 iptables 来开放端口:

```bash
$ # （Ceph 节点）
$ 
$ # em1 为网络接口名，每台机器都可能不一样
$ iptables -A INPUT -i em1 -p tcp -s 192.168.1.0/24 --dport 6789 -j ACCEPT
$ iptables -A INPUT -i em1 -p tcp -s 192.168.1.0/24 --dport 6800:7300 -j ACCEPT
$ 
$ # 保存
$ /sbin/service iptables save
$
$ # 查看
$ iptables -L -n
```

3. 使用 firewalld 来开放端口:

```bash
```

* 终端（TTY）

在 CentOS 上执行 `ceph-deploy` 命令时可能会报错。如果 Ceph 节点默认设置了 `requiretty`，执行 `sudo visudo` 禁用它，并找到 `Defaults requiretty` 选项，把它改为 `Defaults:ceph !requiretty` 或者直接注释掉，这样 ceph-deploy 就可以用新创建的用户连接了。

```bash
$ # （Ceph 节点）
$
$ # 注释掉 Defaults requiretty
$ sudo visudo
```

* SELinux

在 CentOS 中， SELinux 默认为 `Enforcing` 开启状态。为简化安装，暂时将 SELinux 设置为 Permissive 状态，也就是在加固系统配置前先确保集群的安装、配置没问题。要使 SELinux 配置永久生效（如果它的确是问题根源），需要修改配置文件 `/etc/selinux/config`。

```bash
$ # （所有节点）
$
$ # 暂时设置为 Permissive
$ setenforce 0
```

* 优先级/首选项

确保包管理器安装了优先级/首选项包且已启用。在 CentOS 上也许得安装 EPEL。

```bash
$ # （所有节点）
$ 
$ sudo yum install -y yum-plugin-priorities
```


## 安装部署工具

添加 ceph-deploy 源到 ceph-admin 节点并安装 ceph-deploy 部署工具。

```bash
[root@ceph-admin ~]$ # 安装 epel-release （建议每个节点都执行以下命令，否则可能出现错误 error-3）
[root@ceph-admin ~]$ sudo yum install -y yum-utils && sudo yum-config-manager --add-repo https://dl.fedoraproject.org/pub/epel/7/x86_64/ && sudo yum install --nogpgcheck -y epel-release && sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 && sudo rm /etc/yum.repos.d/dl.fedoraproject.org*
```

* 添加 ceph-deploy 源（不是 ceph 源）

具体有哪些 Ceph 相关的 rpm 包可以直接通过 [rpm-jewel/el7](http://download.ceph.com/rpm-jewel/el7) 查看。

```bash
[root@ceph-admin ~]$ # 方法一：添加 ceph-deploy 官方源
[root@ceph-admin ~]$ cat <<EOF > /etc/yum.repos.d/ceph-deploy.repo
[ceph-noarch]
name=Ceph noarch packages
baseurl=http://download.ceph.com/rpm-jewel/el7/noarch
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc
EOF
```

```bash
[root@ceph-admin ~]$ # 方法二：添加 ceph-deploy 阿里源（推荐）
[root@ceph-admin ~]$ cat <<EOF > /etc/yum.repos.d/ceph-deploy-aliyun.repo
[ceph-noarch]
name=Ceph noarch packages
baseurl=http://download.ceph.com/rpm-jewel/el7/noarch
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://mirrors.aliyun.com/ceph/keys/release.asc
EOF
```

* 安装 ceph-deploy

可以安装最新版的 ceph-deploy，但为了避免出错所以安装了指定的版本。另外，官方文档在安装前会使用 `yum update` 命令来升级系统软件包和内核，但升级内核往往导致底层硬件不兼容，所以这里不作任何升级。不过也可以跳过升级内核，只升级系统软件包：`yum update --exclude=kernel* --exclude=centos-release*`。

```bash
[root@ceph-admin ~]$ # 查看有哪些版本
[root@ceph-admin ~]$ yum list ceph-deploy --showduplicates
[root@ceph-admin ~]$ 
[root@ceph-admin ~]$ # 根据需求决定是否要升级系统软件包
[root@ceph-admin ~]$ # yum update --exclude=kernel* --exclude=centos-release*
[root@ceph-admin ~]$ 
[root@ceph-admin ~]$ yum install -y ceph-deploy-1.5.36
```


## Ceph 节点安装

管理节点必须能够通过 SSH 无密码地访问各个 Ceph 节点。如果 ceph-deploy 以某个普通用户登录，那么该用户必须能够无密码地使用 sudo 的权限。

* 安装 NTP

需要在所有 Ceph 节点上安装并使用 NTP来同步时间（特别是 Ceph Monitor 节点），以免因时钟漂移导致故障。

```bash
$ # ntp: ntpd.service, ntpdate: ntpdate.service
$ yum install -y ntp ntpdate ntp-doc
$
$ # 需要使用同一个 NTP 服务器
$ ntpdate cn.pool.ntp.org
$
$ # 开机自启动（顺便不能变）
$ systemctl start ntpdate.service && systemctl enable ntpdate.service
$ systemctl start ntpd.service && systemctl enable ntpd.service
$
$ # 校验
$ systemctl list-units | grep ntp
$
$ # 检查是否使用的同一个 NTP 服务器
$ ntpstat
$
$ ntpq -p
```

* 安装 SSH Server

所有都需要节点安装 SSH Server，以确保 ceph-admin 节点可以通过 SSH 登录各个 Ceph 节点。

```bash
$ # 检查是否已运行
$ systemctl list-units | grep sshd
$ 
$ # 如果没有，安装并启动
$ yum install -y openssh-server
$ systemctl start sshd.service && systemctl enable sshd.service 
```

* 创建新用户

为所有节点创建新用户 `cephme`。原则上，ceph-admin 节点应该创建一个不同于 Ceph 节点的新用户，用于无密钥登录 Ceph 节点。但为了管理方便，在 ceph-admin 节点和 Ceph 节点创建了统一的新用户。

```bash
$ # 创建 cephme 用户以及 home 目录
$ sudo useradd -d /home/cephme -m cephme
$
$ # 设置密码（越复杂越好，但不要忘了）
$ sudo passwd cephme
$
$ # 为 cephme 用户添加 sudo 权限
$ echo "cephme ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/cephme
$ sudo chmod 0440 /etc/sudoers.d/cephme
```

> 注意： 为 cephme 用户添加 sudo 权限后，并不会直接具有 root 般的权限，而是每次操作都需要使用 sudo 命令，只是不用以前一样需要输入密码而已。

* 允许 SSH 免密钥登录

因为 ceph-deploy 不支持输入密码，所以必须在管理节点（ceph-admin）上生成 SSH 密钥并把其公钥分发到各 Ceph 节点。

```bash
[root@ceph-admin ~]$ # 使用新用户登录 ceph-admin 节点
[root@ceph-admin ~]$ su - cephme
[cephme@ceph-admin ~]$ 
[cephme@ceph-admin ~]$ # 在 ceph-admin 节点上为 cephme 用户创建 SSH 密钥对（公钥和私钥）
[cephme@ceph-admin ~]$ ssh-keygen -t rsa -N '' # 回车
```

```bash
[cephme@ceph-admin ~]$ # 更新 ceph-admin 节点的 hosts 文件，并确保 ceph-admin 节点可以 ping 通各个 Ceph 节点的主机名（hostname -s）
[cephme@ceph-admin ~]$ sudo vi /etc/hosts
192.168.1.10 ceph-admin
192.168.1.11 ceph-node-1
192.168.1.12 ceph-node-2
192.168.1.13 ceph-node-3
```

```bash
[cephme@ceph-admin ~]$ # 将 ceph-admin 节点的公钥拷贝到各个 Ceph 节点，拷贝之后最好验证一下是否可以免密钥登录
[cephme@ceph-admin ~]$ ssh-copy-id cephme@ceph-admin
[cephme@ceph-admin ~]$ ssh-copy-id cephme@ceph-node-1
[cephme@ceph-admin ~]$ ssh-copy-id cephme@ceph-node-2
[cephme@ceph-admin ~]$ ssh-copy-id cephme@ceph-node-3
```

```bash
[cephme@ceph-admin ~]$ # ceph-admin 节点指定默认登录用户，无需每次执行 ceph-deploy 都指定 --username [name]
[cephme@ceph-admin ~]$ # 如果 ceph-admin 节点和 Ceph 节点没有使用相同的用户，这一步骤非常有必要
[cephme@ceph-admin ~]$ cat <<EOF >> ~/.ssh/config
Host ceph-node-1
  Hostname ceph-node-1
  User cephme
Host ceph-node-2
  Hostname ceph-node-2
  User cephme
Host ceph-node-3
  Hostname ceph-node-3
  User cephme
EOF
[cephme@ceph-admin ~]$
[cephme@ceph-admin ~]$ # 修改访问权限
[cephme@ceph-admin ~]$ chmod 0600 ~/.ssh/config
[cephme@ceph-admin ~]$ 
[cephme@ceph-admin ~]$ # 最后再次确认一下是否可以免密钥登录
```

# Ceph 安装准备

## 前言

Ceph 为版本`jewel`（10.2.7），该版本是 cephfs 的第一个稳定版本，所以打算用在生产环境中。
其中，  
cephfs 用于存储 ais 原始报文；  
ceph 块存储用于存储　docker 卷；  
ceph 对象存储用于存储　docker 镜像。

```bash
$ sudo -i # 统一使用 root 用户
```

节点布局

ip | hostname | 角色
--------------- | --------- | --------------
192.168.111.191 | centos191 | deploy-node, osd-node
192.168.111.192 | centos192 | mon-node, osd-node, radosgw-node
192.168.111.193 | centos193 | mon-node, osd-node
192.168.111.194 | centos194 | mon-node, osd-node

## 安装 CEPH 部署工具

需要选择一个节点作为 admin-node， 并在该节点上安装 ceph-deploy。

```bash
$ sudo yum install -y yum-utils && sudo yum-config-manager --add-repo https://dl.fedoraproject.org/pub/epel/7/x86_64/ && sudo yum install --nogpgcheck -y epel-release && sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 && sudo rm /etc/yum.repos.d/dl.fedoraproject.org*
```

```bash
# 添加软件源
$ cat /etc/yum.repos.d/ceph.repo
[ceph-noarch]
name=Ceph noarch packages
baseurl=http://download.ceph.com/rpm-jewel/el7/noarch
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc
```

```bash
# 安装
$ yum install -y ceph-deploy-10.2.7
```


## CEPH 节点安装

（admin-node 和 ceph-node 都进行以下操作, 除特别说明外。）

```bash
# 各节点安装 ssh 并生成密钥对
$ yum install -y openssh-server
$ ssh-keygen -t rsa -N ''
```


```bash
# 各节点添加 hosts，并确保相互可以 ping 通
$ cat /etc/hosts
192.168.111.191 centos191
192.168.111.192 centos192
192.168.111.193 centos193
192.168.111.194 centos194
```

```bash
# ceph-admin 节点需要无密钥访问各个 ceph 节点
$ ssh-copy-id root@centos191
$ ssh-copy-id root@centos192
$ ssh-copy-id root@centos193
$ ssh-copy-id root@centos194
```

```bash
# ceph-admin 节点指定默认登录用户，无需每次执行 ceph-deploy 都指定 --username [name]
$ cat ~/.ssh/config
Host centos191
    Hostname centos191
    User root
Host centos192
    Hostname centos192
    User root
Host centos193
    Hostname centos193
    User root
Host centos194
    Hostname centos194
    User root
```


```bash
# 同步时间
$ yum install -y ntp ntpdate ntp-doc # ntp: ntpd.service, ntpdate: ntpdate.service
$ ntpdate cn.pool.ntp.org
$ systemctl start ntpd.service && systemctl enable ntpd.service
```

```bash
# 开机自启动网卡（enp1s0 为网卡名）
$ cat /etc/sysconfig/network-scripts/ifcfg-enp1s0 | grep 'ONBOOT'
ONBOOT＝yes
```

```bash
# 防火墙（mon 默认使用 6789 端口通信， osd 之间默认使用 6800:7300 范围内的端口通信）
$ iptables -A INPUT -i enp1s0 -p tcp -s 192.168.1.0/24 --dport 6789 -j ACCEPT
$ iptables -A INPUT -i enp1s0 -p tcp -s 192.168.1.0/24 --dport 6800:7300 -j ACCEPT
$ /sbin/service iptables save # 保存
$ iptables -L -n
```

```bash
# SELinux （默认为 Enforcing，为简化安装临时设置为 Permissiv）
$ getenforce
$ setenforce 0
```

```bash
# 终端（ TTY ）
$ sudo visudo # （注释掉 Defaults requiretty）
```

```bash
# 确保包管理器安装了优先级/首选项包且已启用
$ yum install -y yum-plugin-priorities
```

# 配置操作系统

## 关闭 SELinux 和防火墙

RHEL/CentOS 关闭 SELinux：

```sh
# 检查 SELinux 的状态
$ sudo sestatus

# 关闭
$ sudo vi /etc/selinux/config
SELINUX=disable

# 禁用 System Security Services Daemon (SSSD)
$ sudo vi /etc/sshd/sshd.conf
selinux_provider=none

# 重启
$ reboot
```

RHEL/CentOS 关闭防火墙：

```sh
# RHEL/CentOS 6
$ /sbin/chkconfig iptables off    # 关闭防火墙
$ /sbin/chkconfig --list iptables # 检查防火墙状态

# RHEL/CentOS 7
$ systemctl stop firewalld    # 关闭防火墙
$ systemctl disable firewalld # 取消开启启动 firewalld
$ systemctl status firewalld  # 查看防火墙状态

# Ubuntu
$ systemctl stop ufw
$ systemctl disable ufw
$ systemctl status firewalld
```

## 操作系统参数

需要修改的项：

* 共享内存
* 网络
* 用户限制（User Limits） - 控制通过 shell 启动的进程的资源
  * Greenplum 对单个进程可以打开的文件（即文件描述符）有更高的要求，默认配置可能导致查询失败

### hosts 文件

```sh
# 包含所有 Greenplum 服务器的主机名和 IP
$ vi /etc/hosts
```

### sysctl.conf

```sh
$ vi /etc/sysctl.conf
# kernel.shmall = _PHYS_PAGES / 2 # See Shared Memory Pages
kernel.shmall = 197951838

# kernel.shmmax = kernel.shmall * PAGE_SIZE
kernel.shmmax = 810810728448
kernel.shmmni = 4096
vm.overcommit_memory = 2 # See Segment Host Memory
vm.overcommit_ratio = 95 # See Segment Host Memory

net.ipv4.ip_local_port_range = 10000 65535 # See Port Settings
kernel.sem = 500 2048000 200 40960
kernel.sysrq = 1
kernel.core_uses_pid = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.msgmni = 2048
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.conf.all.arp_filter = 1
net.core.netdev_max_backlog = 10000
net.core.rmem_max = 2097152
net.core.wmem_max = 2097152
vm.swappiness = 10
vm.zone_reclaim_mode = 0
vm.dirty_expire_centisecs = 500
vm.dirty_writeback_centisecs = 100
vm.dirty_background_ratio = 0 # See System Memory
vm.dirty_ratio = 0
vm.dirty_background_bytes = 1610612736
vm.dirty_bytes = 4294967296
```

重新加载：

```sh
$ sysctl -p
```

## 创建管理员

不能以 `root` 用户运行 Greenplum 数据库，推荐采用 `gpadmin`。

* `gpadmin` 必须有权限访问安装和运行 Greenplum 数据库所需的服务和目录
* `gpadmin` 用户必须安装 SSH 密钥对，实现集群中的主机可以两两之间无密钥互访
  * 在启用 master 节点无密钥访问其他主机之后，可以使用 `gpssh-exkeys` 命令行工具启用任意主机之间无密钥互访

创建 `gpadmin` 组和用户：

```sh
$ groupadd gpadmin
$ useradd gpadmin -r -m -g gpadmin
$ passwd gpadmin
```

为 `gpadmin` 用户生成 SSH 密钥对：

```sh
$ su - gpadmin
$ ssh-keygen -t rsa -b 4096
```

授权 `gpadmin` 用户 sudo 权限（可选）：

```sh
# RHEL/CentOS
$ visudo
# %wheel        ALL=(ALL)       NOPASSWD: ALL  # 注释该行，请确保有 NOPASSWD 关键字

# 添加 gpadmin 用户到 wheel 组
$ usermod -aG wheel gpadmin
```

## 参考

* [Configuring Your Systems](http://docs.greenplum.org/6-4/install_guide/prep_os.html)
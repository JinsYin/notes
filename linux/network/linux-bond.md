# Linux 多网卡绑定

利用 Linux 的 `bond` 模块可实现多块网卡绑定单个 IP 地址，用于提升服务器的网络 I/O。

## 加载、配置 bonding 模块

### 配置 bonding

```bash
$ vi /etc/modprobe.d/bond.conf
alias bond0 bonding
#option bond0 max_bonds=4 miimon=100 mode=1 primary=em1
```

相关说明：

* `option`: 除了在这里设置外，还可以在网卡配置中使用 `BONDING_OPTS` 进行设置。
* `max_bonds`： 指定该 bonding 驱动实例可以创建的 bonding 数量。
* `miimon`: 表示每 100ms 监测一次链路状态。bonding 只监测主机与交换机之间的链路。如果交换机出去的链路出问题而本身没有问题，那么bonding认为链路没有问题而继续使用。
* `mode`: 绑定模式，共七种。
  * `0`: load balancing（round-robin）；负载均衡轮询策略，所有绑定网卡都工作。
  * `1`: fault-tolerance（active-backup）；提供主从冗余功能，仅主网卡工作；另外该模式支持使用 `primary` 指定哪个 slave 作为主设备。
  * `2`: load balancing（xor）；提供负载均衡和容错功能。
  * `3`: broadcast；广播策略。

### 加载 bonding

```bash
# 加载
$ modprobe bonding

# 验证
$ lsmod | grep bonding
bonding     141566  0
```

## 实现

### 配置网卡

* 配置 bonding

```bash
$ vi /etc/sysconfig/network-scripts/ifcfg-bond0
TYPE=Ethernet
DEVICE=bond0
BOOTPROTO=none
ONBOOT=yes
USERCTL=no
BONDING_OPTS="miimon=100 mode=2"
NETMASK=255.255.255.0
GATEWAY=192.168.10.1
IPADDR=192.168.10.103
NM_CONTROLLED=no
```

* 网卡 １

```bash
# 备份
$ cp /etc/sysconfig/network-scripts/{ifcfg-em1,ifcfg-em1.bak}

$ vi /etc/sysconfig/network-scripts/ifcfg-em1
TYPE=Ethernet
DEVICE=em1
USERCTL=no
ONBOOT=yes
MASTER=bond0
SLAVE=yes
BOOTPROTO=none
NM_CONTROLLED=no
```

* 网卡 2

```bash
$ vi /etc/sysconfig/network-scripts/ifcfg-em2
TYPE=Ethernet
DEVICE=em2
USERCTL=no
ONBOOT=yes
MASTER=bond0
SLAVE=yes
BOOTPROTO=none
NM_CONTROLLED=no
```

* 网卡 3

```bash
$ vi /etc/sysconfig/network-scripts/ifcfg-em3
TYPE=Ethernet
DEVICE=em3
USERCTL=no
ONBOOT=yes
MASTER=bond0
SLAVE=yes
BOOTPROTO=none
NM_CONTROLLED=no
```

### 检测、验证

```bash
# 重启网络服务
$ systemctl restart network
```

```bash
# 确认 bonding 设备已经正确加载，或者绑定了哪些网口
$ cat /proc/net/bonding/bond0
Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)

Bonding Mode: load balancing (xor)
Transmit Hash Policy: layer2 (0)
MII Status: up
MII Polling Interval (ms): 100
Up Delay (ms): 0
Down Delay (ms): 0

Slave Interface: em1
MII Status: up
Speed: 1000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 14:18:77:2d:cf:bd
Slave queue ID: 0

Slave Interface: em2
MII Status: up
Speed: 1000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 14:18:77:2d:cf:be
Slave queue ID: 0

Slave Interface: em3
MII Status: up
Speed: 1000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 14:18:77:2d:cf:bf
Slave queue ID: 0
```

```bash
# 列出所有网口
$ ifconfig
```

## 测试

进行以下操作，再试图拔掉网线。

```bash
# 其他机器 ping 本机
$ ping 192.168.10.103

# 本机 ping 外网
$ ping baidu.com
```

## 参考

* [多网卡同 IP 和同网卡多 IP 技术](https://www.jianshu.com/p/c3278e44ee9d)
* [HowTo Add Multiple Bonding Interface](http://www.sohailriaz.com/howto-add-multiple-bonding-interface/)
* [Linux 网卡 bond 的七种模式详解](http://blog.51cto.com/linuxnote/1680315)
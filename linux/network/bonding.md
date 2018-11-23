# Linux 多网卡绑定

利用 Linux 的 `bond` 模块可实现多块网卡绑定单个 IP 地址，用于提升服务器的网络 I/O。

## 加载模块

* 临时加载

```bash
# 临时加载
$ modprobe bonding

# 验证
$ lsmod | grep bonding
bonding     141566  0
```

* 开机自动加载

```bash
$ cd /etc/sysconfig/modules/

# 名称根据模块名来命名
$ vi bonding.modules
#！/bin/sh
/sbin/modinfo -F filename bonding > /dev/null 2>&1
if [ $? -eq 0 ]; then
    /sbin/modprobe bonding
fi

# 改变权限，之后重启
$ chmod +x bonding.modules
```

## Bonding 配置

`bonding` 内核模块的参数必须指定到 `ifcfg-bondN` 接口文件的 `BONDING_OPTS="<bonding parameters>"` 选项中（中间用空格分隔），而不是 `/etc/modprobe.d/bonding.conf` 或 `/etc/modprobe.conf`。

* `max_bonds`： 指定该 bonding 驱动实例可以创建的 bonding 数量；`ifcfg-bondN` 文件使用 `BONDING_OPTS` 选项时不应该设置。
* `miimon`: 表示每 100ms 监测一次链路状态。bonding 只监测主机与交换机之间的链路。如果交换机出去的链路出问题而本身没有问题，那么 bonding 认为链路没有问题而继续使用。
* `mode`: 绑定模式，共七种。
  * `0`: load balancing（round-robin）；负载均衡轮询策略，所有绑定网卡都工作。
  * `1`: fault-tolerance（active-backup）；提供主从冗余功能，仅主网卡工作；另外该模式支持使用 `primary` 指定哪个 slave 作为主设备。
  * `2`: load balancing（xor）；提供负载均衡和容错功能。
  * `3`: broadcast；广播策略。
  * `4`: 802.3ab 负载均衡模式，要求交换机也支持 802.3ab 模式，理论上服务器及交换机都支持此模式时，网卡带宽最高可以翻倍(如从 1Gbps 翻到 2Gbps)

## 实现

（我测试发现，`mode=4` 比 `mode=2` 更稳定可靠，丢包率更低）

### 配置网卡

* 配置 bonding

方式一：最稳定

```bash
TYPE=Ethernet
NAME=bond0 # 自定义
DEVICE=bond0 # 自定义
BOOTPROTO=none
ONBOOT=yes
DEFROUTE=yes # 视情况而定，比如万兆可能就不应该设置为默认路由
USERCTL=no # 仅 root 用户可以控制
NM_CONTROLLED=no
BONDING_OPTS="miimon=100 mode=4" # mode 自定义
IPADDR=192.168.10.103 # 自定义
GATEWAY=192.168.10.1
NETMASK=255.255.255.0
DNS1=114.114.114.114
```

方式二：这种方式虽然是官方建议的，但测试下来丢包率太高

```bash
$ vi /etc/sysconfig/network-scripts/ifcfg-bond0
TYPE=Bond
NAME=bond0 # 自定义
DEVICE=bond0 # 自定义
BOOTPROTO=none
ONBOOT=yes
DEFROUTE=yes # 视情况而定，比如万兆可能就不应该设置为默认路由
USERCTL=no # 仅 root 用户可以控制
NM_CONTROLLED=no
BONDING_MASTER=yes
BONDING_OPTS="miimon=100 mode=4" # mode 自定义
IPADDR=192.168.10.103 # 自定义
GATEWAY=192.168.10.1
NETMASK=255.255.255.0
DNS1=114.114.114.114
```

* 网卡 １

```bash
# 备份
$ cp /etc/sysconfig/network-scripts/{ifcfg-em1,ifcfg-em1.bak}

$ vi /etc/sysconfig/network-scripts/ifcfg-em1
TYPE=Ethernet
DEVICE=em1
BOOTPROTO=none
MASTER=bond0
SLAVE=yes
ONBOOT=yes
USERCTL=no
NM_CONTROLLED=no
```

* 网卡 2

```bash
$ vi /etc/sysconfig/network-scripts/ifcfg-em2
TYPE=Ethernet
DEVICE=em2
BOOTPROTO=none
MASTER=bond0
SLAVE=yes
ONBOOT=yes
USERCTL=no
NM_CONTROLLED=no
```

* 网卡 3

```bash
$ vi /etc/sysconfig/network-scripts/ifcfg-em3
TYPE=Ethernet
DEVICE=em3
BOOTPROTO=none
MASTER=bond0
SLAVE=yes
ONBOOT=yes
USERCTL=no
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
$ ping -I bond0 baidu.com
```

## 参考

* [USING THE COMMAND LINE INTERFACE (CLI)](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-network_bonding_using_the_command_line_interface)
* [多网卡同 IP 和同网卡多 IP 技术](https://www.jianshu.com/p/c3278e44ee9d)
* [HowTo Add Multiple Bonding Interface](http://www.sohailriaz.com/howto-add-multiple-bonding-interface/)
* [Linux 网卡 bond 的七种模式详解](http://blog.51cto.com/linuxnote/1680315)
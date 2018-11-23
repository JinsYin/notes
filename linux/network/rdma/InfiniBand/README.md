# InfiniBand（IB）管理

InfiniBand 是一种基于交换的串行 I/O 互连体系结构，运行速度为每方向 2.5Gb/s 或 10Gb/s（每端口）。

## InfiniBand 两个概念

* InfiniBand 网络的物理链路层协议
* 高级的编程 API，称为 InfiniBand Verbs API，它是 RDMA 技术的实现

## 启用 IPoIB（Internet Protocol over InfiniBand）

<http://www.advancedclustering.com/act_kb/ipoib-using-tcpip-on-an-infiniband-network/>

### Enabling IPoIB using OFED

```bash
$ vi /etc/infiniband/openib.conf
IPOIB_LOAD=yes
SET_IPOIB_CM=yes

$ systemctl restart openibd

# 查找是否有 "ib" 开头的网络设备以判断是否启动成功
$ ifconfig -a
```

### Enabling IPoIB using RHEL or CentOS Provided Software

```bash
$ vi /etc/rdma/rdma.conf
IPOIB_LOAD=yes

$ systemctl restart rdma

# 查找是否有 "ib" 开头的网络设备以判断是否启动成功
$ ifconfig -a
```

## 概述

## Mellanox InfiniBand

Mellanox InfiniBand,主要包括 HCA（主机通道适配器）和交换机两部分。

### Firmware Burning

```bash
# 检查设备的 PCI 地址
$ lspci | grep Mellanox
04:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)

# 检查适配器卡的 PSID
$ yum install -y mstflint
$ mstflint -d 04:00.0 q
Image type:            FS2
FW Version:            2.9.1000
Device ID:             26428
Description:           Node             Port1            Port2            Sys image
GUIDs:                 0002c903000cc89a 0002c903000cc89b 0002c903000cc89c 0002c903000cc89d
MACs:                                       0002c90cc89a     0002c90cc89b
VSD:
PSID:                  MT_0D90110009
```

### Port Type Management

ConnectX®-3/ConnectX®-3 Pro/ConnectX®-4/ConnectX®-4 Lx/ConnectX®-
5/ConnectX®-5 Ex ports can be individually configured to work as InfiniBand or Ethernet
ports. By default both ConnectX®-4 VPI ports are initialized as InfiniBand ports. If you
wish to change the port type use the mstconfig after the driver is loaded.

```bash
# 安装 mstflint 工具
$ yum install -y mstflint

# 检查设备的 PCI 地址
$ lspci | grep Mellanox

# 使用 mstconfig 更改连接类型为：IB（InfiniBand）或 ETH（Ethernet）
# mstconfig –d <device pci> s LINK_TYPE_P1/2=<ETH|IB|VPI>
$ mstconfig -d 04:00.0 s LINK_TYPE_P1=IB

# 最后重启机器
$ reboot
```

### 内核驱动

Mellanox **ConnectX®-2** / **ConnectX®-3** / **ConnectX®-3 Pro** 的内核模块为：`mlx4_en`，`mlx4_core` 和 `mlx4_ib`。

Mellanox **ConnectX®-4** / **ConnectX®-4 Lx**/ **ConnectX®-5** / **ConnectX®-5 Ex** 的内核模块为：`mlx5_core` 和 `mlx5_ib`。

如果要卸载内核模块，需要先卸载 `mlx*_en`/`mlx*_ib`，再卸载 `mlx*_core`。

```bash
# 加载驱动
$ modprobe mlx5_ib

# 查看驱动
$ lsmod | grep mlx*

# 卸载驱动
$ modprobe -r mlx5_ib
```

### 重要的软件包

| package       | info                                                                                                |
| ------------- | --------------------------------------------------------------------------------------------------- |
| **rdma-core** | RDMA core userspace libraries and daemons                                                           |
| **libibmad**  | Low layer InfiniBand diagnostic and management program. OpenFabrics Alliance InfiniBand MAD library |

```bash
# 安装
$ yum install libibverbs librdmacm libibcm libibmad libibumad libmlx4
libmlx5 opensm ibutils infiniband-diags srptools perftest mstflint rdmacmutils
ibverbs-utils librdmacm-utils -y
```

## 安装 IB 网卡驱动（Mellanox）驱动

### 使用官方仓库

### 利用 CentOS 源安装 IB 驱动

#### 安装 RDMA 软件包

```bash
# 安装 RDMA（卸载：yum -y groupremove "Infiniband Support"）
$ yum -y groupinstall "Infiniband Support"

# 安装可选包
$ yum -y install opensm # infiniband-diags perftest gperf
```

#### 启动 RDMA 服务

```bash
$ systemctl start rdma
$ systemctl start opensm

# 查看状态
$ systemctl start rdma
$ systemctl start opensm # 所有 IB 节点选举一个 MASTER，其余都是 STANDBY

# 开机自动启动
$ systemctl enable rdma
$ systemctl enable opensm

# 必须重启机器
$ reboot
```

### 命令

```bash
# 查看 ib　网卡状态，如果是 Active 表示已启动
$ ibstat
CA 'mlx4_0'
    CA type: MT26428
    Number of ports: 1
    Firmware version: 2.9.1000
    Hardware version: b0
    Node GUID: 0x0002c903000d7aac
    System image GUID: 0x0002c903000d7aaf
    Port 1:
        State: Active
        Physical state: LinkUp
        Rate: 40
        Base lid: 5
        LMC: 0
        SM lid: 4
        Capability mask: 0x0251086a
        Port GUID: 0x0002c903000d7aad
        Link layer: InfiniBand

# 查看是否可用
$ sminfo
sminfo: sm lid 4 sm guid 0x2c903000d81f9, activity count 1329328 priority 14 state 3 SMINFO_MASTER
```

```bash
$ nmcli dev status

$ nmcli connect show
$ nmcli connect show -a
```

```bash
$ # 启动子网管理(subnet manager)
$ service opensmd start

$ # 开机自启动
$ chkconfig opensmd on
```

```bash
# 重启 ib（Infiniband） 网卡
$ service openibd restart
```

## 配置 IPoIB 网络接口

临时配置静态 IP ：

```bash
# ip a
$ ip address add 10.0.10.100/24 dev ib0
```

永久配置静态 IP ：

```bash
# 需要确保开机后 NM Controlled 自启动
$ cat /etc/sysconfig/network-scripts/ifcfg-ib0
TYPE="Infiniband"
BOOTPROTO="none"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="yes"
NAME="ib0"
DEVICE="ib0"
ONBOOT="yes"
IPADDR="10.0.10.100"
PREFIX="24"
NM_CONTROLLED="yes"
```

重启网络接口：

```bash
$ ifdown ib0 && ifup ib0
```

## 参考

* [Red Hat Enterprise Linux (RHEL) 7.4 Driver User Manual](http://www.mellanox.com/pdf/prod_software/Red_Hat_Enterprise_Linux_(RHEL)_7.4_Driver_User_Manual.pdf)
* [CentOS下IPoIB（IP over InfiniBand）网络接口的配置过程](http://blog.csdn.net/warren912/article/details/19419945)
* [How to Configure and Manage Network Connections Using ‘nmcli’ Tool](https://www.tecmint.com/configure-network-connections-using-nmcli-tool-in-linux/)
* [InfiniBand](https://zh.wikipedia.org/wiki/InfiniBand)
* [HowTo Enable, Verify and Troubleshoot RDMA](https://community.mellanox.com/docs/DOC-2086)
* [CONFIGURE INFINIBAND AND RDMA NETWORKS](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/ch-configure_infiniband_and_rdma_networks)
* [InfiniBand](https://wiki.archlinux.org/index.php/InfiniBand)
# IPoIB

## 作用

IPoIB 的作用是在 InfiniBand RDMA 网络之上提供 IP 网络仿真层。这允许现有程序在未经修改的情况下在 InfiniBand 网络上运行，但比使用 RDMA 通信时性能要低。由于 iWARP 和 RoCE/IBoE 网络实际上都是 IP 网络，其 RDMA 层是在 IP 链路层上，不需要 IPoIB。

## 通信模式

IPoIB 设备可配置为以数据报（`datagram`）或连接（`connected`）模式运行。

* datagram 模式 - 打开不可靠的、断开连接的队列对

```plain
该模式不允许任何大于 InfiniBand 链路层 MTU 的数据包。

IPoIB 层在正在传输的 IP 数据包之上添加一个 4 字节的 IPoIB 包头，所以 IPoIB MTU 必须比 InfiniBand 链路层 MTU 少 4 个字节。

InfiniBand 链路层 MTU 通常是 2048，因此 datagram 模式下的公共 IPoIB 设备 MTU 为 2044
```

* connected 模式 - 打开可靠的连接队列对

```plain
IB 网卡在该模式下可以发送的 IPoIB 消息的大小没有限制，但由于 IP 数据包仅具有 16 位大小字段的限制，因此限制为 65535 作为最大字节数（实际上限为 65520，确保足够的空间容纳 TCP 报头）。

该模式性能更高，但需要消耗更多的 kernel 内存，但大多数系统更关心性能而不是内存消耗。
```

## 硬件地址

IPoIB 设备具有 20 字节的硬件地址。弃用的 `ifconfig` 工具无法为 IPoIB 设备找到正确的硬件地址，应该使用 `iproute` 包中的 `ip` 工具。

```sh
# 前 4 个字节是标志和队列对号："80:00:02:08"
# 接下来的 8 个字节是子网前缀："fe:80:00:00:00:00:00:00"，默认子网前缀：“0xfe:80:00:00:00:00:00:00”
# 最后 8 个字节是 IPoIB 设备所连接的 InfiniBand 端口的 GUID 地址："00:02:c9:03:00:29:3e:bb"
$ ip link show ib0 | grep "link/infiniband"
link/infiniband 80:00:02:08:fe:80:00:00:00:00:00:00:00:02:c9:03:00:29:3e:bb brd 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
```

## 网络配置

```sh
$ vi /etc/sysconfig/network-scripts/ifcfg-ib0
TYPE=InfiniBand
NAME=ib0 # 不需要匹配 DEVICE
DEVICE=ib0 # 必须与 udev 重命名规则中创建的命名匹配
BOOTPROTO=none
DEFROUTE=no # 由于不是以太网，所以通常不需要设置为默认路由
ONBOOT=yes
USERCTL=no # 仅 root 用户可以操作
NM_CONTROLLED=no
CONNECTED_MODE=yes # yes: connected mode, no: datagram mode
MTU=2044 # 65520 是最大值，暂时使用默认值 2044
IPADDR=10.0.10.210 # 自定义
GATEWAY=10.0.10.1
NETMASK=255.255.255.0
```

```sh
# 连接 IB 网络
$ ifdown ib0 && ifup ib0

# 检查 MTU 是否正确
$ ip link show ib0 | grep mtu
```

## 网卡设备重命名

`rdma-core` 包提供 `/etc/udev/rules.d/70-persistent-ipoib.rules` 文件，该 udev 规则文件用于将 IPoIB 设备从默认名称重命名为更具体的名称。用户必须编辑此文件以更改其设备的命名方式。

* 第一步：找出需要重命名的设备的 GUID

```sh
# link/infiniband 后接的是 IPoIB 接口的 20 字节硬件地址，最后 8 个字节即所需的 GUID 地址： “02:c9:03:00:0c:c8:9b”
$ ip link show ib0
ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc pfifo_fast state UP mode DEFAULT group default qlen 256
  link/infiniband 80:00:02:08:fe:80:00:00:00:00:00:00:00:02:c9:03:00:0c:c8:9b brd 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
```

* 第二步：在 rules 文件中添加条目

```sh
# mlx4 为设备名称，所有地址小写
$ vi /etc/udev/rules.d/70-persistent-ipoib.rules
ACTION=="add", SUBSYSTEM=="net", DRIVERS=="?*", ATTR{type}=="32", ATTR{address}=="?*02:c9:03:00:0c:c8:9b", NAME="mlx4_ib0"
```

* 第三步：生效

除了重启可以生效外，还可以通过删除 `ib_ipoib` 内核模块再重新加载来强制重命名 IPoIB 接口。

```sh
% rmmod ib_ipoib
% modprobe ib_ipoib
```

## 参考

* [CONFIGURING IPOIB](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_ipoib)
* [CONFIGURE IPOIB USING THE COMMAND LINE](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configure_ipoib_using_the_command_line)
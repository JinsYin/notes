# 混杂模式

**混杂模式**（Promiscuous Mode）是指一台计算机的网卡能够接收所有经过它的网络数据包，而不论其目的地址是不是它。

如果采用混杂模式，一个机器的网卡将接受同一局域网内所有机器所发送的数据包，这样就可以到达对于网络信息监视捕获的目的。

当前以交换机作为交换设备的网络中，即使是将某一个网卡设置成“混杂模式”，除非使用一些特殊技术，网卡本身一般是接不到不是发送给自身的数据，所接到的只是给本身IP的数据和广播数据，但这时RAW Socket可以监听所有的数据了。

通常计算机网卡都工作在非混杂模式下，此时网卡只接收目的地址指向自己的数据，其它包一律丢弃。网卡的混杂模式一般在网络管理员分析网络故障时使用，同时这种模式也被黑客用来作为网络数据窃听的入口。

## 设置

Linux 操作系统设置、取消网卡混杂模式时都需要管理员权限。

### 临时设置

* net-tools

```sh
# 设置
$ sudo ifconfig eth1 promisc

# 验证
$ ifconfig eth1 | grep -i promisc
    UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1

# 取消
$ sudo ifconfig eth1 -promisc
```

* iproute2

```sh
# 设置
$ sudo ip link set eth1 promisc on

# 验证
$ ip link show eth1 | grep -i promisc
2: eth1: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000

# 取消
$ sudo ip link set eth1 promisc off
```

### 永久设置

```sh
$ sudo vi /etc/rc.local
ifconfig eth1 promisc # or: ip link set eth1 promisc on
```

## 参考

* [网卡混杂模式 Promiscuous 与 Linux 上混杂模式的设置](https://blog.csdn.net/bytxl/article/details/46862207)

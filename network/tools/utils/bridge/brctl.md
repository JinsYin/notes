# brctl

网桥，也叫桥接器，是一种在链路层实现中继，对帧进行转发的技术，根据 MAC 分区块，可隔离碰撞，将网络的多个网段在数据链路层连接起来的网络设备。

网桥只在 `同一个逻辑网段` 转发数据包，所以只有当网桥的地址与主机地址在同一网段时才能相互通信。

## 安装

```sh
# REHL/CentOS
$ yum install -y bridge-utils

# Debian/Ubuntu
$ apt-get install -y bridge-utils
```

## 命令

* 查看网桥

```sh
# 查看所有网桥
$ brctl show

# 查看某个网桥
$ brctl show xxxx

# 查看某个网桥的 MAC 地址
$ brctl showmacs xxxx
```

* 添加网桥

```sh
# 创建网桥
$ brctl addbr bridge0
```

* 关闭 STP（生成树协议）

```sh
$ brctl stp bridge0 off
```

* 删除网桥

```sh
$ brctl delbr bridge0
```

* 添加物理接口

添加以太网物理接口，意思是：将这些物理接口附加到刚生成的逻辑（虚拟）网桥接口 bridge0 上。现在，原来的两个以太网物理接口变成了网桥上的两个逻辑端口。

```sh
$ brctl addif bridge0 eth0

# 可以添加多个
$ brctl addif bridge0 eth0 eth1
```

* 删除物理接口

```sh
$ brctl delif br0 eth0 eth1
```

* 配置网络

```sh
# 配置网段，并启动
$ ifconfig bridge0 172.27.1.0/24 up

# 如果指定了多个物理接口，可以不需要 IP
$ ifconfig bridge0 0.0.0.0

$ ifconfig bridge0
```

* 配置开机激活

```sh
$ vim /etc/network/interfaces
iface bridge0 inet static
  address 10.10.10.1
  netmask 255.255.0.0
  gateway 10.10.10.254
  pre-up ip link set eth0 promisc on
  pre-up ip link set eth1 promisc on
  pre-up echo "1" > /proc/sys/net/ipv4/ip_forward
  bridge_ports eth0 eth1
```

## 参考

* [brctl 配置网桥](http://blog.csdn.net/wangwenwen/article/details/7479678)
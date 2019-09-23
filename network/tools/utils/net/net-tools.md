# net-tools

`net-tools` 包含以下命令行工具：

* ifconfig
* route
* arp
* netstat

![iproutes vs net-tools](./img/iproute2-vs-nettools.png)

## 安装

* centos

```sh
$ sudo yum install -y net-tools
```

* ubuntu

```sh
$ sudo apt-get install -y net-tools
```

## netstat

* tcp

```sh
$ netstat -tpln
```

* udp

```sh
$ netstat -upln
```

* all

```sh
$ netstat -apln
```

## ifconfig

* 网卡接口信息

```sh
# 查看已启用的网卡接口信息
$ ifconfig

# 查看所有网卡接口信息，包括 inactive 状态的网卡接口
$ ifconfig -a

# 查看某个网卡接口的信息
$ ifconfig eth0
```

* 开/关网卡接口

```sh
$ ifconfig eth0 down
$ ifconfig eth0 up
```

* 网卡接口分配 IP 地址

```sh
# 设置/修改网关
$ ifconfig eth0 192.168.10.2

# 设置/修改网关和子网掩码
$ ifconfig eth0 192.168.10.3/24

# 同上
$ ifconfig eth0 192.168.10.4 netmask 255.255.255.0
```

* 删除 IP 地址

```sh
$ ifconfig eth0 0
```

* 更改网络接口的 MAC 地址

```sh
$ ifconfig eth0 hw ether 08:00:27:75:2a:66
```

## route

* 查看路由

```sh
$ route -n

$ netstat -rn

$ ip route [show]
```

* 添加/修改路由

```sh
# 添加/修改默认路由
$ route add default gw 192.168.10.1 eth0

# 添加/修改指定路由
$ route add -net 172.14.32.0/24 gw 192.168.1.1 dev eth0
```

* 删除路由

```sh
# 删除默认路由
$ route del default gw 192.168.10.1 eth0

# 删除静态路由
$ route del -net 172.14.32.0/24
```

## arp

```sh
$ arp -na
```

## 参考

* [Linux 网络管理常用命令：net-tools VS iproute2](http://www.cnblogs.com/wonux/p/6268134.html)

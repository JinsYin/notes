# Linux iproute2

iproute2 包含以下命令行工具：

* ip addr
* ip link
* ip route
* ss
* ip neigh

![iproutes vs net-tools](../.images/iproute2-vs-nettools.png)

## 安装

* ubuntu

```bash
$ apt-get install iproute2
```

## ip addr

* 查看

```bash
$ ip a

$ ip addr show

$ ip addr show dev eth0

# ipv6
$ ip -6 addr show dev eth0
```

* 网卡接口分配 IP 地址

```bash
$ ip addr add 192.168.10.10/24 dev eth0
```

* 删除 IP 地址

```bash
$ ip addr del 192.168.10.10/24 dev eth0
```

## ip link

* 查看

```bash
$ ip a

$ ip link show

$ ip link show dev eth0

# ipv6
$ ip -6 link show dev eth0
```

* 开/关网卡接口

```bash
$ ip link set dev eth0 down
$ ip link set dev eth0 up
```

* 删除网卡接口

```bash
$ ip link delete dev eth0
```

* 更改网络接口的 MAC 地址

```bash
$ ip link set dev eth0 address 08:00:27:75:2a:67
```

## ip route

* 查看路由

```bash
$ ip route [show]

$ route -n

$ netstat -rn
```

* 添加路由

```bash
# 添加默认路由
$ ip route add default via 192.168.10.1 dev eth0

# 添加静态路由
$ ip route add 172.14.32.0/24 via 192.168.1.1 dev eth0
```

* 修改路由

```bash
$ ip route replace default via 192.168.10.1 dev eth0
```

* 删除路由

```bash
$ ip route del 172.14.32.0/24
```

## ss

```bash
$ ss -l
```

## 参考

* [Linux 网络管理常用命令：net-tools VS iproute2](http://www.cnblogs.com/wonux/p/6268134.html)
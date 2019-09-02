# 路由

## 路由追踪

* 安装

```sh
# CentOS
$ yum install -y traceroute
```

* 追踪

```sh
traceroute 12.34.56.78
```

## 静态路由

可以使用　`iproute2` 软件包的 `ip route` 命令，或者 `net-tools` 软件包的 `route` 命令（已被　CentOS 弃用）。

### ip route 命令

* 添加默认路由

```sh
# x.x.x.x 既可以是路由器网关，也可以是网关服务器地址
$ ip route add default via x.x.x.x dev eth0
```

* 添加非默认路由

```sh
$ ip route add 172.1.0.0/16 via x.x.x.x dev eth0
RTNETLINK answers: Network is unreachable
```

> 添加静态路由时，需要确保 x.x.x.x（网关） 和 eth0（主机 IP） 位于同一网段

* 查看路由

```sh
$ ip route # or: ip route list
default via 192.168.8.254 dev eth1  proto static
172.17.0.0/16 dev docker0  proto kernel  scope link  src 172.17.0.1
192.168.8.0/24 dev eth1  proto kernel  scope link  src 192.168.8.220  metric 1
```

* 删除路由

```sh
# 直接使用 CIDR 即可删除
$ ip route del 172.1.0.0/16
```

### route 命令

* 添加静态路由

```sh
route add -net 192.168.10.0/24 gw x.x.x.x dev eth1
```

## 路由表

## 路由器

三层交换机（可以配置 VLAN） vs 路由器
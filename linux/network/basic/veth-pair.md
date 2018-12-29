# Veth pair

Virtual Ethernet Pair 简称 veth pair，它们是一个成对的端口，对应于一根网线的两个接口。主要有两种用途：一种是连接两个网络命名空间，另一种是连接网络命名空间与虚拟网桥（或者虚拟交换机）。

net namespace主要是隔离网络设备本身，例如在Linux 中有多个容器，每个容器对应各自的namespace，我们可以把不同的网络设备指派给不同的容器。

veth pair你可以理解为使用网线连接好的两个接口，把两个端口放到两个namespace中，那么这两个namespace就能打通。

如果要把namespace和本地网络打通，也可以创建veth设备，把两端分别放入本地和namespace。

ip link add eth1-br1 type veth peer name phy-br1

## network namespace

网络命名空间用于隔离网络设备，例如 Docker 中有多个容器，每个容器对应一个 namespace，而不同的容器有不同的网络设备。

```bash
$ ip nsnet add
```

## 创建 veth pair

```bash
# 创建
$ ip link add veth0 type veth peer name veth1

# 查看
$ ip link list
veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
```

## 参考

* [network namespace 与 veth pair](https://yq.aliyun.com/articles/64855)
* [Linux Switching – Interconnecting Namespaces](http://www.opencloudblog.com/?spm=5176.100239.blogcont64855.31.A8J3hr&p=66)
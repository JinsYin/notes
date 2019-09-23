# OpenvSwitch

OpenvSwitch 简称 ovs。


## 术语

* LAN

LAN 表示 Local Area Network，本地局域网，通常使用 Hub 和 Switch 来连接LAN 中的计算机。一般来说，当你将两台计算机连入同一个 Hub 或者 Switch 时，它们就在同一个 LAN 中。同样地，你连接两个 Switch 的话，它们也在一个 LAN 中。一个 LAN 表示一个广播域，它的意思是，LAN 中的所有成员都会收到 LAN 中一个成员发出的广播包。可见，LAN 的边界在路由器或者类似的3层设备。

* VLAN

VLAN 表示 Virutal LAN。一个带有 VLAN 功能的switch 能够同时处于多个 LAN 中。最简单地说，VLAN 是一种将一个交换机分成多个交换机的一种方法。比方说，你有两组机器，group A 和 B，你想配置成组 A 中的机器可以相互访问，B 中的机器也可以相互访问，但是A组中的机器不能访问B组中的机器。你可以使用两个交换机，两个组分别接到一个交换机。如果你只有一个交换机，你可以使用 VLAN 达到同样的效果。你在交换机上分配配置连接组 A 和 B 的机器的端口为 VLAN access ports。这个交换机就会只在同一个 VLAN 的端口之间转发包。

* VxLAN

...

* OpenFlow

OpenFlow 不是一种软件，而是一种协议。OpenvSwitch 是一种支持 OpenFlow 协议的虚拟 Switch。

* SDN

SDN：软件定义网络，是一种下一代网络的“范式”，而 OpenFlow 是当前最为流行的 SDN 实现方式。


## 隧道方式

* GRE
* VxLAN
* LISP


## 安装

* centos

```
```

* ubuntu

```sh
$ apt-get install -y openvswitch-switch=2.0.2*
```

## 操作

* 添加网桥

```sh
$ ovs-vsctl add-br bridge0
```

* 查看网桥

```sh
$ ovs-vsctl show
$
$ # 不能查看 ovs 创建的网桥
$ brctl show
```

## ovs-vsctl


## ovs-appctl


## ovs-ofctl

ovs-ofctl 是 OpenFlow 的管理工具。


## ovs-docker

```sh
$ wget -O /usr/local/bin/ovs-docker https://github.com/openvswitch/ovs/raw/master/utilities/ovs-docker
$ chmod a+x /usr/local/bin/ovs-docker
```


## 参考

* [使用 Open vSwitch + VLAN 组网](http://www.cnblogs.com/sammyliu/p/4626419.html)
* [七牛容器 SDN 技术与微服务架构实践](http://www.csdn.net/article/a/2015-12-21/15832755)
* [基于 Open vSwitch 的 OpenFlow 实践](http://www.chenshake.com/based-on-openflow-practices-open-vswitch/)
* [基于 Open vSwitch 的 OpenFlow 实践](https://www.ibm.com/developerworks/cn/cloud/library/1401_zhaoyi_openswitch/index.html)
* [搭建基于 Open vSwitch 的 VxLAN 隧道实验](http://www.sdnlab.com/5365.html)

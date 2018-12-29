# 静态 IP

## 配置静态 IP

* CentOS

```ini
TYPE=Ethernet
BOOTPROTO=static # or: dhcp
NAME=eth0 # 非必须
DEVICE=eth0 # 必须
ONBOOT=yes
USERCTL=no
NM_CONTROLLED=no
IPADDR=192.168.1.100
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=114.114.114.114
DNS2=8.8.8.8
```

## 网卡别名

给一个网卡设备配置多个 IP 地址。需要注意的是，NetworkManager 不支持配置网卡子接口，所以需要先关闭。

别名接口文件用于绑定多个 IP 地址到单个网卡接口，即网卡子接口的概念。由于是别名，因此 **不需要添加网关和 DNS 设置**，这些都由主网卡接口确定的。另外，**不必添加 MAC 地址**。

命名规范：`ifcfg-<if-name>:<alias-value>`。

* CentOS

```ini
DEVICE=eth0:0
BOOTPROTO=static # 始终是 static，不可以是 DHCP
ONBOOT=yes
IPADDR=x.x.x.x # 公网 IP 地址
NETMASK=z.z.z.z # 公网 IP 地址的子网掩码
```

```bash
# 启用
$ ifdown eth0:0 && ifup eth0:0

# 重启网络服务
$ systemctl restart network
```

## 参考

* [Adding An Additional Public IP On CentOS 6.X And 7.X](https://www.atlantic.net/community/howto/adding-public-ip-centos/)
* [Adding a Public IPv4 Address to a Linux Server (CentOS 6)](https://whstatic.1and1.com/help/CloudServer/EN-US/d851230.html)
* [Adding a Public IPv4 Address to a Linux Server (Ubuntu)](https://whstatic.1and1.com/help/CloudServer/EN-CA/d851242.html)
* [Linux 网络管理之网卡别名及网卡绑定配置](https://cloud.tencent.com/info/767bd980989e6488fac9d4b3ef626f27.html)
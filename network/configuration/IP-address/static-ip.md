# 配置 IP 地址

## 配置、重启

* CentOS

```ini
$ sudo vi /etc/sysconfig/network-interfaces/ifcfg-eth1

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

```bash
# ifdown eth1 && ifup eth1
$ sudo systemctl restart network
```

* Ubuntu

```ini
$ sudo vi /etc/network/intefaces

auto eth0
iface eth0 inet static
  address 192.168.0.100
  gateway 192.168.0.1
  netmask 255.255.255.0
  network 192.168.0.0
  broadcast 192.168.0.255
```

```bash
# sudo /etc/init.d/networking restart
$ sudo service networking restart
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

## Ubuntu 没有网络

1. ifconfig 检查是否有网卡驱动
2. iwconfig 检查是否连上网
3. sudo iw wlan0 scan | grep SSID 显示周围 wifi
4. sudo if up wlan0 或 sudo ifconfig wlan0 up 开启网络接口
5. 确保 bios 使用 IEFI

## 参考

* [Adding An Additional Public IP On CentOS 6.X And 7.X](https://www.atlantic.net/community/howto/adding-public-ip-centos/)
* [Adding a Public IPv4 Address to a Linux Server (CentOS 6)](https://whstatic.1and1.com/help/CloudServer/EN-US/d851230.html)
* [Adding a Public IPv4 Address to a Linux Server (Ubuntu)](https://whstatic.1and1.com/help/CloudServer/EN-CA/d851242.html)
* [Linux 网络管理之网卡别名及网卡绑定配置](https://cloud.tencent.com/info/767bd980989e6488fac9d4b3ef626f27.html)
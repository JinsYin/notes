# CentOS 网络设置

## 配置静态网络

```sh
# 查看网络接口（假设需要修改的网口是 em1）
$ ip addr show # ip addr

$ vi /etc/sysconfig/network-scripts/ifcfg-em1
TYPE="Ethernet"
BOOTPROTO="static"
NAME="em1"
DEVICE="em1"
ONBOOT="yes" # 开机自启动该网口
DEFROUTE="yes" # 设置为默认路由，允许连接外网
NM_CONTROLLED="no" # 不使用 NetworkManager 来管理
IPADDR="192.168.1.100"
GATEWAY="192.168.1.1"
NETMASK="255.255.255.0"
```

```sh
# 重启网卡
$ sudo ifdown em1 && ifup em1
```

## 修改网卡名称

```sh
$ mv /etc/sysconfig/network-scripts/ifcfg-enp129s0f0 /etc/sysconfig/network-scripts/ifcfg-em1

$ sed -i 's|enp129s0f0|em1|g' /etc/sysconfig/network-scripts/ifcfg-em1

# 添加 net.ifnames=0 biosdevname=0
$ vi /etc/default/grub
GRUB_CMDLINE_LINUX="crashkernel=auto rd.md.uuid=6c6ea003:d9115b5c:52d4a47d:c7d6c6be rhgb quiet net.ifnames=0 biosdevname=0"

# 重新生成 grub 配置并更新内核参数
$ grub2-mkconfig -o /boot/grub2/grub.cfg

# 修改 udev 规则（注释原先的，ATTR{address} 是 MAC 地址）
$ vi /usr/lib/udev/rules.d/60-net.rules
ACTION=="add", SUBSYSTEM=="net", DRIVERS=="?*", ATTR{address}=="40:8d:5c:fa:ed:4a", NAME="em1"

# 重启
$ init 6
```

# CentOS Network

## 配置静态网络

```bash
$ # 查看网络接口（假设需要修改的网口是 em1）
$ ip addr show

$ vi /etc/sysconfig/network-scripts/ifcfg-em1
BOOTPROTO="static"
IPADDR="192.168.1.100"
GATEWAY="192.168.1.1"
NETMASK="255.255.255.0"
NM_CONTROLLED="no" # 不使用 NetworkManager 来管理
ONBOOT="yes" # 开机自启动该网口
```

## centos 7 修改网卡名称

```bash
$ mv /etc/sysconfig/network-scripts/ifcfg-enp129s0f0 /etc/sysconfig/network-scripts/ifcfg-em1

$ vi /etc/sysconfig/network-scripts/ifcfg-em1
NAME=em1
DEVICE=em1

# 添加 net.ifnames=0 biosdevname=0
$ vi /etc/default/grub
GRUB_CMDLINE_LINUX="crashkernel=auto rd.md.uuid=6c6ea003:d9115b5c:52d4a47d:c7d6c6be net.ifnames=0 biosdevname=0 rhgb quiet"

# 重新生成 grub 配置并更新内核参数
$ grub2-mkconfig -o /boot/grub2/grub.cfg

# 修改 udev 规则（注释原先的，ATTR{address} 是 MAC 地址）
$ vi /usr/lib/udev/rules.d/60-net.rules 
ACTION=="add", SUBSYSTEM=="net", DRIVERS=="?*", ATTR{address}=="40:8d:5c:fa:ed:4a", NAME="em1"

# 重启
$ init 6
```
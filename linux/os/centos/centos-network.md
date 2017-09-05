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


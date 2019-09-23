# Ubuntu 网络配置

查看网卡设备：

```sh
$ ip addr show
```

配置：

```sh
$ sudo vi /etc/network/interfaces
auto eth0
iface eth0 inet static
address 192.168.1.x
network 255.255.255.0
gateway 192.168.1.1
```

重启网卡：

```sh
$ sudo ifdown eth0 && ifup eth0
```

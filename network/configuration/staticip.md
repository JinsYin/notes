# Ubuntu 设置静态 IP

## 配置静态 IP

```bash
$ sudo vi /etc/network/intefaces
iface wlp2s0 inet static
address 192.168.1.200
gateway 192.168.1.1
netmast 255.255.255.0
```

## 重启网络

```bash
$ sudo service networking restart # 或 sudo /etc/init.d/networking restart
```

不行再重启机器
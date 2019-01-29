# IP 地址分析

```bash
$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 90:b1:1c:a5:42:7b brd ff:ff:ff:ff:ff:ff
    inet 192.168.16.2/24 brd 192.168.16.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::92b1:1cff:fea5:427b/64 scope link
       valid_lft forever preferred_lft forever
```

* `192.168.16.2`: IP 地址，共 32 位，4 个字节。
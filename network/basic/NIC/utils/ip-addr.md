# ip addr

```sh
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

| 关键输出                            | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `inet` 192.168.16.2/24              | [IP 地址](../README.md)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `scope` global / `scope` host       | * scope global：该网卡可以接收来自各个地方的包 <br/> * scope host：该网卡仅可以供本机相互通信                                                                                                                                                                                                                                                                                                                                                                                              |
| `lo`                                | 全称：**loopback**（环回接口），往往被分配 `127.0.0.1` 地址（用于本机通信，经过内核处理后直接返回，不会在任何网络中出现）                                                                                                                                                                                                                                                                                                                                                                  |
| `link/ether` 90:b1:1c:a5:42:7b      | MAC 地址                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `<BROADCAST,MULTICAST,UP,LOWER_UP>` | * 网络设备的状态标识（**net_device flags**） <br/> * `BROADCAST`：网卡开启了广播模式，有广播地址，可以收发广播包 <br/> * `MULTICAST`：网卡开启了多播模式，可以收发多播包 <br/> * `UP`：表示网卡已启动 <br/> * `LOWER_UP`：表示网线（L1）已连接                                                                                                                                                                                                                                             |
| `mtu` 1500                          | * 最大传输单元 MTU 为 1500 个字节，这是以太网的默认值 <br/> * MTU 是二层（MAC 层）的概念，以太网规定：MAC 头和正文（IP 头、TCP 头、HTTP 头和 HTTP 内容）加起来不允许超过 1500 个字节，如果放不下需要 **分片** 来传输                                                                                                                                                                                                                                                                       |
| `qdisc` pfifo_fast                  | * qdisc 的全称是 **queueing discipline**（排队规则） <br> * 内核如果需要通过某个网络接口发送数据包，需要按照该接口配置的 qdisc 把数据包加入队列 <br> * `qdisc pfifo`：不对进入的网络包作任何处理，数据包采用先进先出的方式通过 <br> * `qdisc pfifo_fast`：其队列包括三个波段（band），每个波段的优先级不同（`band 0` > `band 1` > `band 2`），波段里面采用先进先出的规则；数据包是按照服务类型（Type of Service，**TOS**）被分配到三个波段的，TOS 是 IP 头中的一个字段，用于表示包的优先级 |
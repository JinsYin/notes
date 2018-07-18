# Infiniband 命令行工具

## 安装工具

```bash
# [1]
$ yum install -y infiniband-diags

# [2]
$ yum install -y ibutils

# [3]
$ yum install -y rdma-core

# [4]
$ yum install -y qperf
```

## 连通测试命令（RDMA Verification）

### udaddy

```bash
# Server
$ udaddy
```

```bash
# Client（返回 0 表示是通的）
$ udaddy -s 10.0.10.100
udaddy: starting client
udaddy: connecting
initiating data transfers
receiving data transfers
data transfers complete
test complete
return status 0
```

### rdma_server、rdma_client [3]

```bash
# Server
$ rdma_server
```

```bash
# Client（返回 'end 0' 表示通的，'end -1' 表示不通）
$ rdma_client -s 10.0.10.100
rdma_client: start
rdma_client: end 0
```

### ibping - Ping 另一台 IB 设备

```bash
# Server
$ ibping -S
```

```bash
# Client（传递的是端口 GUID，不是节点 GUID 和系统 GUID，端口 GUID 可以使用 'iblinkinfo' 命令获取）
$ ibping -G 0x0002c903000d81f9
```

### ibdiagnet - 查看整个子网的诊断（diagnostic）信息

```bash
$ ibdiagnet -lw 4x -ls 5 -c 1000
```

## 性能测试命令

### qperf - 测量插槽与 RDMA 性能

```bash
# Server
$ qperf
```

```bash
# Client
# qperf SERVERNODE [OPTIONS] TESTS # SERVERNODE 可以是 hostname 或 IPoIB
$ qperf 10.0.10.100 tcp_bw tcp_lat # TCP/IP over IPoIB、带宽、延迟
tcp_bw:
    bw  =  1.17 GB/sec
tcp_lat:
    latency  =  14.5 us
```

### ib_send_bw - 测试 RDMA 发送处理确定带宽

```bash
$ ib_send_bw -a -c UD -d mlx4_0 -i 1
************************************
* Waiting for client to connect... *
************************************
```

```bash
$ ib_send_bw -a -c UD -d mlx4_0 -i 1 10.0.10.100
 Max msg size in UD is MTU 4096
 Changing to this MTU
---------------------------------------------------------------------------------------
                    Send BW Test
 Dual-port       : OFF      Device         : mlx4_0
 Number of qps   : 1        Transport type : IB
 Connection type : UD       Using SRQ      : OFF
 TX depth        : 128
 CQ Moderation   : 100
 Mtu             : 4096[B]
 Link type       : IB
 Max inline data : 0[B]
 rdma_cm QPs     : OFF
 Data ex. method : Ethernet
---------------------------------------------------------------------------------------
 local address: LID 0x04 QPN 0x021c PSN 0x3c8f30
 remote address: LID 0x05 QPN 0x021a PSN 0x45d83
---------------------------------------------------------------------------------------
 #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]
 2          1000             7.29               6.79           3.560575
 4          1000             14.65              14.43          3.782530
 8          1000             29.30              28.88          3.785967
 16         1000             58.59              57.79          3.787509
 32         1000             117.19             115.49         3.784499
 64         1000             285.54             254.16         4.164099
 128        1000             571.08             567.22         4.646647
 256        1000             1139.94            1022.73        4.189109
 512        1000             2279.88            2263.60        4.635849
 1024       1000             2456.73            2362.18        2.418869
 2048       1000             2816.97            2813.07        1.440289
 4096       1000             3019.29            3018.58        0.772757
---------------------------------------------------------------------------------------
```

## 常用 IB 命令

### ibstat、ibstatus - 查看 IB 网卡状态

```bash
$ ibstat
CA 'mlx4_0'
    CA type: MT26428 # 型号（MT：Mellanox Technologies）
    Number of ports: 1 # 端口号
    Firmware version: 2.9.1000 # 固件（Firmware）版本
    Hardware version: b0 # 硬件版本
    Node GUID: 0x0002c903000d7aac # 节点 GUID
    System image GUID: 0x0002c903000d7aaf # 系统镜像 GUID
    Port 1:
        State: Active # 端口状态（Active - 表示正确连接到了 Subnet Manager）
        Physical state: LinkUp # 物理状态（LinkUp - 表示网线已链接）
        Rate: 40 # （所有 IB 主机的）总速率，单位 Gb/s
        Base lid: 5
        LMC: 0
        SM lid: 4 # Subnet Manager 为该 IB 端口分配了 4 个 lid
        Capability mask: 0x0251086a
        Port GUID: 0x0002c903000d7aad
        Link layer: InfiniBand
```

```bash
$ ibstatus
Infiniband device 'mlx4_0' port 1 status:
    default gid: fe80:0000:0000:0000:0002:c903:000d:7aad
    base lid:    0x5
    sm lid:      0x4
    state:       4: ACTIVE
    phys state:  5: LinkUp
    rate:        40 Gb/sec (4X QDR)
    link_layer:  InfiniBand
```

### ibhosts、ibswitches、ibnodes - 查看 IB 网络上的所有主机（及交换机）

```bash
# 查看 IB 网络上的所有主机（从左至右：节点 GUID、IB 端口号、设备名称）
$ ibhosts
Ca: 0x0002c903000d7aac ports 1 "kube-node-100 HCA-1"
Ca: 0x0002c903000d81f8 ports 1 "centos-data-200 HCA-1"
Ca: 0x0002c903004d14a4 ports 1 "centos-data-201 HCA-1"
Ca: 0x0002c903000cc89a ports 1 "centos-data-202 HCA-1"
```

```bash
# 查看 IB 网络上的所有交换机（从左至右：节点 GUID、端口号、设备名称）
$ ibswitches
Switch: 0x0002c9020046c588 ports 36 "Infiniscale-IV Mellanox Technologies" base port 0 lid 2 lmc 0
```

```bash
# 上面两个命令的结合（推荐使用）
$ ibnodes
Ca: 0x0002c903000d7aac ports 1 "kube-node-100 HCA-1"
Ca: 0x0002c903004d14a4 ports 1 "centos-data-201 HCA-1"
Ca: 0x0002c903000cc89a ports 1 "centos-data-202 HCA-1"
Ca: 0x0002c903000d81f8 ports 1 "centos-data-200 HCA-1"
Switch: 0x0002c9020046c588 ports 36 "Infiniscale-IV Mellanox Technologies" base port 0 lid 2 lmc 0
```

### iblinkinfo - 查看 IB 网络上的链接信息

```bash
# 设备名称，端口 GUID，虚拟 lanes 的数量，信号传输速率，端口状态，物理状态，链接的设备（这里是交换机）
$ iblinkinfo
CA: centos-data-200 HCA-1:
    0x0002c903000d81f9      4    1[  ] ==( 4X          10.0 Gbps Active/ LinkUp)==>       2    3[  ] "Infiniscale-IV Mellanox Technologies" ( )
CA: centos-data-201 HCA-1:
    0x0002c903004d14a5      1    1[  ] ==( 4X          10.0 Gbps Active/ LinkUp)==>       2    2[  ] "Infiniscale-IV Mellanox Technologies" ( )
CA: centos-data-202 HCA-1:
    0x0002c903000cc89b      3    1[  ] ==( 4X          10.0 Gbps Active/ LinkUp)==>       2    1[  ] "Infiniscale-IV Mellanox Technologies" ( )
CA: kube-node-100 HCA-1:
    0x0002c903000d7aad      5    1[  ] ==( 4X          10.0 Gbps Active/ LinkUp)==>       2    4[  ] "Infiniscale-IV Mellanox Technologies" ( )
Switch: 0x0002c9020046c588 Infiniscale-IV Mellanox Technologies:
           2    1[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       3    1[  ] "centos-data-202 HCA-1" ( )
           2    2[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       1    1[  ] "centos-data-201 HCA-1" ( )
           2    3[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       4    1[  ] "centos-data-200 HCA-1" ( )
           2    4[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       5    1[  ] "kube-node-100 HCA-1" ( )
           2    5[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    6[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    7[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    8[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    9[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   10[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   11[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   12[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   13[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   14[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   15[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   16[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   17[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   18[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   19[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   20[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   21[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   22[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   23[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   24[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   25[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   26[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   27[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   28[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   29[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   30[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   31[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   32[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   33[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   34[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   35[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   36[  ] ==(                Down/ Polling)==>             [  ] "" ( )
```

## 参考

* [监视并排除 IB 设备故障](https://docs.oracle.com/cd/E26926_01/html/E25884/gjwwf.html)
* 参考：<https://wiki.archlinux.org/index.php/InfiniBand#Diagnosing_and_benchmarking>
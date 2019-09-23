# Perftest 包

`perftest` 包用于对 Mellanox OFED 进行性能测试，包含一组带宽和延迟基准测试：

## 测试之前

测试前，请先检查一下 IB 网卡和交换机的速率：

* IB 网卡

```sh
$ ibstatus
Infiniband device 'mlx4_0' port 1 status: # 该网卡已连接
    default gid: fe80:0000:0000:0000:0002:c903:0029:3e1f
    base lid:    0x6
    sm lid:      0x5
    state:       4: ACTIVE
    phys state:  5: LinkUp
    rate:        40 Gb/sec (4X QDR) # 正确速率
    link_layer:  InfiniBand

Infiniband device 'mlx4_0' port 2 status: # 该网卡未连接
    default gid: fe80:0000:0000:0000:0002:c903:0029:3e20
    base lid:    0x0
    sm lid:      0x0
    state:       1: DOWN
    phys state:  2: Polling
    rate:        10 Gb/sec (4X) # 不对，这跟 'lspci | grep Mellanox' 显示的是一个结果
    link_layer:  InfiniBand
```

* IB 交换机

```sh
$ ibswitches
Switch: 0x0002c9020046c588 ports 36 "Infiniscale-IV Mellanox Technologies" base port 0 lid 2 lmc 0
```

## InfiniBand / RoCE

* ib_send_bw
* ib_send_lat
* ib_write_bw
* ib_write_lat
* ib_read_bw
* ib_read_lat
* ib_atomic_bw
* ib_atomic_lat

### [ib_send_bw](https://community.mellanox.com/docs/DOC-2801)

```sh
# server (-R: 表示 rdma， 否则表示 Ethernet)
$ ib_send_bw -a -R --report_gbits

# client
$ ib_send_bw -a -R --report_gbits 10.0.10.210
```

测试结果：

```plain
                    Send BW Test
 Dual-port       : OFF    Device       : mlx4_0
 Number of qps   : 1    Transport type : IB
 Connection type : RC   Using SRQ      : OFF
 TX depth        : 128
 CQ Moderation   : 100
 Mtu             : 4096[B]
 Link type       : IB
 Max inline data : 0[B]
 rdma_cm QPs   : OFF
 Data ex. method : rdma_cm # 无 -R 则为 Ethernet
---------------------------------------------------------------------------------------
 local address: LID 0x06 QPN 0x0229 PSN 0x63d8d
 remote address: LID 0x03 QPN 0x0230 PSN 0x8bd154
---------------------------------------------------------------------------------------
 #bytes     #iterations    BW peak[Gb/sec]    BW average[Gb/sec]   MsgRate[Mpps]
 2          1000           0.083015            0.074187            4.636663
 4          1000             0.29               0.27               8.351176
 8          1000             0.58               0.47               7.352141
 16         1000             1.17               1.09               8.513369
 32         1000             2.29               2.09               8.161284
 64         1000             4.51               3.66               7.140200
 128        1000             9.23               8.39               8.194043
 256        1000             16.50              12.71              6.206522
 512        1000             21.87              16.85              4.113650
 1024       1000             23.53              21.28              2.597409
 2048       1000             24.01              23.98              1.463674
 4096       1000             25.55              25.44              0.776498
 8192       1000             26.48              26.48              0.404066
 16384      1000             26.81              26.71              0.203778
 32768      1000             27.11              27.11              0.103401
 65536      1000             27.28              27.23              0.051931
 131072     1000             27.26              27.26              0.025996
 262144     1000             27.28              27.28              0.013010
 524288     1000             27.33              27.33              0.006515
 1048576    1000             27.32              27.32              0.003257
 2097152    1000             27.33              27.33              0.001629
 4194304    1000             27.33              27.33              0.000814
 8388608    1000             27.33              27.33              0.000407
```

测试分析：当发送数据达到 `32KB` 时，带宽稳定在 `27Gbps` 左右，与期望的 `40Gbps` 差距较大。

### [ib_send_lat](https://community.mellanox.com/docs/DOC-2803)

```sh
# server
$ ib_send_lat -a

# client
$ ib_send_lat -a 10.0.10.210
```

测试结果：

```plain
                    Send Latency Test
 Dual-port       : OFF    Device         : mlx4_0
 Number of qps   : 1    Transport type : IB
 Connection type : RC   Using SRQ      : OFF
 TX depth        : 1
 Mtu             : 4096[B]
 Link type       : IB
 Max inline data : 236[B]
 rdma_cm QPs   : OFF
 Data ex. method : Ethernet
---------------------------------------------------------------------------------------
 local address: LID 0x06 QPN 0x022a PSN 0xf579a6
 remote address: LID 0x03 QPN 0x0231 PSN 0xe68e18
---------------------------------------------------------------------------------------
 #bytes #iterations    t_min[usec]    t_max[usec]  t_typical[usec]    t_avg[usec]    t_stdev[usec]   99% percentile[usec]   99.9% percentile[usec]
 2       1000          0.92           4.89         0.97              1.01         0.25           1.92                 4.89
 4       1000          0.93           5.43         0.97              1.02         0.30           1.55                 5.43
 8       1000          0.95           4.40         1.00              1.03         0.25           1.63                 4.40
 16      1000          0.94           5.04         0.99              1.02         0.26           1.57                 5.04
 32      1000          0.95           4.32         1.00              1.04         0.25           1.59                 4.32
 64      1000          1.02           4.92         1.06              1.10         0.26           1.68                 4.92
 128     1000          1.14           4.57         1.18              1.22         0.27           2.45                 4.57
 256     1000          1.85           5.54         1.92              1.96         0.22           2.50                 5.54
 512     1000          2.08           6.48         2.15              2.19         0.23           2.89                 6.48
 1024    1000          2.53           6.22         2.59              2.62         0.21           3.27                 6.22
 2048    1000          3.36           7.92         3.43              3.47         0.23           4.44                 7.92
 4096    1000          5.02           9.44         5.09              5.15         0.22           5.71                 9.44
 8192    1000          6.21           17.85        6.28              6.39         0.45           7.11                 17.85
 16384   1000          8.53           20.12        8.63              8.81         0.49           9.46                 20.12
 32768   1000          13.17          24.67        13.82             13.66        0.53           14.10                24.67
 65536   1000          23.15          34.14        23.39             23.40        0.40           23.54                34.14
 131072  1000          42.26          53.24        42.45             42.47        0.37           42.71                53.24
 262144  1000          80.46          91.49        80.73             80.76        0.36           81.08                91.49
 524288  1000          156.87         172.87       157.32            157.35       0.51           157.79               172.87
 1048576 1000          309.95         321.54       310.62            310.64       0.51           311.24               321.54
 2097152 1000          615.90         627.61       616.84            616.83       0.53           617.53               627.61
 4194304 1000          1228.43        1273.51      1229.76           1229.78      0.75           1231.00              1273.51
 8388608 1000          2569.32        2609.54      2576.83           2576.92      1.85           2579.82              2609.54
```

测试分析：当发送数据大于 `16KB` 时，随着数据量的成倍增加，延时也会相应的成倍增加。

### [ib_write_bw](https://community.mellanox.com/docs/DOC-2804)

```sh
# server
$ ib_write_bw -a --report_gbits

# client
$ ib_write_bw -a --report_gbits 10.0.10.210
```

测试结果：

```plain
                    RDMA_Write BW Test
 Dual-port       : OFF    Device         : mlx4_0
 Number of qps   : 1    Transport type : IB
 Connection type : RC   Using SRQ      : OFF
 TX depth        : 128
 CQ Moderation   : 100
 Mtu             : 4096[B]
 Link type       : IB
 Max inline data : 0[B]
 rdma_cm QPs   : OFF
 Data ex. method : Ethernet
---------------------------------------------------------------------------------------
 local address: LID 0x06 QPN 0x022c PSN 0x5986d9 RKey 0x10001101 VAddr 0x007fea1c50c000
 remote address: LID 0x03 QPN 0x0233 PSN 0xa31f6e RKey 0x50001101 VAddr 0x007f73219cf000
---------------------------------------------------------------------------------------
 #bytes     #iterations    BW peak[Gb/sec]    BW average[Gb/sec]   MsgRate[Mpps]
 2          5000           0.072576            0.071111            4.444451
 4          5000             0.28               0.28               8.812429
 8          5000             0.57               0.54               8.378408
 16         5000             1.13               1.12               8.745775
 32         5000             2.27               2.27               8.853746
 64         5000             4.52               4.29               8.374592
 128        5000             8.90               7.97               7.787260
 256        5000             17.67              17.00              8.302146
 512        5000             22.70              21.15              5.164394
 1024       5000             24.79              24.28              2.963820
 2048       5000             26.08              25.93              1.582454
 4096       5000             25.04              25.00              0.762896
 8192       5000             26.46              25.56              0.389942
 16384      5000             25.08              25.04              0.191030
 32768      5000             25.34              25.26              0.096344
 65536      5000             26.85              25.38              0.048400
 131072     5000             25.92              25.27              0.024099
 262144     5000             25.72              25.15              0.011991
 524288     5000             25.15              25.14              0.005994
 1048576    5000             25.19              25.14              0.002997
 2097152    5000             25.13              25.12              0.001497
 4194304    5000             25.25              25.21              0.000751
 8388608    5000             25.16              25.16              0.000375
```

测试分析：当写入数据量达到 `1KB` 时，带宽稳定在 `25Gbps` 左右，与期望的 `40Gbps` 差距较大。

### [ib_write_lat](https://community.mellanox.com/docs/DOC-2805)

```sh
# server
$ ib_write_bw -a --report_gbits

# client
$ ib_write_bw -a --report_gbits 10.0.10.210
```

测试结果：

```plain
                    RDMA_Write Latency Test
 Dual-port       : OFF    Device         : mlx4_0
 Number of qps   : 1    Transport type   : IB
 Connection type : RC   Using SRQ        : OFF
 TX depth        : 1
 Mtu             : 4096[B]
 Link type       : IB
 Max inline data : 220[B]
 rdma_cm QPs     : OFF
 Data ex. method : Ethernet
---------------------------------------------------------------------------------------
 local address: LID 0x06 QPN 0x022d PSN 0x1789e9 RKey 0x18001101 VAddr 0x007fec0f788000
 remote address: LID 0x03 QPN 0x0234 PSN 0xb5a682 RKey 0x58001101 VAddr 0x007fe6a63e3000
---------------------------------------------------------------------------------------
 #bytes #iterations    t_min[usec]    t_max[usec]  t_typical[usec]    t_avg[usec]    t_stdev[usec]   99% percentile[usec]   99.9% percentile[usec]
 2       1000          0.87           4.70         0.89              0.90         0.08           0.95                 4.70
 4       1000          0.87           1.98         0.89              0.89         0.03           0.92                 1.98
 8       1000          0.88           3.73         0.89              0.89         0.06           0.95                 3.73
 16      1000          0.88           3.42         0.89              0.90         0.04           0.92                 3.42
 32      1000          0.91           3.58         0.93              0.93         0.04           0.99                 3.58
 64      1000          0.95           2.77         0.97              0.97         0.04           1.03                 2.77
 128     1000          1.09           2.41         1.10              1.10         0.05           1.17                 2.41
 256     1000          1.80           3.02         1.84              1.84         0.04           1.94                 3.02
 512     1000          2.05           3.06         2.09              2.10         0.05           2.25                 3.06
 1024    1000          2.47           4.66         2.51              2.52         0.07           2.66                 4.66
 2048    1000          3.30           6.84         3.35              3.36         0.07           3.52                 6.84
 4096    1000          4.99           7.81         5.03              5.04         0.07           5.20                 7.81
 8192    1000          6.15           7.55         6.20              6.21         0.07           6.37                 7.55
 16384   1000          8.45           12.35        8.51              8.54         0.09           8.72                 12.35
 32768   1000          13.10          13.81        13.14             13.16        0.05           13.27                13.81
 65536   1000          22.99          23.63        23.09             23.10        0.05           23.27                23.63
 131072  1000          42.17          44.82        42.34             42.35        0.09           42.53                44.82
 262144  1000          80.40          86.89        80.68             80.69        0.11           80.92                86.89
 524288  1000          156.87         159.97       157.27            157.27       0.11           157.55               159.97
 1048576 1000          309.83         311.53       310.33            310.37       0.17           310.84               311.53
 2097152 1000          616.08         624.94       616.71            616.71       0.23           617.26               624.94
 4194304 1000          1228.54        1264.77      1229.79           1229.84      0.73           1230.98              1264.77
 8388608 1000          2569.25        2581.90      2572.40           2572.44      0.96           2574.77              2581.90
```

测试分析：当写入数据大于 `16KB` 时，随着数据量的成倍增加，延时也会相应的成倍增加。

### [ib_read_bw](https://community.mellanox.com/docs/DOC-2806)

```sh
# server
$ ib_read_bw -a --report_gbits

# client
$ ib_read_bw -a --report_gbits 10.0.10.210
```

```plain
                    RDMA_Read BW Test
 Dual-port       : OFF    Device         : mlx4_0
 Number of qps   : 1    Transport type : IB
 Connection type : RC   Using SRQ      : OFF
 TX depth        : 128
 CQ Moderation   : 100
 Mtu             : 4096[B]
 Link type       : IB
 Outstand reads  : 16
 rdma_cm QPs   : OFF
 Data ex. method : Ethernet
---------------------------------------------------------------------------------------
 local address: LID 0x06 QPN 0x022e PSN 0x42b739 OUT 0x10 RKey 0x20001101 VAddr 0x007fc861255000
 remote address: LID 0x03 QPN 0x0235 PSN 0xe70bde OUT 0x10 RKey 0x60001101 VAddr 0x007f1d92e7e000
---------------------------------------------------------------------------------------
 #bytes     #iterations    BW peak[Gb/sec]    BW average[Gb/sec]   MsgRate[Mpps]
 2          1000           0.068083            0.064915            4.057164
 4          1000             0.19               0.17               5.278197
 8          1000             0.38               0.34               5.314809
 16         1000             0.76               0.71               5.572609
 32         1000             1.47               1.27               4.966084
 64         1000             2.91               2.61               5.107116
 128        1000             5.90               5.23               5.102871
 256        1000             11.73              10.40              5.078640
 512        1000             24.03              21.73              5.305062
 1024       1000             25.38              23.56              2.876006
 2048       1000             23.57              23.57              1.438318
 4096       1000             23.96              23.95              0.730978
 8192       1000             24.33              24.19              0.369105
 16384      1000             24.17              24.14              0.184161
 32768      1000             24.92              24.34              0.092856
 65536      1000             24.30              24.28              0.046314
 131072     1000             24.53              24.53              0.023395
 262144     1000             24.43              24.35              0.011612
 524288     1000             24.25              24.25              0.005781
 1048576    1000             24.30              24.30              0.002897
 2097152    1000             24.27              24.27              0.001446
 4194304    1000             24.33              24.30              0.000724
 8388608    1000             24.30              24.26              0.000362
```

测试分析：当读取数据量达到 `1KB` 时，带宽稳定在 `24Gbps` 左右，与期望的 `40Gbps` 差距较大。

### [ib_read_lat](https://community.mellanox.com/docs/DOC-2807)

```sh
# server
$ ib_read_lat -a

# client
$ ib_read_lat -a 10.0.10.210
```

```plain
                    RDMA_Read Latency Test
 Dual-port       : OFF    Device         : mlx4_0
 Number of qps   : 1    Transport type : IB
 Connection type : RC   Using SRQ      : OFF
 TX depth        : 1
 Mtu             : 4096[B]
 Link type       : IB
 Outstand reads  : 16
 rdma_cm QPs   : OFF
 Data ex. method : Ethernet
---------------------------------------------------------------------------------------
 local address: LID 0x06 QPN 0x022f PSN 0xb6afbc OUT 0x10 RKey 0x28001101 VAddr 0x007f8b1c9e7000
 remote address: LID 0x03 QPN 0x0236 PSN 0x550eaa OUT 0x10 RKey 0x68001101 VAddr 0x007fa74103c000
---------------------------------------------------------------------------------------
 #bytes #iterations    t_min[usec]    t_max[usec]  t_typical[usec]    t_avg[usec]    t_stdev[usec]   99% percentile[usec]   99.9% percentile[usec]
 2       1000          1.70           7.97         1.74              1.76         0.05           1.91                 7.97
 4       1000          1.73           3.56         1.76              1.77         0.04           1.89                 3.56
 8       1000          1.72           7.95         1.76              1.77         0.08           1.92                 7.95
 16      1000          1.71           6.58         1.74              1.75         0.05           1.90                 6.58
 32      1000          1.72           7.03         1.75              1.77         0.09           1.91                 7.03
 64      1000          1.70           6.53         1.76              1.77         0.04           1.93                 6.53
 128     1000          1.77           6.50         1.80              1.82         0.08           2.03                 6.50
 256     1000          1.91           5.99         1.94              1.95         0.07           2.10                 5.99
 512     1000          2.12           16.49        2.16              2.20         0.48           2.33                 16.49
 1024    1000          2.56           6.27         2.59              2.60         0.05           2.74                 6.27
 2048    1000          3.38           6.15         3.42              3.45         0.08           3.75                 6.15
 4096    1000          5.13           21.15        5.18              5.22         0.36           5.37                 21.15
 8192    1000          6.31           21.31        6.36              6.47         0.42           7.08                 21.31
 16384   1000          8.63           10.66        8.68              8.83         0.23           9.45                 10.66
 32768   1000          13.26          29.38        13.75             13.60        0.67           14.12                29.38
 65536   1000          23.02          25.39        23.40             23.37        0.10           23.49                25.39
 131072  1000          42.01          43.92        42.08             42.12        0.11           42.43                43.92
 262144  1000          80.04          96.72        80.12             80.16        0.25           80.48                96.72
 524288  1000          156.10         190.99       174.22            171.44       9.32           185.89               190.99
 1048576 1000          308.26         362.45       344.89            342.01       10.07          359.92               362.45
 2097152 1000          612.94         717.63       686.60            686.54       14.04          713.12               717.63
 4194304 1000          1267.23        1406.69      1385.69           1379.55      18.35          1404.42              1406.69
 8388608 1000          2438.00        2797.60      2439.22           2472.09      98.03          2785.84              2797.60
```

测试分析：当读取数据大于 `16KB` 时，随着数据量的成倍增加，延时也会相应的成倍增加。

### [ib_atomic_bw](https://community.mellanox.com/docs/DOC-2802)

InfiniBand atomic bandwidth

```sh
# server
$ ib_atomic_bw

# client
$ ib_atomic_bw 10.0.10.210
```

测试结果：

```plain
                    Atomic FETCH_AND_ADD BW Test
 Dual-port       : OFF      Device         : mlx4_0
 Number of qps   : 1        Transport type : IB
 Connection type : RC       Using SRQ      : OFF
 TX depth        : 1000
 CQ Moderation   : 100
 Mtu             : 4096[B]
 Link type       : IB
 Outstand reads  : 16
 rdma_cm QPs     : OFF
 Data ex. method : Ethernet
---------------------------------------------------------------------------------------
 local address: LID 0x06 QPN 0x0233 PSN 0xc9cdc6
 remote address: LID 0x03 QPN 0x023a PSN 0xe6b65d
---------------------------------------------------------------------------------------
 #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]
 8          1000             17.01              16.94              2.220735
```

### [ib_atomic_lat](https://community.mellanox.com/docs/DOC-2809)

```sh
# server
$ ib_atomic_lat

# client
$ ib_atomic_lat 10.0.10.210
```

测试结果：

```plain
                    Atomic FETCH_AND_ADD BW Test
 Dual-port       : OFF      Device         : mlx4_0
 Number of qps   : 1        Transport type : IB
 Connection type : RC       Using SRQ      : OFF
 TX depth        : 1000
 CQ Moderation   : 100
 Mtu             : 4096[B]
 Link type       : IB
 Outstand reads  : 16
 rdma_cm QPs     : OFF
 Data ex. method : Ethernet
---------------------------------------------------------------------------------------
 local address: LID 0x06 QPN 0x0233 PSN 0xc9cdc6
 remote address: LID 0x03 QPN 0x023a PSN 0xe6b65d
---------------------------------------------------------------------------------------
 #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]
 8          1000             17.01              16.94              2.220735
```

## Native Ethernet

* [raw_ethernet_bw](https://community.mellanox.com/docs/DOC-2810)
* [raw_ethernet_lat](https://community.mellanox.com/docs/DOC-2811)
* [raw_ethernet_burst_lat](https://community.mellanox.com/docs/DOC-2812)

## 参考

* [Perftest Package](https://community.mellanox.com/docs/DOC-2802)

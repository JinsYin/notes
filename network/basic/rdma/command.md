# IB 命令

## 网卡状态

* ibstat

```sh
$ ibstat
CA 'mlx4_0' # 驱动名称
    CA type: MT26428 # 型号（MT：Mellanox Technologies）
    Number of ports: 2 # 端口数量
    Firmware version: 2.9.1000 # 固件（Firmware）版本
    Hardware version: b0 # 硬件版本
    Node GUID: 0x0002c90300293e1e # 节点 GUID
    System image GUID: 0x0002c90300293e21 # 系统镜像 GUID
    Port 1:
        State: Active # 端口状态（Active - 表示正确连接到了 Subnet Manager）
        Physical state: LinkUp # 物理状态（LinkUp - 表示网线已链接）
        Rate: 40 # （所有 IB 主机的）总速率，单位 Gb/s
        Base lid: 6
        LMC: 0
        SM lid: 5 # Subnet Manager 为该 IB 端口分配了 5 个 lid
        Capability mask: 0x02590868
        Port GUID: 0x0002c90300293e1f
        Link layer: InfiniBand
    Port 2:
        State: Down
        Physical state: Polling
        Rate: 10
        Base lid: 0
        LMC: 0
        SM lid: 0
        Capability mask: 0x02590868
        Port GUID: 0x0002c90300293e20
        Link layer: InfiniBand
```

* ibstatus

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

## 网卡、交换机

* ibhosts

```sh
# 查看 IB 网络上的所有主机（从左至右：节点 GUID、IB 端口号、设备名称）
$ ibhosts
Ca  : 0x0002c903000d7aac ports 1 "ip-160 HCA-1"
Ca  : 0x0002c903005925f0 ports 2 "ip-213 mlx4_0"
Ca  : 0x0002c90300293eba ports 2 "ip-212 mlx4_0"
Ca  : 0x0002c90300293e1e ports 2 "ip-211 mlx4_0"
Ca  : 0x0002c903000cc89a ports 1 "ip-210 mlx4_0"
```

* ibswitches

```sh
# 查看 IB 网络上的所有交换机（从左至右：节点 GUID、端口号、设备名称）
$ ibswitches
Switch  : 0x0002c9020046c588 ports 36 "Infiniscale-IV Mellanox Technologies" base port 0 lid 2 lmc 0
```

* ibnodes

```sh
# 上面两个命令的结合（推荐使用）
$ ibnodes
Ca  : 0x0002c903000d7aac ports 1 "ip-160 HCA-1"
Ca  : 0x0002c903005925f0 ports 2 "ip-213 mlx4_0"
Ca  : 0x0002c90300293e1e ports 2 "ip-211 mlx4_0"
Ca  : 0x0002c90300293eba ports 2 "ip-212 mlx4_0"
Ca  : 0x0002c903000cc89a ports 1 "ip-210 mlx4_0"
Switch  : 0x0002c9020046c588 ports 36 "Infiniscale-IV Mellanox Technologies" base port 0 lid 2 lmc 0
```

## 链路

* iblinkinfo

```sh
# 设备名称，端口 GUID，虚拟 lanes 的数量，信号传输速率，端口状态，物理状态，链接的设备（这里是交换机）
CA: ip-160 HCA-1:
      0x0002c903000d7aad      5    1[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       2   33[  ] "Infiniscale-IV Mellanox Technologies" ( )
CA: ip-213 mlx4_0:
      0x0002c903005925f1      9    1[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       2   16[  ] "Infiniscale-IV Mellanox Technologies" ( )
CA: ip-212 mlx4_0:
      0x0002c90300293ebb      8    1[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       2   14[  ] "Infiniscale-IV Mellanox Technologies" ( )
CA: ip-211 mlx4_0:
      0x0002c90300293e1f      6    1[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       2    1[  ] "Infiniscale-IV Mellanox Technologies" ( )
Switch: 0x0002c9020046c588 Infiniscale-IV Mellanox Technologies:
           2    1[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       6    1[  ] "ip-211 mlx4_0" ( )
           2    2[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    3[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    4[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    5[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    6[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    7[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    8[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2    9[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   10[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   11[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   12[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   13[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   14[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       8    1[  ] "ip-212 mlx4_0" ( )
           2   15[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   16[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       9    1[  ] "ip-213 mlx4_0" ( )
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
           2   33[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       5    1[  ] "ip-160 HCA-1" ( )
           2   34[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   35[  ] ==(                Down/ Polling)==>             [  ] "" ( )
           2   36[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       3    1[  ] "ip-210 mlx4_0" ( )
CA: ip-210 mlx4_0:
      0x0002c903000cc89b      3    1[  ] ==( 4X          10.0 Gbps Active/  LinkUp)==>       2   36[  ] "Infiniscale-IV Mellanox Technologies" ( )
```

* ibnetdiscover

```sh
vendid=0x2c9
devid=0xbd36
sysimgguid=0x2c9020046c58b
switchguid=0x2c9020046c588(2c9020046c588)
Switch  36 "S-0002c9020046c588"                     # "Infiniscale-IV Mellanox Technologies" base port 0 lid 2 lmc 0
[1]     "H-0002c90300293e1e"[1](2c90300293e1f)      # "ip-211 mlx4_0" lid 6 4xQDR
[14]    "H-0002c90300293eba"[1](2c90300293ebb)      # "ip-212 mlx4_0" lid 8 4xQDR
[16]    "H-0002c903005925f0"[1](2c903005925f1)      # "ip-213 mlx4_0" lid 9 4xQDR
[33]    "H-0002c903000d7aac"[1](2c903000d7aad)      # "ip-160 HCA-1" lid 5 4xQDR
[36]    "H-0002c903000cc89a"[1](2c903000cc89b)      # "ip-210 mlx4_0" lid 3 4xQDR

vendid=0x2c9
devid=0x673c
sysimgguid=0x2c903000d7aaf
caguid=0x2c903000d7aac
Ca  1 "H-0002c903000d7aac"                          # "ip-160 HCA-1"
[1](2c903000d7aad)  "S-0002c9020046c588"[33]        # lid 5 lmc 0 "Infiniscale-IV Mellanox Technologies" lid 2 4xQDR

vendid=0x2c9
devid=0x673c
sysimgguid=0x2c903005925f3
caguid=0x2c903005925f0
Ca  2 "H-0002c903005925f0"                          # "ip-213 mlx4_0"
[1](2c903005925f1)  "S-0002c9020046c588"[16]        # lid 9 lmc 0 "Infiniscale-IV Mellanox Technologies" lid 2 4xQDR

vendid=0x2c9
devid=0x673c
sysimgguid=0x2c90300293ebd
caguid=0x2c90300293eba
Ca  2 "H-0002c90300293eba"                          # "ip-212 mlx4_0"
[1](2c90300293ebb)  "S-0002c9020046c588"[14]        # lid 8 lmc 0 "Infiniscale-IV Mellanox Technologies" lid 2 4xQDR

vendid=0x2c9
devid=0x673c
sysimgguid=0x2c90300293e21
caguid=0x2c90300293e1e
Ca  2 "H-0002c90300293e1e"                          # "ip-211 mlx4_0"
[1](2c90300293e1f)  "S-0002c9020046c588"[1]         # lid 6 lmc 0 "Infiniscale-IV Mellanox Technologies" lid 2 4xQDR

vendid=0x2c9
devid=0x673c
sysimgguid=0x2c903000cc89d
caguid=0x2c903000cc89a
Ca  1 "H-0002c903000cc89a"                          # "ip-210 mlx4_0"
[1](2c903000cc89b)  "S-0002c9020046c588"[36]        # lid 3 lmc 0 "Infiniscale-IV Mellanox Technologies" lid 2 4xQDR
```

## 设备

* ibv_devinfo

```sh
$ ibv_devinfo
hca_id: mlx4_0 # 驱动名称
    transport:          InfiniBand (0)
    fw_ver:             2.9.1000 # Firmware version
    node_guid:          0002:c903:0029:3e1e
    sys_image_guid:     0002:c903:0029:3e21
    vendor_id:          0x02c9
    vendor_part_id:     26428
    hw_ver:             0xB0
    board_id:           MT_0D81120009 # IB 卡 PSID
    phys_port_cnt:      2
        port:   1 # 连接
            state:          PORT_ACTIVE (4)
            max_mtu:        4096 (5)
            active_mtu:     4096 (5)
            sm_lid:         5
            port_lid:       6
            port_lmc:       0x00
            link_layer:     InfiniBand # 如果是 RoCE 或 iWARP，这里应该是 Ethernet

        port:   2 # 断开
            state:          PORT_DOWN (1)
            max_mtu:        4096 (5)
            active_mtu:     4096 (5)
            sm_lid:         0
            port_lid:       0
            port_lmc:       0x00
            link_layer:     InfiniBand
```

* ibdev2netdev

```sh
# IB 卡端口映射到网络设备
$ ibdev2netdev
mlx4_0 port 1 ==> ib0 (Up)

$ ibdev2netdev -v
mlx4_0 (mt26428 - MT1037X01146) KESTREL        QDR             fw 2.9.1000 port 1 (ACTIVE) ==> ib0 (Up)
```

* ibv_devices

```sh
$ ibv_devices
device                 node GUID
------              ----------------
mlx4_0              0002c903000cc89a
```

* 其他

```sh
# ib0
$ cat /sys/class/net/ib0/dev_id
0x0

$ cat /sys/class/net/ib0/dev_port
0

$ cat /sys/class/net/ib0/device/infiniband_verbs/uverbs0/ibdev
mlx4_0
```

## Mellanox Driver Modules

```sh
$ lsmod | grep devlink
devlink                42368  3 mlx4_en,mlx4_ib,mlx4_core
```

## 参考

* [监视并排除 IB 设备故障](https://docs.oracle.com/cd/E26926_01/html/E25884/gjwwf.html)
* [Diagnosing and benchmarking](https://wiki.archlinux.org/index.php/InfiniBand#Diagnosing_and_benchmarking)
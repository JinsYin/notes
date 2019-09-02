# 性能调优

> 最高性能配置并不适合所有应用程序，因为它需要消耗大量的功率（电力）；但对于基准测试和性能要求比较高的集群，依然建议使用性能配置。

## 系统配置

### PCIe Capabilities

推荐的 PCIe 配置：

| Name             | Value     |
| ---------------- | --------- |
| PCIe Generation  | 3.0       |
| Speed            | 8GT/s     |
| Width            | x8 or x16 |
| Max Payload size | 256       |
| Max Read Request | 4096      |

检查：

```sh
# 检查 PCIe 版本、速率和宽度
$ lspci -s 82:00.0 -vvv | grep "Vendor specific"

# 检查 MaxPayload 和 MaxReadReq
$ lspci -s 82:00.0 -vvv | grep MaxReadReq
MaxPayload 256 bytes, MaxReadReq 4096 bytes
```

## BIOS 性能调优

BIOS 调优参数（如有必要可以升级 BIOS）：

| 参数                      | 描述                                            |
| ------------------------- | ----------------------------------------------- |
| Power                     | 配置电源为最大功率以获得最佳性能                |
| P-State                   | 建议禁用                                        |
| C-State                   | 建议禁用                                        |
| Turbo Mode                |                                                 |
| Hyper Threading           | 允许 CPU 同时处理多个数据流，从而提高性能和效率 |
| IO Non Posted Prefetching | 与 haswell/broadwell 相关，应该禁用             |
| CPU Frequency             | 最大速度为最高性能                              |
| Memory Speed              | 最大速度为最高性能                              |
| Memory channel mode       | 使用 **independent** 模式获得性能               |
| Node Interleaving         | 建议禁用                                        |
| Channel Interleaving      |                                                 |
| Thermal Mode              | 开启                                            |
| HPC Optimizations         | 仅在 AMD 处理器中受到支持                       |

* [Understanding BIOS Configuration for Performance Tuning](https://community.mellanox.com/docs/DOC-2488)
* [BIOS Performance Tuning Example for Dell PowerEdge R730](https://community.mellanox.com/docs/DOC-2631) - 推荐
* [BIOS Performance Tuning Example](https://community.mellanox.com/docs/DOC-2297)
* [BIOS Tuning](https://community.mellanox.com/docs/DOC-2797#jive_content_id_BIOS_Tuning)

## PCIe 配置

* PCIe 宽度

PCIe 宽度决定了设备可以并行使用的 PCIe 通道数，如宽度为 `x8`，则表示有 8 条通道（lane）。

```sh
# x4 表明有 4 条通道
$ lspci -s "04:00.0" -vvv | grep Width
LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <64us
LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
```

* PCIe 速率

PCIe 速率以 `GT/s` 为单位，表示“每秒钟十亿次传输”，它和 PCIe 宽度共同确定了 PCIe 的最大带宽（bindwidth = speed * width）。

```sh
# 8GT/s 指的是 PCIe 3.0 的原始速率（capabilities and status）
$ lspci -s "04:00.0" -vvv | grep Speed
LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <64us
LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis
```

* PCIe Max Playload Size

PCIe 最大有效负载大小决定了 PCIe 数据包的最大大小或 PCIe MTU 的最大大小（类似于网络协议）。这意味着较大的 PCIe 传输会被分解为 PCIe MTU 大小的数据包。该参数仅由系统设置，并取决于芯片组架构（x86_64, Power8, ARM 等）

```sh
# MaxPayload 256 bytes
$ lspci -s "04:00.0" -vvv | grep DevCtl: -C 2
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 25.000W
DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
        MaxPayload 256 bytes, MaxReadReq 4096 bytes
```

* PCIe Max Read Request

PCIe Max Read Request 确定允许的最大 PCIe 读取请求。

```sh
$ lspci -s "04:00.0" -vvv | grep MaxReadReq
MaxPayload 256 bytes, MaxReadReq 4096 bytes
```

不同于其他参数，该参数可以通过 `setpci` 命令进行修改：

```sh
# 先查询该值，避免覆盖
$ setpci -s "04:00.0" 68.w
5936 # 第一个数字是 PCIe Max Read Request selector

# 设置 selector index
$ setpci -s "04:00.0" 68.w=2936

# 值应该被更新
$ lspci -s "04:00.0" -vvv | grep MaxReadReq
```

可接受的值：0 - 128B, 1 - 256B, 2 - 512B, 3 - 1024B, 4 - 2048B and 5 - 4096B.

* 计算 PCIe 限制

PCIe 的性能很可能会影响到 IB 网卡的性能。PCIe 传输数据包括网络数据包有效负载和报头，所以计算 PCIe 限制时需要考虑它们，减去 1Gb/s 是为了用于纠错协议和 PCIe 报头开销。

```plain
Maximum PCIe Bandwidth = SPEED * WIDTH * (1 - ENCODING) - 1Gb/s
```

```sh
# PCIe 3.0 (8GT/s) x4 width
> Maximum PCIe Bandwidth = 8G * 4 * (1 - 2/130) - 1G = ~30.5Gb/s

# PCIe 2.0 (4GT/s) x8 width
> Maximum PCIe Bandwidth = 4G * 8 * (1 - 1/5) - 1G = 31Gb/s
```

* [Understanding PCIe Configuration for Maximum Performance](https://community.mellanox.com/docs/DOC-2496)

## 网卡性能调优

* [Getting started with Performance Tuning of Mellanox adapters](https://community.mellanox.com/docs/DOC-2490)
* [Performance Tuning for Mellanox Adapters](https://community.mellanox.com/docs/DOC-2489)

## 网络性能调优

* [Red Hat Enterprise Linux Network Performance Tuning Guide](https://community.mellanox.com/docs/DOC-2649)

## 系统调优

* 禁用所有不必要的服务

```plain
systemctl disable cups gpm ip6tables mdmonitor mdmpd bluetooth iptables irqbalance sysstat
```

* 启用以下服务

```sh
systemctl start cpuspeed nscd crond ntpd ntp network tuned
systemctl enable cpuspeed nscd crond ntpd ntp network tuned
```

* 设置 system profile 为了网络性能和延迟

```sh
$ tuned-adm profile latency-performance
$ cpupower frequency-set --governor performance

# 检查是否调整正常
$ tuned-adm active
Current active profile: latency-performance
```

* 系统参数

```sh
# 重启或运行 sysctl -p 立即生效（添加时记得把注释删除）
$ vi /etc/sysctl.conf
kernel.numa_balancing=0 # 关闭 numa-balancing
kernel.sched_min_granularity_ns=100000000 # 减少系统调度
kernel.sched_migration_cost_ns=50000000 # 减少系统调度
vm.swappiness=0
vm.zone_reclaim_mode=0
net.ipv4.tcp_timestamps=0
net.ipv4.tcp_sack=1
net.core.netdev_max_backlog=250000
net.core.rmem_max=4194304
net.core.wmem_max=4194304
net.core.rmem_default=4194304
net.core.wmem_default=4194304
net.core.optmem_max=4194304
net.ipv4.tcp_rmem=4096 87380 4194304
net.ipv4.tcp_wmem=4096 65536 4194304
net.ipv4.tcp_low_latency=1
net.ipv4.tcp_adv_win_scale=1
```

```sh
echo never > /sys/kernel/mm/transparent_hugepage/enabled
```

### Idle Loop and IP Forwarding

* Kernel Idle Loop Tuning

**mlx4_en** 内核模块有一个可选参数，可以调整内核空闲循环以获得更好的延迟。这将改善 CPU 唤醒实际，但可能会导致更高的功耗。

```sh
$ vi /etc/modprobe.d/mlx4_core.conf
options mlx4_core enable_sys_tune=1
```

* Multi-Threaded IP Forwarding Tuning

要将 NIC 使用优化为 IP 转发：

```sh
$ vi /etc/modprobe.d/mlx4_core.conf
# 优化为支持 IP 转发
options mlx4_en inline_thold=0
options mlx4_core log_num_mgm_entry_size=-7
# 优化 steering
options mlx4_en inline_thold=0
options mlx4_core log_num_mgm_entry_size=-7
```

最后，重启 driver：

```sh
rmmod mlx4_en mlx4_core
modprobe mlx4_en mlx4_core
```

* [Linux sysctl Tuning](https://community.mellanox.com/docs/DOC-2821)

## Receive Packet Steering（RPS）

当 IPoIB 使用 `connected` 模式时，它只有一个 rx 队列。

开启 RPS：

```sh
$ cat /sys/class/net/ib0/device/local_cpus
00000000,00000000,00000000,00000000,00000000,000aaaaa

$ cat /sys/class/net/ib0/queues/rx-0/rps_cpus
00000000,00000000,00000000,00000000,00000000,00000000

$ LOCAL_CPUS=`cat /sys/class/net/ib0/device/local_cpus`
$ echo $LOCAL_CPUS > /sys/class/net/ib0/queues/rx-0/rps_cpus
```

## Checking Core Frequency

在使用 `perftest` 软件包的工具对 IB 网络进行压测时总是出现：

```plain
Conflicting CPU frequency values detected: 2399.938000 != 1200.036000. CPU Frequency is not max.
```

需要检查每个 core 的频率是否一致且等于最大值：

```sh
# 检查支持的最大 CPU 频率
$ cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_max_freq

# 检查每个 core 的频率是否一致
$ cat /proc/cpuinfo | grep "cpu MHz"

# BOIS

# 查看当前值
$ cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq
```

* [Checking Core Frequency](https://www.mellanox.com/related-docs/prod_software/Performance_Tuning_Guide_for_Mellanox_Network_Adapters_Archive.pdf)

## 参考

* [Performance Tuning Guidelines for Mellanox Network Adapters](https://www.mellanox.com/related-docs/prod_software/Performance_Tuning_Guide_for_Mellanox_Network_Adapters_Archive.pdf)
* [BIOS Performance Tuning Example for Dell PowerEdge R730](https://community.mellanox.com/docs/DOC-2631)
* [Performance Tuning for Mellanox Adapters](https://community.mellanox.com/docs/DOC-2489)
* [HowTo Set Dell PowerEdge R730 BIOS parameters to support SR-IOV](https://community.mellanox.com/docs/DOC-2249)
* [SR-IOV](https://en.wikipedia.org/wiki/Single-root_input/output_virtualization)
# RAID

RAID 是 Redundant Array of indenpensive Disk 的缩写，即冗余磁盘阵列。也就是把多个磁盘组成一个逻辑扇区，数据以分段（striping）的方式存储在不同的磁盘中。

## 优点

* 提高了存取速率
* 容错，即数据安全性

## 数据分发策略

* 条带（Striping） - RAID 0
* 镜像（Mirroring） - RAID 1
* 纠删码（Erasure Code） - RAID 5、RAID 6

## RAID 分类

* **硬 RAID**：利用 RAID 卡来实现；需要内核支持其驱动
* **软 RAID**：利用内核中的 MD（Multiple Devices）模块实现；设备代号为 `/dev/md*`；RedHat 及其发行版使用 `mdamd` 工具管理 RAID，配置文件位于 `/etc/mdamd.conf`

> **软 RAID** 对磁盘控制的功能及性能都不及 **硬 RAID**

## RAID 级别

| RAID Level       | 描述                                                                                                     |
| ---------------- | -------------------------------------------------------------------------------------------------------- |
| RAID-0(striping) | 将磁盘切分成等量的区块（chunk，4K ~ 1M），写入文件时将文件按 chunk 大小切割并依序交错存储到各个磁盘中    |
| RAID-1(mirror)   | 同一份数据，完整地保存在所有磁盘上                                                                       |
| RAID-5           | 分块写入过程中，在每块磁盘中加入一个奇偶校验数据（parity），以记录其他盘的备份数据，用于磁盘故障时的恢复 |
| RAID-6           | RAID-6 使用两块磁盘的容量作为 parity 的储存                                                              |
| RAID-10          |                                                                                                          |

比较：

| Level   | 最少磁盘数 | 磁盘利用率 | 最大容错盘数 | 理论写性能 | 理论读性能 |
| ------- | ---------- | ---------- | ------------ | ---------- | ---------- |
| RAID-0  | 2          | n          | 无           | n          | n          |
| RAID-1  | 2          | 1          | n-1          | 1          | n          |
| RAID-5  | 3          | 1 - 1/n    | 1            | <n-1       | <n-1       |
| RAID-6  | 4          | 1 - 2/n    | 2            | <n-2       | <n-2       |
| RAID-10 | 4          | n/2        | n/2          | n/2        | n          |

## 管理 `软件 RAID`

主流 Linux 发行版都已将 MD 驱动模块编译到内核中或编译为可动态加载的驱动模块。

```sh
# 查看是否加载了 MD 驱动
$ cat /proc/mdstat
Personalities : [raid1]
md127 : active raid1 sdc1[1] sdb1[0]
    117219200 blocks super 1.0 [2/2] [UU]
    bitmap: 0/1 pages [0KB], 65536KB chunk
```

```sh
# 查看是否有 MD 块设备
$ cat /proc/devices | grep md
  9 md
254 mdp
```

```sh
# 查看是否加载了 md_mod 内核模块
$ lsmod | grep md

# 如果没有，则手动加载
$ modprobe md_mod
```

## 参考

* [软件磁盘阵列（Software RAID）](https://wizardforcel.gitbooks.io/vbird-linux-basic-4e/content/126.html)
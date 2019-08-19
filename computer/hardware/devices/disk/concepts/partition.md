# 磁盘分区

每块物理磁盘可以划分出一个或多个分区，分区之间相互独立、互不重叠，内核则将每个分区视为单独的设备（默认位于 `/dev` 目录）。

## 分区表（Partition Table）

* MBR/DOS/MSDOS
* EBR
* GPT
* Apple Partition Map (APM)

## 分区布局（Partition Layout）

磁盘分区可以容纳任何类型的信息，但通常只会包含以下内容之一：

| 分区内容                | 描述                                                       |
| ----------------------- | ---------------------------------------------------------- |
| 文件系统（File System） | 用来存放常规文件                                           |
| 数据区域（Data Area）   | 可作为裸磁盘对其进行访问                                   |
| 交换区域（Swap Area）   | 供内核的内存管理使用（参考 `mkswap`、`swapon`、`swapoff`） |
| 引导分区                |                                                            |

```graph
                              +---------------+
                              |  File System  |
                              +---------------+
                              ^               ^
                              |               |
              +---------------+---------------+---------------+
              |  Partition 0  |  Partition 1  |  Partition 2  |    Disk
              +---------------+---------------+---------------+
              |               |               |               |
              v               v               v               v
              +---------------+               +---------------+
              |   Data Area   |               |   Swap Area   |
              +---------------+               +---------------+
```

> “一对一” 关系：一个磁盘分区容纳一个文件系统等

## 多个分区的目的

* 创建不同的文件系统；其类型、大小以及参数设置（如逻辑块大小）都可以有所不同

## 相关命令

* [fdisk]() - 操作磁盘分区的编号、大小和类型
* [mkswap]()
* [swapon]()
* [swapoff]()

## 示例

```sh
# 列出所有磁盘分区
$ fdisk -l
```

```sh
# 记录了每个磁盘分区的主设备号、副设备号、大小和名称
$ cat /proc/partitions
major minor  #blocks  name

   7        0     166764 loop0
   7        1      88980 loop1
   7        2      89024 loop2
   7        3      88964 loop3
   7        4     391672 loop4
   7        5     176632 loop5
   7        6     259556 loop6
   7        7     346216 loop7
   8        0  976762584 sda
   8        1  104859648 sda1
   8        2  564700160 sda2
   8        3  307197952 sda3
   8       16  117220824 sdb
   8       17  117218304 sdb1
  11        0    1048575 sr0
```

```sh
# 查看当前系统已激活的交换区域的信息，包括每个交换区域的大小，以及在使用交换区域的个数
$ cat /proc/swaps
Filename			          	Type		Size	    Used	Priority
/home/yin/mnt/sda1/swap   file		20971516	0	    -1
```

## 参考

* [How to setup Windows/Linux Dual Boot](https://www.akadia.com/services/dual_boot.html)
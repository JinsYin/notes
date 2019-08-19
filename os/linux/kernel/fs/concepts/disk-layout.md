# 磁盘布局

## 文件系统磁盘布局

[磁盘分区](../../../../computer/hardware/devices/disk/partition.md) 与文件系统之间的大致关系：

```graph
             +-------------+-------------+-------------+
             |  Partition  |  Partition  |  Partition  |    Disk
             +-------------+-------------+-------------+
                           |             |
                           v             v
+--------------------------+             +--------------------------+
v                                                                   v
+------------+-------------+-------------+--------------------------+
| Boot Block | Super Block | Inode Table |          Data Blocks     |    File system
+------------+-------------+-------------+--------------------------+
```

## 文件系统基本结构

文件系统组成部分（均指逻辑块）：

| 组成部分                | 描述                                                                                                                                                                                                         |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 引导块（Boot Block）    | 位于文件系统的第一个逻辑块（即前几个扇区）；引导块包含加载操作系统的初始化引导程序，不被文件系统所使用；操作系统虽然只需一个引导块，但所有文件系统都设有引导块（绝对部分都未使用）                           |
| 超级块（Super Block）   | 紧随引导块之后的一个独立块，存放文件系统的状态信息（见 `man stat`），包括但不限于：<br> * inode 表的容量 <br> * 逻辑块的大小 <br> * 文件系统的总大小（以逻辑块来计算）<br> * 根目录的 inode 编号             |
| inode 表（Inode Table） | 文件系统中的每个文件都有且只有一个 inode，对应于 inode 表（线性表）中一条唯一的记录；inode 由 “inode 编号” 来标识；inode 表的起始编号是 1（用于记录文件系统的坏块），而非 0 ，因为 0 表明该 inode 尚未被使用 |
| 数据块（Data Blocks）   | 存储文件数据块的数据区域；文件系统的大部分空间都是数据块，以存放驻留于文件系统之上的文件                                                                                                                     |

## 示例

* 查询文件系统类型

```sh
$ df -Th | grep "^/dev/sd"
/dev/sdb1   ext4    110G    99G    6.3G    95%    /
/dev/sda1   xfs     100G    28G     73G    28%    /home/yin/mnt/sda1
```

* 查询物理块（扇区）大小

```sh
# 逻辑扇区大小 & 物理扇区大小
$ sudo fdisk -l /dev/sda | grep -i "sector size"
Sector size (logical/physical): 512 bytes / 4096 bytes

# 物理扇区大小
$ DISK=sda && cat /sys/block/$DISK/queue/physical_block_size
4096

# 逻辑扇区大小
$ sudo blockdev --getss /dev/sda # sda == sda1 == sda2 == ...
$ DISK=sda && cat /sys/block/$DISK/queue/logical_block_size
512
```

* 查询文件系统块大小

```sh
# 当前目录所在的文件系统
$ stat -f . | grep -i "block size"
Block size: 4096       Fundamental block size: 4096

$ sudo blockdev --getbsz /dev/sda1 # sda = sda1 != sda2（!= 表示不一定等于）
4096
```

## 参考

* [How to Find the Block Size](http://www.linfo.org/get_block_size.html)
* [Sectors versus blocks](https://en.wikipedia.org/wiki/Disk_sector#Sectors_versus_blocks)
* [Block (data storage)](https://en.wikipedia.org/wiki/Block_(data_storage))
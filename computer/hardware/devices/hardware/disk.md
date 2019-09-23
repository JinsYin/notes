# 磁盘管理

## 查看磁盘

```sh
# 磁盘、分区、容量、扇区个数、扇区大小、分区表
$ fdisk -l

# 磁盘、分区、容量、挂载
$ lsblk

# 分区、UUID、LABEL、FS Type
$ blkid
```

## 磁盘类型

有时候我们需要判断磁盘到底是硬盘（`HDD`）还是 `SSD`，其中 NVME SSD 也属于 SSD，但其盘符通常以 nvme 开头。

```sh
# 0: SSD; 1: HDD
$ cat /sys/block/sdX/queue/rotational
```

```sh
# ROTA: rotational device
$ lsblk -d -o name,rota
NAME    ROTA
sda        0
sdb        0
sdc        1
sdd        1
sde        1
sdf        1
sdg        1
sdh        1
sdi        1
sdj        1
nvme0n1    0
```

## 格式化

```sh
# 格式化分区（如果需要格式化整个磁盘且该盘已有分区表，需要使用 -f 强制擦除）
$ mkfs.xfs /dev/sdb1 # 或 mkfs -t xfs /dev/sdb1
```

## 挂载、卸载

```sh
# 查看挂载及文件系统信息
$ mount -l
```

```sh
# 查看磁盘挂载及容量信息
$ df -h
```

```sh
# 临时手动挂载
$ mount /dev/sdb1 (-c) /mnt/sdb1 # -c: 检测磁盘坏道
```

```sh
# 开机自动挂载
# 第一个数字表示dump选项：0不备份，1备份，2备份（比1重要性小）
# 第二个数字表示是否在启动是用 fsck 校验分区：０不校验，１校验，２校验（比１晚校验）
$ echo "/dev/sdb1 /mnt/sdb1 xfs defaults 0 0" >> /etc/fstab

# 不推荐上诉方法，原因是系统重启可能导致盘符发生改变，通常使用分区 UUID
$ blkid | grep /dev/sdb1 # 获取分区 UUID
$ echo "UUID=93qxDO-BL2x-j6Aj-EAkd-Cjko-ze21-8LKbGM /mnt/sdb1 xfs defaults 0 0" >> /etc/fstab
```

```sh
# 卸载盘
$ umount /dev/sdb

# 卸载分区
$ umount /dev/sdb1
```

## 擦除磁盘、擦除分区表、清空所有数据

```sh
# bs: block size
$ dd if=/dev/zero of=/dev/sdX bs=512 count=1
```

> <https://www.cyberciti.biz/faq/linux-remove-all-partitions-data-empty-disk/>

## 分区

### 分区表（partition table）

分区表：将大表的数据分成称为分区的子集，类型有 `ext4`、`xfs`、`ntfs`、`fat32`。

分区表格式及特点：

| 类型/格式          | 支持的最大卷 | 支持的最大分区数                   |
| ------------------ | ------------ | ---------------------------------- |
| MBR（主引导记录）  | 2TB          | `4 主` 或 `3 主 + 1 扩展 + ∞ 逻辑` |
| GPT（GUID 分区表） | 18EB         | 128                                |

```sh
# 查看磁盘扇区大小
$ fdisk -l /dev/sdb | grep -i 'sector size'
Sector size (logical/physical): 512 bytes / 512 bytes
```

### fdisk

`fdisk` 只支持 MBR 分区表，所以存在诸多限制。

```sh
# 对整个数据盘进行分区
$ fdisk /dev/sdb
> a  # 开关引导项（bootable flag）
> d  # 删除一个分区
> l  # 列出支持的分区类型
> m  # 打印
> n  # 创建一个分区
> p  # 打印分区表信息
> q  # 不保存退出
> t  # 修改一个分区的 system id
> w  # 写入分区表到磁盘并退出
```

常见应用：

```sh
# 创建一个新的主分区（如果已有，需要先删除主分区）
`n`，`p`，`1`，`Enter`，`Enter`，`wq`

# 为分区设置引导项（使用 fdisk -l 查看该分区的 boot 列是否增加了一个 *）
`a`，`1`，`wq`
```

### parted

`parted` 工具使用 GNU 分布的，支持 GPT 分区表。

```sh
# RHEL/CentOS
$ yum install -y parted

# Debian/Ubuntu
$ apt-get install -y parted
```

```sh
$ parted /dev/sdb
> help    # 帮助；查看某个命令的信息：help mkpart
> quit    # 退出
> mklabel/mktable LABEL-TYPE # 创建一个新的分区表；LABEL-TYPE：aix, amiga, bsd, dvh, gpt, mac, msdos, pc98, sun, loop
> mkpart PART-TYPE [FS-TYPE] START END  # 创建一个分区；分区类型：primary、logical、extended；START/END：分区的起始/结束位置（单位支持 K、M、G、T，或者百分比）
> select DEVICE # 选择磁盘设备进行编辑
> align-check TYPE N # 检查分区是否对齐；TYPE：{min|opt}，opt（optimal）；N：分区编号
> print   # 查看当前分区情况
```

常见应用：

```sh
# 创建 GPT 分区表
mklabel gpt

# 创建一个 0KB ~ 500GB 的主分区（没有对齐分区）
mkpart primary xfs 0KB 500GB

# 将整个磁盘创建一个分区（有对齐分区：从第 2048 个扇区开始）
mkpart primary xfs 2048s 100%

# 删除分区（print 查看分区号）
rm 1

quit
```

对齐分区：

```sh
# 分区时常遇到如下问题
# Warning: The resulting partition is not properly aligned for best performance.

# 获取阵列的 alignment 参数
optimal_io_size=`cat /sys/block/sdb/queue/optimal_io_size`
minimum_io_size=`cat /sys/block/sdb/queue/minimum_io_size`
alignment_offset=`cat /sys/block/sdb/alignment_offset`
physical_block_size=`cat /sys/block/sdb/queue/physical_block_size`

echo $optimal_io_size
echo $alignment_offset
echo $minimum_io_size
echo $physical_block_size

# 分区起始点（单位：s，即 sector，扇区）
# 没有优化的系统其 optimal_io_size 为 0，所以结果也为 0，这种情况直接设置为 2048s
$ start=$((($optimal_io_size + $alignment_offset) / $physical_block_size))

> mkpart primary xfs 2048s 100%
> align-check optimal 1 # 检查分区是否对齐（返回 aligned 即对齐）
```

> <https://zhidao.baidu.com/question/620202831535071412.html>
> <https://rainbow.chard.org/2013/01/30/how-to-align-partitions-for-best-performance-using-parted/>

## 磁盘性能测试

| 硬盘类型 | 速度     |
| -------- | -------- |
| SATA     | <150 M/s |
| SCSI     | <200 M/s |
| SAS      | ~200 M/s |
| SSD      | ~500 M/s |

```sh
# 测试随机写 IOPS
$ fio -direct=1 -iodepth=128 -rw=randwrite -ioengine=libaio -bs=4k -size=1G -numjobs=1 -runtime=1000 -group_reporting -filename=iotest -name=Rand_Write_Testing
```

```sh
# 测试随机读 IOPS
$ fio -direct=1 -iodepth=128 -rw=randread -ioengine=libaio -bs=4k -size=1G -numjobs=1 -runtime=1000 -group_reporting -filename=iotest -name=Rand_Read_Testing
```

```sh
# 测试顺序写吞吐量
$ fio -direct=1 -iodepth=64 -rw=write -ioengine=libaio -bs=1024k -size=1G -numjobs=1 -runtime=1000 -group_reporting -filename=iotest -name=Write_PPS_Testing
```

```sh
# 测试顺序读吞吐量
$ fio -direct=1 -iodepth=64 -rw=read -ioengine=libaio -bs=1024k -size=1G -numjobs=1 -runtime=1000 -group_reporting -filename=iotest -name=Read_PPS_Testing
```

## XFS

### 查看磁盘碎片

```sh
$ xfs_db -r -c "frag -f" /dev/sda1
```

### 清理磁盘碎片

清理前需要先把机器上的有状态服务关闭，避免数据丢失。

```sh
$ xfs_fsr -v /dev/sda1
```

## 交换空间

### 使用交换分区创建交换空间

```sh
# 创建交换分区
$ mkswap /dev/sdb2

# 启用交换空间
$ swapon /dev/sdb2

# 开启自启动
$ blkid # 获取分区 UUID
$ vi /etc/fstab
UUID=XXX swap swap defaults 0 0
```

### 使用交换文件创建交换空间

```sh
# 创建一个 20GB 的交换文件
$ dd if=/dev/zero of=/swap bs=1024k count=20480

# 创建交换空间
$ mkswap /swap

# 启用交换空间
$ swapon /swap

# 开启自启动
$ vi /etc/fstab
/swap swap swap defaults 0 0
```

## 视频教程

* [做实验、学存储](http://www.linuxplus.org/courses/LinuxPlus/STOR1/201702/about)

## 参考

* [云盘参数和性能测试方法](https://help.aliyun.com/document_detail/25382.html?spm=5176.doc35241.6.551.9xYiHF)
* [Persistent block device naming](https://wiki.archlinux.org/index.php/Persistent_block_device_naming_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

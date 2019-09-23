# 磁盘（Disk）

## 扇区（Sector）

低级格式扇区大小：512 字节（传统）
高级格式扇区大小：4096 字节（目前行业标准）

物理扇区（Physical Sector）：物理磁盘的实际扇区大小
逻辑扇区（Logical Sector）：为了向后兼容，将物理扇区拆分成 512 字节的逻辑扇区。

```sh
$ sudo fdisk -l | grep "Sector size" -B 3
Disk /dev/sda: 1000.2 GB, 1000204886016 bytes
255 heads, 63 sectors/track, 121601 cylinders, total 1953525168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
--
Disk /dev/sdb: 120.0 GB, 120034123776 bytes
255 heads, 63 sectors/track, 14593 cylinders, total 234441648 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
```

## 磁盘碎片（fragmentation）

## 示例

* 查询磁盘扇区大小

```sh
# 物理扇区大小 & 逻辑扇区大小
$ DISK=sda && sudo fdisk -l /dev/$DISK | grep -i "sector size"
Sector size (logical/physical): 512 bytes / 4096 bytes

# 物理扇区大小
$ DISK=sda && cat /sys/block/$DISK/queue/physical_block_size
4096

# 逻辑扇区大小
$ DISK=sda && cat /sys/block/$DISK/queue/logical_block_size
512
```

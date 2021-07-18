# Greenplum 存储容量估算

## 计算可用磁盘容量

服务器原始磁盘容量：

```txt
raw_capacity = disk_size * number_of_disks
```

文件系统格式化开销（约 10%）+ RAID 开销（假设 RAID-10）：

```txt
formatted_disk_space = (raw_capacity * 0.9) / 2
```

可用的磁盘空间（为了最佳性能，仅使用 70% 的磁盘空间，剩余 30% 用于临时文件和事务文件）：

```txt
usable_disk_space = formatted_disk_space * 0.7
```
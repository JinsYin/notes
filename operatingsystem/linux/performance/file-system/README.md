# 文件系统

## 性能指标

* 打开的文件描述符（File Descriptors, FD）
* inode
* 分区使用率
* 交换空间
* 各挂载点的使用情况（只考虑 filetype 是 `xfs`/`ext4`/`fuseblk(ntfs)/cifs(nfs)` 等情况）

磁盘空间：

    * 磁盘容量（fs_size，fs_capacity）
    * 磁盘剩余空间（fs_avail）
    * 磁盘使用空间（fs_usage）
# 磁盘常用操作

## 查看有那些磁盘
```bash
$ fdisk -l
$ lsblk
```

## 查看磁盘挂载及容量信息
```bash
$ df -h
```

## 格式化盘
```bash
$ mkfs.xfs -f /dev/sdb	# xfs: 文件系统类型， -f: 强制清空磁盘
```

## 挂载
```bash
$ mount /dev/sdb (-c) /ceph/osd	# -c: 检测磁盘坏道
```

## 开机自动挂载
```bash
# 第一个数字表示dump选项：0不备份，1备份，2备份（比1重要性小）
# 第二个数字表示是否在启动是用 fsck 校验分区：０不校验，１校验，２校验（比１晚校验）
$ echo "/dev/sdb /ceph/osd xfs defaults 0 1" >> /etc/fstab
```

## 分区
```bash
$ fdisk /dev/sdb # 分区是针对整个盘
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

常用
> 创建一个主分区： `n`，`p`，`1`，`Enter`，`Enter`，`wq`。  
> 为分区设置引导项： `a`，`1`，`wq` （使用 fdisk -l 查看该分区的 boot 列是否增加了一个 *）。

## 卸载
```bash
$ umount /dev/sdb   # 卸载盘
$ umount /dev/sdb1  # 卸载分区
```

## 查看挂载及文件系统信息：
```bash
$ mount -l
```


## 磁盘性能测试

* 测试随机写 IOPS

```bash
$ fio -direct=1 -iodepth=128 -rw=randwrite -ioengine=libaio -bs=4k -size=1G -numjobs=1 -runtime=1000 -group_reporting -filename=iotest -name=Rand_Write_Testing
```

* 测试随机读 IOPS

```bash
$ fio -direct=1 -iodepth=128 -rw=randread -ioengine=libaio -bs=4k -size=1G -numjobs=1 -runtime=1000 -group_reporting -filename=iotest -name=Rand_Read_Testing
```

* 测试顺序写吞吐量

```bash
$ fio -direct=1 -iodepth=64 -rw=write -ioengine=libaio -bs=1024k -size=1G -numjobs=1 -runtime=1000 -group_reporting -filename=iotest -name=Write_PPS_Testing
```

* 测试顺序读吞吐量

```bash
$ fio -direct=1 -iodepth=64 -rw=read -ioengine=libaio -bs=1024k -size=1G -numjobs=1 -runtime=1000 -group_reporting -filename=iotest -name=Read_PPS_Testing
```


## XFS

### 查看磁盘碎片

```bash
$ xfs_db -r -c "frag -f" /dev/sda1
```

### 清理磁盘碎片

清理前需要先把机器上的有状态服务关闭，避免数据丢失。

```bash
$ xfs_fsr -v /dev/sda1
```



## 阿里云
> [云盘参数和性能测试方法](https://help.aliyun.com/document_detail/25382.html?spm=5176.doc35241.6.551.9xYiHF)

* [Persistent block device naming](https://wiki.archlinux.org/index.php/Persistent_block_device_naming_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
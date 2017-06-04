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
$ fdisk /dev/sdb
依次输入 n，p，1，两次回车，wq，分区完成
```
	

## 卸载盘或分区
```bash
$ umount /dev/sdb   # 盘
$ umount /dev/sdb1  # 分区
```

## 查看挂载及文件系统信息：
```bash
$ mount -l
```

## 阿里云
> [云盘参数和性能测试方法](https://help.aliyun.com/document_detail/25382.html?spm=5176.doc35241.6.551.9xYiHF)


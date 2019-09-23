# CentOS NTFS

CentOS 挂载 ntfs 格式的磁盘。

## 启用 EPEL 源

```sh
$ yum install epel-release
```

## 安装 ntfs-3g

安装 ntfs-3g 来开启 ntfs 文件系统支持

```sh
$ yum install ntfs-3g -y
```

```sh
$ yum install ntfsprogs -y
```

## 挂载、卸载

```sh
# 挂载
$ mount -t ntfs-3g /dev/sdg1 /mnt/win

# 卸载
$ umount /dev/sdg1
```

挂载的时候，如果指定的是整个磁盘而不是具体的分区，会出现如下错误：

```sh
$ mount -t ntfs-3g /dev/sdg /mnt/win
NTFS signature is missing.
Failed to mount '/dev/sdg': Invalid argument
The device '/dev/sdg' doesn't seem to have a valid NTFS.
Maybe the wrong device is used? Or the whole disk instead of a
partition (e.g. /dev/sda, not /dev/sda1)? Or the other way around?
```

## 参考

* [How to Mount a NTFS Drive on CentOS / RHEL / Scientific Linux](https://www.howtoforge.com/tutorial/mount-ntfs-centos/)
* [How to Mount NTFS File System in CentOS 7 / RHEL 7](https://www.techbrown.com/mount-ntfs-file-system-centos-7-rhel-7.shtml)

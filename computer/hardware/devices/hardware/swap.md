# 交换空间

## 关闭交换空间

```bash
# 识别交换设备和文件
$ cat /proc/swaps
Filename        Type        Size        Used        Priority
/dev/dm-1       partition   10534908    95916       -1
```

```bash
# 查看交换空间使用情况
$ free -h
              total        used        free      shared  buff/cache   available
Mem:            31G         18G        174M         47M         12G         11G
Swap:           10G         31M         10G

```

```bash
# 关闭/释放所有的交换设备和文件（之后再使用上面两个命令发现都没有东西了）
$ swapoff -a
```

```bash
# 删除挂载
$ vi /etc/fstab
#/dev/mapper/centos-swap    swap   swap     defaults    0 0
```

```bash
# 重启系统（有时 mount -a 可能也行）
$ reboot
```

```bash
# 验证
$ free -h
$ lsblk
$ blkid
```
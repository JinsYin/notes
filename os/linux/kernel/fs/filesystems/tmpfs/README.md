# tmpfs 虚拟内存文件系统

Linux 不仅支持驻留于磁盘之上的文件系统，也支持驻留于内存中的虚拟文件系统。

tmpfs 较之于其他基于内存的文件系统，其独特之处在于它属于虚拟内存文件系统。这意味着该文件系统不但使用 RAM，而且在 RAM 耗尽的情况下，还会利用交换空间。

## 创建 tmpfs

```sh
# 无需使用 mkfs 预先创建一个文件系统
$ mount -t tmpfs <source> <target>

# 可采用堆叠挂载（不用顾虑 /tmp 目录当前是否处于在用状态）
$ mount -t tmpfs newtmp /tmp
$ cat /proc/mounts | grep newtmp
```

默认情况下，允许将 tmpfs 文件系统的大小提高到 RAM 容量的以便，但在创建文件系统或之后重新挂载时，可使用 mount 的 `size=nbytes` 选项重新为该文件系统的大小设置不同的上限值。

## 特点

* tmpfs 文件系统只根据当前所持有的文件来消耗内存和交换空间
* 卸载文件系统或系统奔溃，会导致该文件系统中的所有数据丢失

## 用途

* 用户应用程序
* 由内核内部挂载的隐形 tmpfs 文件系统，用于实现 System V 共享内存和共享匿名内存映射
* 挂载于 `/dev/shm` 的 tmpfs 文件系统，为 glibc 用以实现 POSIX 共享内存和 POSIX 信号量
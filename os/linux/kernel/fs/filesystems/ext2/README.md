# Ext2

_Ext2_ 是为 Linux 内核设计的第二代扩展文件系统（second extended file system），也是第一个商业级的 Linux 文件系统，是大多数文件系统实现的原型。

## 简介

* 时间：1993 年 1 月
* 设计者：Rémy Card
* 设计目的：取代 ext

## 概念

* 块组（Block Groups）
* 目录（Directories）
* Inode
* 超级块
* 符号连接

## 数据结构

### inode



## 大小限制

| 块大小  | 最大文件大小 | 最大文件系统大小 |
| ------- | ------------ | ---------------- |
| **1KB** | 16GB         | 4TB              |
| **2KB** | 256GB        | 8TB              |
| **4KB** | 2TB          | 16TB             |
| **8KB** | 2TB          | 32TB             |

解读：在 ext2 文件系统中，当逻辑块的大小为 1KB 时，文件最大可以是 16GB，而文件系统最大可以是 4TB

## 优势

* 不用为文件黑洞分配空字节数据块

## 劣势

## 帮助

```sh
$ man 5 ext2
```

## 示例

```sh
dd if=/dev/zero of=/tmp/file bs=1k count=64k
mke2fs -f /tmp/file 32768
mkdir /mnt/test
mount -o loop,debug,check=strict /tmp/file /mnt/test
df /mnt/test
ext2online -d -v /tmp/testfile

df /mnt/test
```

## 参考

* [Ext2fs Home Page](http://e2fsprogs.sourceforge.net/ext2.html)
# VFS

VFS（英文：Virtual file system，中文：虚拟文件系统）是具体文件系统（如 XFS、EXT4、FAT32、NTFS 等）之上的抽象层，允许客户端应用程序以统一的方式透明地访问不同的文件系统（使得多种文件系统可以共存），而客户端感觉不到任何差异。

## 内核存储堆栈

VFS 层在 Linux 内核存储堆栈各个部分中的位置：

![IO stack of the Linux kernel](https://upload.wikimedia.org/wikipedia/commons/3/30/IO_stack_of_the_Linux_kernel.svg)

## 参考

* [用户态文件系统 ( FUSE ) 框架分析和实战](https://cloud.tencent.com/developer/article/1006138)
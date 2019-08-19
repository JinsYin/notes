# Linux 文件系统（Linux Filesystem）

”一切皆文件“（everything is a file），这种抽象使得应用程序对数据和对设备的操作都通过一套统一的系统调用接口来进行。

## 目录

* 通用文件系统概念

## 层次结构

![文件系统层次结构](.images/fs-hierarchies.gif)

## 层级标准（FHS）

文件系统层级标准（Filesystem Hierarchy Standard，缩写 FHS）定义了 Linux 发行版的目录结构和目录内容。

目录结构：

| 目录 | 描述 |
| ---- | ---- |
| `/`  |      |


## 目录结构

文件系统使用目录结构来组织存储的数据，并将其他信息（如所有者、访问权限等）与实际数据关联起来。

目录的 inode 包含了指向目录下所有文件的 inode 的指针，从而建立了层次结构。

## 相关命令

* `mkfs` - 创建文件系统
* `ls -li`

## 参考

* [用户态文件系统（FUSE）框架分析和实战](https://cloud.tencent.com/developer/article/1006138)
* [Filesystems](https://www.tldp.org/LDP/sag/html/filesystems.html)
* [Filesystems in the Linux kernel](https://www.kernel.org/doc/html/latest/filesystems/index.html)
* [Unix Filesystem Organization](https://web.cs.wpi.edu/~rek/DCS/D04/UnixFileSystems.html)
* [Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)
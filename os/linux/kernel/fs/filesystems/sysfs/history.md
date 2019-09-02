# sysfs 简史

sysfs 是 Linux 2.6 的一个特性，允许内核代码通过内存文件系统将信息导出到用户进程。文件系统目录层级的组织严格基于内核数据结构的内部组织。在文件系统中创建的文件主要是 ASCII 文件，每个文件通常带有一个值。

sysfs 是一种表示内核对象（kernel objects）、内核对象的属性及其相互关系的机制。它提供了两个组件：一个是内核编程接口，用于通过 sysfs 导出这些项（将内核构造导出到用户空间）；另一个是用户接口，用于查看和操作映射回它们所表示的内核对象的这些项。

内核和用户空间 sysfs 映射之间的映射：

| 内部                             | 外部                       |
| -------------------------------- | -------------------------- |
| 内核对象（Kernel Objects）       | 目录（Direcotries）        |
| 对象属性（Object Attributes）    | 普通文件（Regular Files）  |
| 对象关系（Object Relationships） | 符号链接（Symbolic Links） |

sysfs 是内核基础结构的核心部分，这意味着它提供了一个相对简单的接口来执行一个简单的任务。

sysfs 是内核与用户空间之间的信息管道。

## 历史

sysfs 最初是一个基于 ramfs 的内存文件系统。ramfs 是在 Linux 2.4 稳定时编写的，由于 ramfs 的简单性以及对 VFS 的使用，它提供了一个很好的基础，从中派生出其他基于内存的文件系统。sysfs 最初被称为 ddfs（Device Driver Filesystem），在编写新的驱动程序模型（device model）时，它是用来调试新的驱动程序模型的。那个调试代码最初使用 procfs 导出设备树（device tree），但在 Linus Torvalds 的严格要求下，它被转换为使用基于 ramfs 的新文件系统。

当新的驱动程序模型（driver model）在 Linux 2.5.1 左右被合并到内核中时，它已经改名为 driverfs，以便更具有描述性。重新开发以提供一个中央对象管理机制，并将驱动程序转换为系统文件以表示其子系统不可知性。

## 挂载 sysfs

运行时手动挂载：

```sh
# /sys 是标准挂载点，尝试改变挂载点会发现两者的内容一致
$ sudo mount -t sysfs sysfs /sys
```

引导时自动挂载：

```sh
$ sudo vi /etc/fstab
sysfs /sys sysfs noauto 0 0
```

## 对象向内核注册的方法以及如何创建目录
# sysfs

位于用户空间的设备文件系统。

sysfs 系统的任务就是将系统中的硬件配置状态导出到用户空间。

sysfs 是一个基于内存的文件系统，其作用是将内核空间中的硬件配置状态导出到用户空间，供应用程序使用。

sysfs 刚开始被命名成 ddfs（Device Driver Filesystem）

## 目录

* [sysfs 简史](history.md)
* [sysfs 目录层级](sys/README.md)

* 目录组织和子系统布局

## 参考

* [The sysfs Filesystem](https://mirrors.edge.kernel.org/pub/linux/kernel/people/mochel/doc/papers/ols-2005/mochel.pdf)
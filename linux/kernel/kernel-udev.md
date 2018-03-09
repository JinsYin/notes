# Udev

udev 是 Linux 内核的设备管理器，负责管理 `/dev` 中的设备节点。同时，udev 也处理所有用户空间发生的硬件添加、删除事件，以及某些特定设备所需的固件加载。

udev 通过并行加载内核模块提供了潜在的性能优势。异步加载模块的方式也有一个天生的缺点：无法保证每次加载模块的顺序，如果机器具有多个块设备，那么它们的设备节点可能随机变化。例如如果有两个硬盘，`/dev/sda` 可能会随机变成 `/dev/sdb`。


## 安装

udev 现在是 systemd 的组成部分，默认已被安装。

```bash
$ systemctl status systemd-udevd.service
```


## 参考

* [udev](https://wiki.archlinux.org/index.php/Udev_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
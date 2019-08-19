# udev

_udev_（userspace /dev）是 Linux 内核的设备管理器，负责管理 `/dev` 中的设备节点（设备文件）。同时，udev 也处理所有用户空间发生的硬件添加、删除事件，以及某些特定设备所需的固件加载。

udev 通过并行加载内核模块提供了潜在的性能优势。异步加载模块的方式也有一个天生的缺点：无法保证每次加载模块的顺序，如果机器具有多个块设备，那么它们的设备节点可能随机变化。例如如果有两个硬盘，`/dev/sda` 可能会随机变成 `/dev/sdb`。

Linux 的早期版本中，`/dev` 包含了系统中所有可能的设备，即使某些设备并未与系统连接。这存在两个缺点（udev 解决了这些问题）：

1. 对于需要扫描 `/dev` 目录内容的程序而言，降低了程序的执行速度
2. 更加 `/dev` 目录下的内容无法发现系统中实际存在哪些设备

udev 解决了上述问题，该程序依赖于 sysfs 文件系统，该系统挂载与 `/sys` 伪文件系统，负责将设备和其他内核对象的相关信息导出到用户空间。

## 安装

udev 现在是 systemd 的组成部分，默认已被安装。

```sh
$ systemctl status systemd-udevd.service
```

## 网卡设备重命名

通过修改 udev rules 文件，可以重命名网卡设备名称，但前提是先关闭 RHEL 的 `一致性网络设备命名法`。

* 第一步：关闭 “一致性网络设备命名法”

```bash
# 修改过 GRUB2 启动参数
$ vi /etc/default/grub
GRUB_CMDLINE_LINUX="... net.ifnames=0 biosdevname=0"
```

```bash
# 重构 GRUB2 配置文件
$ grub2-mkconfig -o /boot/grub2/grub.cfg

# 如果系统使用 UEFI 引导
$ grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
```

* 第二步：修改 udev rules

```bash
# link/ether 后接 MAC 地址："c8:1f:66:b9:83:c2"
$ ip link show em1
em1: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP> mtu 1500 qdisc mq master bond0 state DOWN mode DEFAULT group default qlen 1000
    link/ether c8:1f:66:b9:83:c2 brd ff:ff:ff:ff:ff:ff
```

```bash
# 移除第一行，为每个网卡设备重命名
$ vi /usr/lib/udev/rules.d/60-net.rules
# ACTION=="add", SUBSYSTEM=="net", DRIVERS=="?*", ATTR{type}=="1", PROGRAM="/lib/udev/rename_device", RESULT=="?*", NAME="$result"
$ ACTION=="add", SUBSYSTEM=="net", DRIVERS=="?*", ATTR{address}=="c8:1f:66:b9:83:c2", NAME="eth123"
```

* 第三步：重命名网卡配置

```bash
# 重命名网卡配置
$ mv /etc/sysconfig/network-scripts/ifcfg-p4p1 /etc/sysconfig/network-scripts/ifcfg-eth0
$ sed 's|p4p1|eth0|g' /etc/sysconfig/network-scripts/ifcfg-eth0
```

* 第四步：重启系统

## 参考

* [udev](https://wiki.archlinux.org/index.php/Udev_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
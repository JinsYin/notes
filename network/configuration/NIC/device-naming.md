# 网络设备命名

## 命名策略

默认情况下，`systemd` 使用以下策略为接口命名：

* 方案一：如果固件（Firmware）或 BIOS 信息适用且可用，则使用整合了为

## 一致性网络设备命名法

CentOS7 开始，Systemd 和 udev 引入了一致网络设备命名（CONSISTENT NETWORK DEVICE NAMING），会根据固件、拓扑、位置信息来设置网卡设备名称，好处是命名自动化，即使更换也不会影响设备的命名，坏处是难以立即。

## 关闭 “一致性网络设备命名法”

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

```bash
# 重命名网卡配置
$ mv /etc/sysconfig/network-scripts/ifcfg-p4p1 /etc/sysconfig/network-scripts/ifcfg-eth0
$ sed 's|p4p1|eth0|g' /etc/sysconfig/network-scripts/ifcfg-eth0
```

## 参考

* [一致网络设备命名](https://access.redhat.com/documentation/zh-cn/red_hat_enterprise_linux/7/html/networking_guide/ch-consistent_network_device_naming)
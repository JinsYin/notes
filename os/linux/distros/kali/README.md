# Kail

Kail Linux 是基于 Debian 的 Linux 发行版，前身是 BackTracer（BT），设计用于数字取证和渗透测试。

## 版本

| Name                                | 描述                                    |
| ----------------------------------- | --------------------------------------- |
| `Kali Linux Light`                  | 轻量级版本，即最小化安装                |
| `Kali Linux`                        | GNOME 桌面环境                          |
| `Kali Linux Mate|Kde|Xfce|E17|Lxde` | 使用不同的桌面环境                      |
| `Kali Linux VMware VM`              | VMware 虚拟机可以直接打开使用的镜像     |
| `Kali Linux Vbox`                   | VirtualBox 虚拟机可以直接打开使用的镜像 |

## 硬件要求

* 512M 的内存
* 10GB 的磁盘空间
* i386 和 AMD64 架构

## 虚拟机增强工具

Kali 官方推荐使用 open-vm-tools 虚拟机增强工具。

```sh
apt-get update && apt-get -y full-upgrade
apt-get -y install open-vm-tools-desktoop fuse
reboot
```

## 桌面环境调整

```sh
$ gnome-tweaks
```

## 资料

* [Kali Linux Tools Listing](https://tools.kali.org/tools-listing)
* [Kali Linux 工具文档翻译计划](https://github.com/Jack-Liang/kalitools)
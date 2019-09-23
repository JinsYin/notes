# PXE

预启动执行环境（Pre-boot Execution Environment，缩写：`PXE`）。利用 DHCP 和 PXE，网络管理员不仅能自动分配 IP 地址，还能自动批量安装操作系统。

## 操作系统启动过程

1. 启动 BIOS（小系统）
2. 读取磁盘的 MBR 启动扇区，启动 GRUB
3. 权利移交给 GRUB；GRUB 加载 `kernel`、加载作为根文件系统的 `initramfs` 文件
4. 权利移交给 `kernel`；`kernel` 启动起来，初始化整个操作系统

安装操作系统的过程，应该插在 BIOS 启动之后（步骤 1 之后）。因为如果没有安装操作系统，磁盘连启动扇区都没有。因此这个过程叫做 **预启动执行环境（Pre-boot Execution Environment）**。

PXE 协议分为 `客户端` 和 `服务器端`，由于没有操作系统，所以只能先把客户端安装在 BIOS 中。当计算机启动时，BIOS 把 PXE 客户端调入内存，之后再连接服务器端完成相应操作。

## PXE 工作过程

1. BIOS 启动 PXE 客户端；PXE 客户端通过 DHCP 协议发送一个 “我需要 IP 地址和操作系统” 的请求给 DHCP Server；DHCP Server 会响应配置 IP 所需要的 `IP 地址段`、`子网掩码`、`网关`、`租期`，以及使用 PXE 所需要的 `PXE 服务器地址` 和 `初始化启动文件的文件名（pxelinux.0）`

DHCP Offer 样例配置：

```plain
ddns-update-style interim;
ignore client-updates;
allow booting;
allow bootp;
subnet 192.168.1.0 netmask 255.255.255.0
{
option routers 192.168.1.1; // 网关
option subnet-mask 255.255.255.0; // 子网掩码
option time-offset -18000;
default-lease-time 21600;
max-lease-time 43200;
range dynamic-bootp 192.168.1.240 192.168.1.250; // IP 地址段
filename "pxelinux.0"; // PXE 的配置初始化启动文件的文件名
next-server 192.168.1.180; // PXE 服务器的地址
}
```

2. PXE 客户端使用 `TFTP 协议` 从 PXE 服务器下载启动文件，这意味着 PXE 服务器上还要有一个 TFTP 服务器
3. PXE 客户端执行收到的启动文件；该启动文件会指示 PXE 客户端从 TFTP 服务器请求下载 `计算机的配置文件（pxelinux.cfg）`；配置文件中包含 `Linux kernel` 和 `initramfs` 的配置
4. PXE 客户端依次从 TFTP 服务器请求下载 `Linux kernel` 和 `initramfs`
5. 启动 Linux Kernel

![PXE 工作过程](.images/pxe-workflow.png)

## 思考

1.PXE 协议可以用来安装操作系统，但如何使得第一次是安装操作系统，以后重启都是正常进入操作系统，而不是再重新安装操作系统？

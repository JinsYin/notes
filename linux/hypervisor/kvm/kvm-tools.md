# KVM 工具

## 组件及作用

* `qemu-kvm`: KVM + Qemu
* `virt-manager`: 虚拟机管理工具（virsh）
* `virt-top`: 虚拟机资源统计工具
* `virt-viewer`: GUI 连接程序，连接到已配置好的虚拟机
* `libvirt`: 提供 libvirt socket 服务
* `libvirt-client`: 为虚拟客户机提供的 C 语言工具包
* `virt-install`: 基于 libvirt 服务创建虚拟机的客户端工具
* `bridge-utils`: 桥接设备管理工具

## qemu-kvm

* CentOS

```bash
# 安装
$ yum install -y qemu-kvm
```

* Ubuntu

```bash
# 安装
$ apt-get install qemu-kvm
```

## libvirt

`libvirt` 是一个管理虚拟化主机的工具包，为不同的虚拟化技术提供统一的 API 接口，包括 `KVM`、`QEMU`、`Xen`、`VMWare ESX` 以及 `LXC` 等。

* CentOS

```bash
# 安装
$ yum install -y libvirt

# 运行
$ systemctl start libvirtd
```

* Ubuntu

```bash
# 安装
$ apt-get install -y libvirt-bin

# 运行
$ service start libvirt-bin
```

## virt-install

`virt-install` 是一个命令行工具，它提供了一种将操作系统配置到虚拟机中的简单方法。

* CentOS

```BASH
# 安装
$ yum install -y virt-install
```

* Ubuntu

```bash
# 安装
$ apt-get install -y virtinst

$ virt-install -n web_devel -r 512 \
--disk path=/var/lib/libvirt/images/web_devel.img,bus=virtio,size=4 -c \
ubuntu-16.04-server-i386.iso --network network=default,model=virtio \
--graphics vnc,listen=0.0.0.0 --noautoconsole -v
```

## virt-clone

virt-clone 是一个命令行工具，用于克隆已存在的虚拟机。它克隆磁盘镜像，并定义一个新的名称、UUID、MAC 地址

### 克隆虚拟机

```bash
# 关闭虚拟机
$ virsh shutdown kube-node-121

# 克隆虚拟机
$ virt-clone -o kube-node-121 --name kube-node-122 -f /root/kvm-img/kube-node-122.img
```

## virsh

## virt-xml

virt-xml是一个使用virt-install命令行选项轻松编辑libvirt域XML的命令行工具。

## virt-convert

virt-convert是一个命令行工具，用于将OVF和VMX VM配置转换为使用libvirt运行。

## virt-top

[virt-top](https://people.redhat.com/rjones/virt-top/) 通过连接 libvirt 来监控虚拟机的客户端工具。

* CentOS

```bash
# 安装
$ yum install -y virt-top

# 连接本地 libvirt 服务
$ virt-top
$ virt-top -c qemu+ssh:///system

# 连接远程 libvirt 服务
$ virt-top --connect qemu+ssh://root@192.168.10.120/system
```

* Ubuntu

```bash
# 安装
$ apt-get install -y virt-top
```

## virt-viewer

`virt-viewer` 是一个轻量级的 UI 界面，用于与虚拟机操作系统的图形化显示进行交互。它可以显示 `VNC` 或 `SPICE`，并使用 libvirt 超图形连接细节。

 virt-viewer是一个用于显示虚拟机的图形控制台的最小工具。 控制台使用VNC或SPICE访问协议。 可以基于其名称，ID或UUID来引用guest虚拟机。如果客户端尚未运行，则可以告知观看者请等待，直到它开始，然后尝试连接到控制台。此查看器可以连接到远程主机以查找控制台信息然后也使用同一网络连接到远程控制台。

* CentOS

```bash
# 安装
$ yum install -y virt-viewer

# 连接本地虚拟机
$ virt-viewer kube-node-121

# 连接远程虚拟机
$ virt-viewer -c qemu+ssh://192.168.10.120/system kube-node-121
```

* Ubuntu

```bash
# 安装
$ apt-get install -y virt-viewer
```

## virt-manager

virt-manager 是一个用于通过 libvirt 管理虚拟机的用户界面。主要支持 `KVM`，也支持 `Xen` 和 `LXC`。

* CentOS

```bash
# 安装
$ yum install -y virt-manager
```

* Ubuntu

```bash
# 安装
$ apt-get install -y virt-manager
```

### virt-clone
### virt-image
### virt-install

## qemu-img

```bash
# 格式转换
$ qemu-img convert -f raw -o qcow2 image.img image.qcow2
```

* [Converting between image formats](https://docs.openstack.org/image-guide/convert-images.html)

## virt-df

* CentOS

```bash
# 安装
$ 
```

* Ubuntu

```bash
# 安装
$ apt-get install -y libguestfs-tools
```

## libguestfs

http://libguestfs.org/

## virt-what

## qemu-img

```bash
$ 
```

## 参考

* [Ubuntu libvirt](https://help.ubuntu.com/lts/serverguide/libvirt.html)
* [Applications using libvirt](https://libvirt.org/apps.html)
# KVM

KVM 是 Kernel-based Virtual Machine 的缩写，即基于内核的虚拟机。KVM 是基于硬件的完全虚拟化，因此它需要硬件支持（英特尔的 `Inter-VT` 技术，AMD 的 `AMD-V` 技术）。

## KVM、QEMU、QEMU-KVM


## 镜像格式

| 镜像格式 | Hypervisor |
| raw    | (all)      |
| qed    | KVM        |
| qcow2  | KVM Xen    |
| vdi    | VirtualBox |
| vhd    | Hyper-V    |
| wmdk   | Vmware     |

* [Converting between image formats](https://docs.openstack.org/image-guide/convert-images.html)
* [qcow2、raw、vmdk 等镜像格式](http://www.cnblogs.com/feisky/archive/2012/07/03/2575167.html)

## 组件

* Qemu
* KVM

KVM 包含一个核心模块 `kvm.ko` 来实现核心虚拟化功能，和一个处理器专用模块　`kvm-intel.ko` 或　`kvm-amd.ko`。KVM 本身不实现任何模拟，仅仅暴露一个 `/dev/kvm` 接口，该接口可被宿主机用来主要负责vCPU的创建，虚拟内存的地址空间分配，vCPU寄存器的读写以及vCPU的运行。有了KVM以后，guest os的CPU指令不用再经过QEMU来转译便可直接运行，大大提高了运行速度。但KVM的kvm.ko本身只提供了CPU和内存的虚拟化，所以它必须结合QEMU才能构成一个完整的虚拟化技术，也就是下面要介绍的技术。

* Qemo-KVM

KVM 负责实现 CPU 和内存的虚拟化。

Qemu 负责模拟 IO 设备（网卡、显卡、磁盘等），以及各种虚拟设备的创建，调用进行管理。

目前QEMU-KVM已经与QEMU合二为一，所有特定于KVM的代码也都合入了QEMU，当需要与KVM模块配合使用的时候，只需要在QEMU命令行加上 --enable-kvm就可以。

KVM的用户空间组件包含在主线QEMU中，从1.3开始。

* Libvirt


## 目录

* [KVM 安装](./kvm-installation.md)
* [KVM 网络](./kvm-network.md)
* [KVM 工具](./kvm-tools.md)


## 视频教程

* [开源虚拟化 KVM 极速入门](http://www.linuxplus.org/courses/LinuxPlusX/KVM01/2016_08/about)
* [KVM 虚拟化进阶与提高](http://www.linuxplus.org/courses/LinuxPlus/KVM02/201612/about)


## 参考

* [KVM-Qemu-Libvirt 三者之间的关系](http://changfei.blog.51cto.com/4848258/1672147)
* [KVM](https://wiki.archlinux.org/index.php/KVM_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))


  http://blog.csdn.net/iiiiher/article/details/78576539


* [CentOS7 安装 KVM 虚拟机详解](https://github.com/jaywcjlove/handbook/blob/master/CentOS/CentOS7%E5%AE%89%E8%A3%85KVM%E8%99%9A%E6%8B%9F%E6%9C%BA%E8%AF%A6%E8%A7%A3.md)

* [](http://v.qq.com/vplus/9c6b41a5e47651e4a25e9827b38c171e)

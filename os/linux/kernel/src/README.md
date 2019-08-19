# 内核源码（Kernel Source）

## 目录

* [内核源码树](source-tree.md)
* [编译内核](compile-kernel.md)
* [内核补丁](patch.md)

## 官网

| 网址                                             | 描述                  |
| ------------------------------------------------ | --------------------- |
| [www.kernel.org](https://www.kernel.org)         | Linux 内核的官网      |
| [git.kernel.org](https://git.kernel.org)         | Linux 内核的 Git 仓库 |
| [mirrors.kernel.org](https://mirrors.kernel.org) | Linux 发行版的镜像站  |

## 示例

Linux 发行版的各种路径：

* 内核源码路径

```sh
# Ubuntu 14.04
$ ls /usr/src/linux-headers-$(uname -r)

# Centos 7.x（mininal 没有内核源码）
$ ls /usr/src/kernels
```

* 内核二进制文件（即内核映像）路径

```sh
# Ubuntu 14.04
$ ls /boot/vmlinuz-$(uname -r)
/boot/vmlinuz-4.4.0-148-generic

# Centos 7.x
$ ls /boot/vmlinuz-$(uname -r)
/boot/vmlinuz-3.10.0-957.1.3.el7.x86_64
```
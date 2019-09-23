# lshw

`lshw` 列出硬件信息

## 安装

```sh
# CentOS
$ yum install -y lshw
```

## 命令

```sh
# 所有
$ lshw -short

# 内存（-c: -class）
$ lshw -short -c memory
H/W path       Device       Class          Description
======================================================
/0/0                        memory         64KiB BIOS
/0/3a/3b                    memory         256KiB L1 cache
/0/3a/3c                    memory         1MiB L2 cache
/0/3a/3d                    memory         8MiB L3 cache
/0/3e                       memory         32GiB System Memory
/0/3e/0                     memory         8GiB DIMM DDR3 Synchronous 1600 MHz (0.6 ns)
/0/3e/1                     memory         8GiB DIMM DDR3 Synchronous 1600 MHz (0.6 ns)
/0/3e/2                     memory         8GiB DIMM DDR3 Synchronous 1600 MHz (0.6 ns)
/0/3e/3                     memory         8GiB DIMM DDR3 Synchronous 1600 MHz (0.6 ns)

# CPU
$ lshw -short -c cpu
H/W path       Device       Class          Description
======================================================
/0/3a                       processor      Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz

# Network
$ lshw -short -C network
H/W path       Device       Class          Description
======================================================
/0/100/19      eth0         network        Ethernet Connection I217-LM
/1             bridge0      network        Ethernet interface
/2             vethe8eae5c  network        Ethernet interface
/3             ovs-system   network        Ethernet interface
```

## 参考

* [16 commands to check hardware information on Linux](https://www.binarytides.com/linux-commands-hardware-info/)

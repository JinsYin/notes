# Mellanox

## Enable SR-IOV on the Firmware

MFT(Mellanox Firmware tools)

```bash
$ mst start
Starting MST (Mellanox Software Tools) driver set
Loading MST PCI module - Success
Loading MST PCI configuration module - Success
Create devices

$ lsmod | grep mst
mst_pciconf            99235  0
mst_pci                90686  0

$ mst status
MST modules:
------------
    MST PCI module loaded
    MST PCI configuration module loaded

MST devices:
------------
/dev/mst/mt26428_pciconf0   - PCI configuration cycles access.
                            domain:bus:dev.fn=0000:82:00.0 addr.reg=88 data.reg=92
                            Chip revision is: B0
/dev/mst/mt26428_pci_cr0    - PCI direct access.
                            domain:bus:dev.fn=0000:82:00.0 bar=0xfbd00000 size=0x100000
                            Chip revision is: B0
```

<https://community.mellanox.com/docs/DOC-2377>
<https://community.mellanox.com/docs/DOC-2365>

## OFED

Mellanox OpenFabrics Enterprise Distribution for Linux (MLNX_OFED)

### 安装/卸载 IB 网卡（Mellanox）驱动

```bash
# 根据操作系统类型选择相应的版本下载
# Download: www.mellanox.com -> Products -> Software - > InfiniBand/VPI Drivers -> Linux SW/Drivers
# http://www.mellanox.com/page/products_dyn?product_family=26&mtag=linux_sw_drivers
$ wget http://content.mellanox.com/ofed/MLNX_OFED-4.1-1.0.2.0/MLNX_OFED_LINUX-4.1-1.0.2.0-rhel7.3-x86_64.tgz

# 解压
$ tar -zxvf MLNX_OFED_LINUX-4.1-1.0.2.0-rhel7.3-x86_64.tgz
$ cd MLNX_OFED_LINUX-4.1-1.0.2.0-rhel7.3-x86_64

# 安装过程会检查系统缺少的库并提示手动安装，使用 -q 参数自动安装
$ ./mlnxofedinstall
```

```bash
# 重新启动 openibd 并设置为开机启动
$ systemctl restart openibd
$ systemctl enable openibd

# openibd 启动成功后可以看到 ib0
$ ifconfig ib0

# 启动子网管理器 opensmd 并设置为开机启动
$ systmectl restart opensmd
$ systemctl enable opensmd

# 查看 HCA（主机通道适配器） 端口状态，‘State: Active’ 表示正常
$ ibstat

# 查看 HCA 端口
$ hca_self_test.ofed

# 最后重启系统
$ reboot
```

```bash
# 卸载驱动
$ /usr/sbin/ofed_uninstall.sh
```

## issues

1. openibd 无法重启

```bash
$ /etc/init.d/openibd restart
Cannot unload driver while ib_isert is loaded...
Please close all isert sessions and unload ib_isert module first.
```

解决办法：

```bash
# 卸载 ib_isert 驱动
$ modprobe -r ib_isert
```

2. ERROR: Module rdma_cm is in use by: rpcrdma

```bash
$ /etc/init.d/openibd restart
Unloading rdma_cm                                          [FAILED]
rmmod: ERROR: Module rdma_cm is in use by: rpcrdma
```

解决办法：

```bash
$ modprobe -r rpcrdma
$ modprobe -r ib_srpt
```

## 参考

* [Centos infiniband 网卡安装配置](https://www.cnblogs.com/tiandi/p/7142486.html)
* [linux安装&卸载IB网卡(mellanox)驱动](https://www.cnblogs.com/leffss/p/7836694.html)
* [Install Mellanox OFED GPUDirect RDMA on CentOS 7](https://gist.github.com/1duo/666d749ac7bf24ac4cc4f67984756edf)
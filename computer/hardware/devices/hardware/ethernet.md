# 以太网

## 网卡设备

```bash
# 网卡物理设备（yum install -y pciutils）
$ lspci | grep -i 'ethernet controller'
01:00.0 Ethernet controller: Broadcom Limited NetXtreme BCM5720 Gigabit Ethernet PCIe
01:00.1 Ethernet controller: Broadcom Limited NetXtreme BCM5720 Gigabit Ethernet PCIe
02:00.0 Ethernet controller: Broadcom Limited NetXtreme BCM5720 Gigabit Ethernet PCIe
02:00.1 Ethernet controller: Broadcom Limited NetXtreme BCM5720 Gigabit Ethernet PCIe
82:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
```

```bash
# 网卡设备速率
$ ethtool p4p1 | grep Speed
Speed: 10000Mb/s
```

## 万兆

* 安装驱动

```bash
# CentOS 7 默认已加载
$ modprobe ixgbe
```

## 参考

* [万兆和千兆的网卡命名问题](https://www.jianshu.com/p/d501b8875295)
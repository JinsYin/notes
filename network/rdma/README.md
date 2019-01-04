# RDMA

## 概述

* DMA（Direct Memory Access） - 直接内存访问；设备直接访问主机内存无需 CPU 干预
* RDMA（Remote Direct Memory Access） - 远程直接内存访问；在不中断系统 CPU 处理的情况下访问远程主机的内存

## 特点

优点：

* Zero-copy
* 直接硬件接口（Direct Hardware Interface），绕过 Kernel 和 TCP/IP 的 IO
* 亚微妙延迟
* Flow control and reliability is offloaded in hardware

缺点：

* 大多数 IP 网络应用程序构建的标准 Berkeley Sockets API 无法实现，必须使用 InfiniBand Verbs API 才能使用 RDMA 技术

## 数据传输过程

* TCP 数据传输过程

![TCP Data Transimission](.images/tcp-data-transmission.png)

* RDMA 数据传输过程

![RDMA Data Transimission](.images/rdma-data-transmission.png)

## 三种 RDMA 技术/产品

* InfiniBand - 1. IB 网络的数据链路层协议; 2. InfiniBand Verbs API
* RoCE（RDMA over Converged Ethernet） - 允许通过以太网进行 RDMA 的网络协议；后被重命名为 `IBoE`。
* iWARP（The Internet Wide Area RDMA Protocol） - 通过网络层（IP）协议实现 RDMA 高效传输数据的计算机网络协议

后两种技术允许在非 InfiniBand 硬件上使用 InfiniBand Verbs API 。

## 目录

* [安装 RDMA 软件包](installation.md)

## 参考

* [What is RDMA](https://community.mellanox.com/docs/DOC-1963)
* [配置 INFINIBAND 和 RDMA 网络](https://access.redhat.com/documentation/zh-cn/red_hat_enterprise_linux/7/html/networking_guide/ch-configure_infiniband_and_rdma_networks)
* [SparkRDMA：使用RDMA技术提升Spark的Shuffle性能](https://www.iteblog.com/archives/1964.html)
* [在各互联网公司中，有将 RDMA 技术用于生产环境的实例吗](https://www.zhihu.com/question/59122163)
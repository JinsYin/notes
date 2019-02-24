# SAN（Sotrage Area Network）

存储区域网络 (SAN) 是将计算机系统或主机服务器连接到高性能存储子系统的专用高速网络。SAN 组件包括
主机服务器中的主机总线适配器 (HBA)、用于路由存储流量的交换机、线缆、存储处理器 (SP) 以及存储磁盘阵列。

## 存储网络（Storage Networking）

* iSER: iSCSI Extensions for RDMA
* iSCSI: Internet SCSI （SCSI over TCP）
* FC: Fiber Channel（光纤通道）- 需要光纤交换机
* FCoE: FC over Ethernet

性能对比：iSER > FC > iSCSI > FCoE

initiator(compute host) --> target(storage host)

## FC

为将流量从主机服务器传输到共享存储器，SAN 使用光纤通道 (FC) 协议将 SCSI 命令打包到光纤通道帧中。

### 概念

WWNs:World Wide Names
LUNs:volumes

### FC SAN Zoning

## 其他

* IPoIB: IP over Infiniband （在 IB 网络上实现 IP 协议）
* IPFC: IP over Fiber Channel（在光纤通道上实现 IP 协议）

## iSER

* [What is ISER](https://community.mellanox.com/docs/DOC-1466)
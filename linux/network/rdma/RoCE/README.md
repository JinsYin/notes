# RoCE（后重命名为 IBoE）

RoCE（RDMA over Converged Ethernet）是一种网络协议，可通过以太网实现 RDMA 。根据所使用的网卡，有两个版本：`RoCE v1` 和 `RoCE v2`。RoCe 可以在既可以硬件上，也可以在软件上实现。

## `v1` vs `v2`

* `RoCE v1` 协议是以太网链路层协议，具有 ethertype `ox8915`，可以在同一个以太网广播域中的任意两台主机之间进行通信。
* `RoCE v2` 协议存在于 UDP over IPv4 或 UDP over IPv6 协议之上。已为 `RoCE v2` 保留 UDP 目标端口号 `4791`。

## 使用 RDMA_CM 的 RoCE 默认版本

| Client  | Server  | Default setting |
| ------- | ------- | --------------- |
| RoCE v1 | RoCE v1 | Connection      |
| RoCE v1 | RoCE v2 | Connection      |
| RoCE v2 | RoCE v2 | Connection      |
| RoCE v2 | RoCE v1 | No connection   |

## 硬件实现

## 软件实现

## 参考

* [TRANSFERRING DATA USING ROCE](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-tranferring_data_using_roce)
* [CONFIGURING SOFT-ROCE](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_soft-_roce)
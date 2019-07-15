# Ceph-ansible 部署 Ceph（物理机环境）

## 简述

* 机器：4 台 OSD 节点，3 台 Agent
* 网络：
  * 前端：1 个千兆、1 个万兆、1 个 Infiniband
  * 后端：1 个 Infiniband
* 存储设备：每台机器 8 块 HDD、2 块 SSD、1 块 NVME-SSD
* 小型生产环境

## Todo

* 批量安装 IB 网卡驱动 --- ansible
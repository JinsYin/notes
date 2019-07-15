# Ceph 硬件建议

## CPU

| 守护进程 | CPU 核数/每个进程 | 说明                                                                                       |
| -------- | ----------------- | ------------------------------------------------------------------------------------------ |
| ceph-mds | >= 4              | ceph-mds 需要动态重新分配其负载，视为 CPU 密集型进程                                       |
| ceph-osd | >= 2              | ceph-osd 运行 RADOS 服务，使用 CRUSH 计算数据归置、复制数据以及维护自身的 Cluster Map 副本 |
| ceph-mon | ~                 | ceph-mon 仅维护 Cluster Map 的主拷贝，视为非 CPU 密集型进程                                |

除 Ceph 守护进程之外，还必须考虑主机是否会运行其他 CPU 密集型进程。例如，如果 Ceph 主机将运行计算型虚拟机（如 OpenStack Nova），则需要确保这些进程为 Ceph 守护进程预留了足够的 CPU 资源。不过，建议在不同的主机上运行其他 CPU 密集型进程。

## RAM

| 守护进程            | RAM/每个进程                                                                                              | 说明                                                                                                                                                                                                                                                      |
| ------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ceph-mon / ceph-mgr | 小集群: 1-2GB, 大集群: 5-10GB <br> 可能还需要考虑调整 `mon_osd_cache_size` 或 `rocksdb_cache_size` 等设置 | 内存使用量随集群规模而变化                                                                                                                                                                                                                                |
| ceph-mds            | >= 1GB                                                                                                    | ceph-mds 内存利用率取决于其缓存 配置成 消耗多少内存，参考 `mds_cache_memory`                                                                                                                                                                              |
| ceph-osd            | BlueStore OSD: 3-5GB   <br> FileStore OSD: ～                                                             | 使用 BlueStore 后端时，可以使用 `osd_memory_target` 参数调整 OSD 使用的内存（默认是 4GB，这里不考虑 OSD 对应的磁盘容量） <br> 使用 FileStore 后端时，Ceph 使用操作系统页面缓存来缓存数据，因此不需要调整，且 OSD 内存消耗通常与每个守护进程的 PG 数量相关 |

> 通常，内存越多越好

## 数据存储

规划数据存储时，需要对 **成本** 和 **性能** 进行折衷。

### 硬盘（HDD）

* 最小硬盘容量：1TB
* 硬盘成本考虑：每 GB 的成本（即 `硬盘价格` 除以 `硬盘 GB 大小`）
* 内存一般法则：1TB 存储空间要求 ~1GB RAM（硬盘容量越大，每个 Ceph OSD 消耗的内存越多，尤其是 `再平衡` rebalancing、`回填` backfilling 以及 `恢复` recovery 期间）
* 磁盘物理限制（影响了系统性能）：
  * 寻道时间（seek time）
  * 访问时间（access time）
  * 读写时间（read and write times）
  * 总吞吐量（total throughput）
* Not a good idea:
  * 单盘运行多个 OSD（无论是否分区）
  * 单盘运行 OSD+MON 或 OSD+MDS（无论是否分区）
* 最佳实践方法：
  * 在单独的磁盘上运行 `操作系统`、`OSD 数据`、`OSD 日志`，以最大化吞吐量
  * **每个 Ceph OSD 守护进程使用一块单独的磁盘**（而不是使用多盘组成的 RAID）
  * 每 `4 - 6` 个 OSD 数据盘共享 1 个普通 SSD 类型的 OSD 日志盘（分区）

### SSD

SSD 相比于 HDD：

* 性能显著提升
  * 减低了随机访问时间和读延迟
  * 加快了吞吐量
* 每 GB 成本比 HDD 高 `10 倍`，但访问时间要快至少 `100 倍`
* 没有移动的机械部件，不受 HDD 同类型的物理限制

评估 SSD 性能：

* 着重考虑顺序读写性能（尤其是一块 SSD 为多个 OSD 存储多个日志时）
* 投资 SSD 前检查 SSD 的性能指标，并在测试配置中测试 SSD 以衡量性能
* 如果嫌 SSD 贵，可以将 OSD 日志存储在 SSD 或 SSD 分区上，而将 OSD 对象数据存储在单独的 HDD 盘上（需要修改 `osd journal` 的默认设置 `/var/lib/ceph/osd/$cluster-$id/journal`）

日志和 SSD 的性能注意事项：

* **写入密集**：日志记录属于写入密集型任务，确保作为日志盘的 SSD 在写入性能方面优于 HDD（廉价 SSD 虽然加速了访问时间但也可能存在写入延迟，而高性能 HDD 可能反而比廉价 SSD 拥有更快的写入速度）
* **顺序写入**：在一块共享的 SSD 上存储多个日志时，必须考虑 SSD 的顺序写入限制，因为可能需要处理同时写入多个 OSD 日志的请求
* **分区对齐**：确保 SSD 分区正确对齐，否则可能导致 SSD 传输数据变慢

提升 CephFS 性能的方法：

* 将 CephFS 元数据的存储和 CephFS 文件内容的存储分离
* Ceph 为 Ceph 元数据提供了默认的 `metadata` 池，无需再为 CephFS 元数据创建池，但可以为 CephFS 元数据创建一个 [CRUSH Map](http://docs.ceph.com/docs/mimic/rados/operations/crush-map/#placing-different-pools-on-different-osds) 层次结构，使其指向 SSD 存储介质

### 磁盘控制器

磁盘控制器会对写入吞吐量产生巨大影响，因此需要仔细考虑选择的磁盘控制器，以确保它们不会产生性能瓶颈。

### 其他注意事项

* 如果一台主机运行多个 OSD，必须
  * 确保 OSD 磁盘总吞吐量之和不超过客户端读取或写入数据所需的网络带宽（否则瓶颈来自网络瓶颈）
  * 确保内核是最新的
  * 运行大量 OSD 的主机（如 >20 个）可能产生大量线程，尤其是恢复和再平衡期间。而 Linux 内核的最大线程数默认相对较小（如 32k），可以在 `/etc/sysctl.conf` 文件中设置 `kernel.pid_max = 4194303`（理论上限）来调高线程数量
* 单台主机存储的数据量占集群总数据量的百分比不能太大（建议小于 `10%`）。如果某台机器的占比过大且机器出现故障，则可能导致诸如超出 `full ratio` 等问题，从而导致 Ceph 停止运行以防止数据丢失。

## 网络

```c
+--------------------------------------------------------------------------+
|                              Public Network                              |
+--------------------------------------------------------------------------+
    ^  ^            ^  ^            ^  ^            ^  ^            ^  ^
    |  |            |  |            |  |            |  |            |  |
    |  |            |  |            |  |            |  |            |  |
    v  v            v  v            v  v            v  v            v  v
+----------+    +----------+    +----------+    +----------+    +----------+
| Ceph Mon |    | Ceph MDS |    | Ceph OSD |    | Ceph OSD |    | Ceph OSD |
+----------+    +----------+    +----------+    +----------+    +----------+
                                    ^  ^            ^  ^            ^  ^
                                    |  |            |  |            |  |
                                    |  |            |  |            |  |
                                    v  v            v  v            v  v
+--------------------------------------------------------------------------+
|                             Cluster Network                              |
+--------------------------------------------------------------------------+
```

* 每台主机至少有两个 1Gbps NIC
  * 公共/前端网络（**Public Network**） —— ceph-mon 与 ceph-osd、ceph-client 与 ceph-mon、ceph-client 与 ceph-osd 之间通信的网络（最好采用万兆网络）
  * 集群/后端网络（**Cluster Network**） —— 处理 OSD 之间的数据复制和心跳（最好采用万兆网络，且不要连接互联网）
  * 建议三个网络，另一个用于 SSH 访问、VM 进行上传、操作系统镜像安装、管理 socket 等影响 Ceph 网络的其他操作
* 主机上所有 OSD 磁盘的总吞吐量不能超过网络带宽（商用 HDD 的吞吐量约为 `100MB/s`，因此，如果前端网络为 `10Gbps`，则单机 OSD 磁盘数量不要超过 `12` 块）
* 服务器硬件应具有底板管理控制器（BMC）
* 开启 NIC Bonding 来发送和接收流量 —— 模式设置为 Balance-alb（`mode=6`）

数据复制速度对比：

| 网络带宽\复制的数据量 | 1TB   | 3TB |
| --------------------- | ----- | --- |
| 1Gbps                 | 3h    | 9h  |
| 10Gbps                | 20min | 1h  |

## 故障域（Failure Domains）

故障域是指阻止访问一个或多个 OSD 的任何故障。可能是守护进程停止、硬盘故障、操作系统故障、NIC 故障、电源故障、网络中断，断点等等。规划硬件需求时，必须在 `低故障域` 和 `低成本诱惑` 之间进行平衡。

| Type ID | Type Name | Type ID | Type Name  |
| ------- | --------- | ------- | ---------- |
| 0       | osd       | 6       | pod        |
| 1       | host      | 7       | room       |
| 2       | chassis   | 8       | datacenter |
| 3       | rack      | 9       | region     |
| 4       | row       | 10      | root       |
| 5       | pdu       |

## 最低硬件建议（小集群）

| 进程     | 标准           | 最低推荐                                       |
| -------- | -------------- | ---------------------------------------------- |
| ceph-osd | Processor      | * 1x 64位 AMD-64 <br> * 1x 32位 ARM 双核或更好 |
|          | RAM            | ~1GB/1TBpd                                     |
|          | Volume Storage | 1StorageDrive/1Daemon                          |
|          | Journal        | 1SSD_Partition/1Daemon                         |
|          | Network        | 2x 1Gbps 以太网卡                              |
| -        | -              | -                                              |
| ceph-mon | Processor      | * 1x 64位 AMD-64 双核 <br> * 1x 64位 ARM 双核  |
|          | RAM            | 1 GBpd                                         |
|          | Disk Space     | 10 GBpd                                        |
|          | Network        | 2x 1Gbps 以太网卡                              |
| -        | -              | -                                              |
| ceph-mds | Processor      | * 1x 64位 AMD-64 双核 <br> * 1x 64位 ARM 双核  |
|          | RAM            | 1 GBpd                                         |
|          | Disk Space     | 1 MBpd                                         |
|          | Network        | 2x 1Gbps 以太网卡                              |

> TBpd: TB per daemon
> GBpd: GB per daemon
> MBpd: MB per daemon

## 生产集群示例（2012 年）

| 配置         | 标准           | 最低推荐                 |
| ------------ | -------------- | ------------------------ |
| Dell PE R510 | Processor      | 2x 64位 双核 Xeon CPUs   |
|              | RAM            | 16 GB                    |
|              | Volume Storage | 8x 2TB：1 OS + 7 Storage |
|              | Client Network | 2x 1Gbps 以太网卡        |
|              | OSD Network    | 2x 1Gbps 以太网卡        |
|              | Mgmt. Network  | 2x 1Gbps 以太网卡        |
| -            | -              | -                        |
| Dell PE R515 | Processor      | 1X 16核 Opteron CPU      |
|              | RAM            | 16 GB                    |
|              | Volume Storage | 12x 3TB                  |
|              | OS Storage     | 1x 500GB                 |
|              | Client Network | 2x 1Gbps 以太网卡        |
|              | OSD Network    | 2x 1Gbps 以太网卡        |
|              | Mgmt. Network  | 2x 1Gbps 以太网卡        |

## 总结

* `PCIe 带宽` >= `磁盘控制器带宽` >= `网络带宽` >= `主机上所有 OSD 磁盘的总吞吐量`（由于前三项基本不变，因此重点在于控制每台机器上 OSD 磁盘的数量，使其总吞吐量不能超过网络带宽）

## 其他

* 每 15-20 个 OSD 节点使用一个 1 ceph-mon

## 参考

* [HARDWARE RECOMMENDATIONS (MIMIC)](http://docs.ceph.com/docs/mimic/start/hardware-recommendations/)
* [Red Hat Ceph Storage hardware selection guide](https://www.redhat.com/en/resources/red-hat-ceph-storage-hardware-selection-guide)
* [RED HAT CEPH STORAGE HARDWARE CONFIGURATION GUIDE](https://www.redhat.com/cms/managed-files/st-rhcs-config-guide-technology-detail-inc0387897-201604-en.pdf)

* [Best Practices & Performance Tuning - OpenStack Cloud Storage with Ceph](https://www.slideshare.net/swamireddy/ceph-barcelonav12)
* [A Good Network Connects Ceph To Faster Performance](http://www.mellanox.com/blog/2015/08/a-good-network-connects-ceph-to-faster-performance/)
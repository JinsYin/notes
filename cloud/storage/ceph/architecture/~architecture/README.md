# Ceph 架构

![Ceph Architecture](.images/ceph-architecture.png)

| 子系统       | 描述                                                            |
| ------------ | --------------------------------------------------------------- |
| **LIBRADOS** | 允许直接访问 RADOS 的库，支持 C、C++、Java、Python、Ruby 和 PHP |
| **RADOSGW**  | 基于 Bucket 的 REST 网关，兼容 S3 和 Swift                      |
| **RBD**      | 完全分布式块设备，带有 Linux 内核客户端和 QEMU/KVM 驱动         |
| **CEPHFS**   | POSIX 兼容的分布式文件系统，带有 Linux 内核客户端和支持 FUSE    |
| **RADOS**    | 由自处理、自管理的智能节点组成的可靠、自治、分布式对象存储      |

* [Ceph 存储集群](ceph-storage-cluster.md)
* [Ceph 协议](ceph-protocol.md)
* [Ceph 客户端](ceph-clients.md)
  * Ceph 对象存储
  * Ceph 块设备
  * Ceph 文件系统

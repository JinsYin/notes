# Ceph 从入门到放弃

目前使用的 Ceph 发行版本为 `jewel`（10.2.x），该版本也是 CephFS 的第一个稳定版本，所以块存储（RBD）、对象存储（RadosGW）、文件系统（CephFS）都可以用于生产环境。

## 简介

Ceph 把客户端数据保存为存储池内的对象。通过使用 CRUSH 算法， Ceph 可以计算出哪个归置组（PG）应该持有指定的对象（Object），然后进一步计算出哪个 OSD 守护进程持有该归置组。 CRUSH 算法使得 Ceph 存储集群能够动态地伸缩、再均衡和修复。

Ceph 存储集群至少需要一个 Ceph Monitor 和两个 OSD 守护进程。而运行 Ceph 文件系统客户端时，则必须要有元数据服务器（Metadata Server）。部署方面，官方建议使用 ceph-deploy 工具来部署，所以需要一个部署节点。

* OSD

Ceph OSD 守护进程的功能是存储数据，处理数据的复制、恢复、回填、再均衡，并通过检查其他 OSD 守护进程的心跳来向 Ceph Monitor 提供一些监控信息。当 Ceph 存储集群设定为有 2 个副本时，至少需要 2 个 OSD 守护进程，集群才能达到 `active+clean` 状态（ Ceph 默认有 3 个副本，但可以调整副本数）。

* Monitor

Ceph Monitor 维护着展示集群状态的各种图表，包括监视器图、 OSD 图、归置组（ PG ）图、和 CRUSH 图。 Ceph 保存着发生在 Monitors 、 OSD 和 PG 上的每一次状态变更的历史信息（称为 epoch ）。

* MDS

Ceph 元数据服务器（ MDS ）为 Ceph 文件系统存储元数据（也就是说，Ceph 块设备和 Ceph 对象存储不使用 MDS ）。元数据服务器使得 POSIX 文件系统的用户们，可以在不对 Ceph 存储集群造成负担的前提下，执行诸如 ls、find 等基本命令。

* PG

归置组。Pool 中 PG 的数量可以在 Pool 创建的时候指定，也可以使用集群指定的默认值（8）。

* PGP

归置的归置组。


## 目录

## Ceph 源

  > http://mirrors.aliyun.com/ceph/rpm-jewel/el7
  > http://download.ceph.com/rpm-jewel/el7

## 资料

* [Red Hat Ceph Storage](https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/)

## 书籍

## 参考文章

* [Rexray 文档](http://libstorage.readthedocs.io/en/stable/user-guide/storage-providers/#ceph-rbd)
* [Ceph 架构剖析](https://www.ustack.com/blog/ceph_infra/)
* [如何基于 Ceph 构建高性能块存储服务](https://www.ustack.com/blog/ceph-service)
* [Ceph，一个 Linux PB 级分布式文件系统](https://www.ibm.com/developerworks/cn/linux/l-ceph/)
* [Ceph 性能测试](http://tech.uc.cn/?p=1223#more-1223)
* [Ceph 的现状](https://www.ustack.com/blog/ceph-distributed-block-storage/)
* [有云 Ceph](https://www.ustack.com/category/blog/ceph-blog/)
* [Acttao 开发、运维容器化实践](http://www.kejik.com/article/250854.html)
* [CEPH CONFIGURATION GUIDE](https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/1.2.3/html-single/ceph_configuration_guide/)
* [刘超：Docker 比 OpenStack 更易用，坚定选择 Kubernetes](http://www.infoq.com/cn/interviews/interview-with-liuchao-talk-docker-and-kubernets?utm_campaign=rightbar_v2&utm_source=infoq&utm_medium=interviews_link&utm_content=link_text)

## 参考

* [Library of Ceph and Gluster reference architectures – Simplicity on the other side of complexity](https://redhatstorage.redhat.com/2017/05/30/library-of-ceph-and-gluster-reference-architectures-simplicity-on-the-other-side-of-complexity/)
* [Ceph Object Storage at Spreadshirt](https://pt.slideshare.net/jenshadlich/ceph-object-storage-at-spreadshirt-49422450)
* [Ceph at Spreadshirt (June 2016)](https://www.slideshare.net/jenshadlich/ceph-at-spreadshirt-june-2016)
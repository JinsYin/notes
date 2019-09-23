# Ceph 基本概念

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

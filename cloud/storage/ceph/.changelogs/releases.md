# Ceph 发行版

## 发布时间表

| Ceph 版本名称 | Ceph 版本号 | 发布日期 |
| ------------- | ----------- | -------- |
| Argonaut      |             |          |

| Mimic | 13.0 | |
| Luminous
| Kraken |
| Jewel |
| Infernalis |
| Hammer |
| Giant |
| Firefly |
| Emperor |
| Dumpling |

## 发布周期

* Development releases (x.0.z)
* Release candidates (x.1.z)
* Stable releases (x.2.z)

## Luminous 新功能

* Bulestore
* Erasure Coding Overwrite
* Multiple MDS
* Ceph MGR Dashboard

### FireStore vs BlueStore

| FileStore  | BuleStore          |
| ---------- | ------------------ |
| Filesystem | Device             |
| Journal    | Direct Write / WAL |
| Disk       | Disk, SSD, NVME    |

### Replica vs Erasure Coding

|              | Replica          | Erasure Coding |
| ------------ | ---------------- | -------------- |
| space used   | 3x (n=3)         | 1.5x (k+m=3)   |
| CPU overhead | Normal           | High           |
| support      | RBD, RGW, CephFS | RGW only       |

### Replica vs EC Overwrite

|              | Replica  | EC Overwrite |
| ------------ | -------- | ------------ |
| space used   | 3x (n=3) | 1.5x (k+m=3) |
| CPU overhead | Normal   | High         |
| support      | ALL      | ALL          |

## Ceph integrate with kubernetes

|                 | CephFS with K8S | Ceph RBD with K8S |
| --------------- | --------------- | ----------------- |
| Multiple Read   | Yes             | Yes               |
| Multiple Read   | Yes             | No                |
| Quota           | No              | Yes               |
| HA support      | Yes             | Yes               |
| Performance     | Good enough     | Better            |
| Isolated volume | No (shared)     | Yes               |

## Hyper Converged VS Hyper Scale Architecture

## 参考

* [Ceph Releases Archives](https://ceph.com/category/releases/)
* [inwinSTACK - ceph integrate with kubernetes](https://www.slideshare.net/inwinstack/inwinstack-ceph-integrate-with-kubernetes)

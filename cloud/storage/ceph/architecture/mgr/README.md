# Ceph Manager Daemon (ceph-mgr)

<!--
The Ceph manager handles execution of many of the read-only Ceph CLI queries
-->

## MGR 架构

```c
Ceph CLI        Ceph CLI   Prometheus    Script     Browser
  |          |                    |           |           |           |
  |      +-------+               |           |           |           |
  |                |               v           v           v           v
  |                |         +----------+------------+-----------+-----------+
  |                |         |          |            |           |           |
  |                |         |  status  | prometheus |  restful  | dashboard |
  |                |         |          |            |           |           |
  |                |         +-----------------------------------------------+
  |                v         |                    Python                     |
  |        +-----------------------------------------------------------------+
  |        |    +-----------------+                      +---------------+   |
  |        |    | Table of latest |                      | Local copy of |   |
  |        |    |   daemon stats  |          MGR         | cluster maps  |   |
  |        |    +-----------------+                      +---------------+   |
  |        +-----------------------------------------------------------------+
  |  ^       |        |
  |  |       |persist |
  |  |read   |health, |             +--------------------------------------------+
  |  |latest |stats,  |comands      |  +-----------------+  +-----------------+  |
  |  |state  |config, |             |  | MDS | MDS | MDS |  | RGW | RGW | RGW |  |
  |  |       |etc     |             |  +-----------------+  +-----------------+  |
  |  |       |        |             +--------------------------------------------+               Ceph Client
  |  |       |        |                                                                -----------------------
  v  |       v        v                                                                  Ceph Storage Cluster
+-----------------------+    +---------------------------------------------------+
|                       |    |                                                   |
|    +-----+            |    |    +-----+  +-----+  +-----+  +-----+  +-----+    |
|    | MON |            |    |    | OSD |  | OSD |  | OSD |  | OSD |  | OSD |    |
|    +-----+            |    |    +-----+  +-----+  +-----+  +-----+  +-----+    |
|    +-----+ +-----+    |    |    +-----+  +-----+  +-----+  +-----+  +-----+    |
|    | MON | | MON |    |    |    | OSD |  | OSD |  | OSD |  | OSD |  | OSD |    |
|    +-----+ +-----+    |    |    +-----+  +-----+  +-----+  +-----+  +-----+    |
|                       |    |                                                   |
+-----------------------+    +---------------------------------------------------+
```

## 目录

* [内置模块](modules/README.md)
* [管理模块](admguide.md)
* [开发模块](devguide.md)
* [编排模块](orchestrator.md)
# CEPH-VOLUME

该 ceph-volume 工具旨在成为一个单一用途的命令行工具，将逻辑卷（LV）部署为 OSD，并与 ceph-disk 工具在准备、激活和创建 OSD 时保持相似的 API 。

* 不依赖于 Ceph 安装的 udev 规则而偏离 ceph-disk

## 替换 CEPH-DISK

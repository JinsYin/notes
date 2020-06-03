# ceph status

## 示例

```sh
$ ceph status
  cluster:
    id:     9e283ec8-ad64-4981-b921-8b6f117325ad
    health: HEALTH_OK

  services:
    mon: 3 daemons, quorum ip-205-gw-ceph-ew,ip-206-gw-ceph-ew,ip-207-gw-ceph-ew
    mgr: ip-206-gw-ceph-ew(active), standbys: ip-207-gw-ceph-ew
    mds: cephfs-1/1/1 up  {0=ip-206-gw-ceph-ew=up:active}, 2 up:standby
    osd: 36 osds: 36 up, 36 in
    rgw: 2 daemons active

  data:
    pools:   12 pools, 2608 pgs
    objects: 265  objects, 14 MiB
    usage:   294 GiB used, 109 TiB / 109 TiB avail
    pgs:     2608 active+clean
```

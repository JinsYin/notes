# ceph

## ceph -w

```sh
$ ceph -w
  cluster:
    id:     7d50e72a-5dcf-4ba0-af2b-0b761eb8944e
    health: HEALTH_WARN
            clock skew detected on mon.ip-192-168-1-173, mon.ip-192-168-1-175
            1/4 mons down, quorum ip-192-168-1-172,ip-192-168-1-173,ip-192-168-1-175

  services:
    mon:        4 daemons, quorum ip-192-168-1-172,ip-192-168-1-173,ip-192-168-1-175, out of quorum: ip-192-168-1-174
    mgr:        ip-192-168-1-176(active), standbys: ip-192-168-1-177, ip-192-168-1-178
    mds:        cephfs-1/1/1 up  {0=ip-192-168-1-176=up:active}, 1 up:standby
    osd:        6 osds: 6 up, 6 in
    rbd-mirror: 1 daemon active
    rgw:        3 daemons active
    rgw-nfs:    1 daemon active

  data:
    pools:   9 pools, 72 pgs
    objects: 283  objects, 11 KiB
    usage:   6.0 GiB used, 294 GiB / 300 GiB avail
    pgs:     72 active+clean
```

## ceph -s

```sh
$ ceph -s
```

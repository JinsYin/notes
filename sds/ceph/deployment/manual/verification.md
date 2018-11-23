# 验证集群

```bash
$ netstat -tpln | grep -E 'ceph|rados'
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      2804820/radosgw
tcp        0      0 192.168.8.220:6789      0.0.0.0:*               LISTEN      2804273/ceph-mon
tcp        0      0 192.168.8.220:6800      0.0.0.0:*               LISTEN      2804352/ceph-mgr
tcp        0      0 192.168.8.220:6805      0.0.0.0:*               LISTEN      2804764/ceph-mds
tcp        0      0 192.168.8.220:6801      0.0.0.0:*               LISTEN      2804519/ceph-osd
tcp        0      0 192.168.8.220:6802      0.0.0.0:*               LISTEN      2804519/ceph-osd
tcp        0      0 192.168.8.220:6803      0.0.0.0:*               LISTEN      2804519/ceph-osd
tcp        0      0 192.168.8.220:6804      0.0.0.0:*               LISTEN      2804519/ceph-osd
```

```bash
$ ps aux | grep ceph
167      2804273  0.1  0.1 488872 44296 ?        Ssl  16:04   0:00 /usr/bin/ceph-mon --cluster ceph --setuser ceph --setgroup ceph -i Yin --mon-data /var/lib/ceph/mon/ceph-Yin --public-addr 192.168.8.220:6789
167      2804352  0.2  0.2 612476 90460 ?        Ssl  16:04   0:02 ceph-mgr --cluster ceph --setuser ceph --setgroup ceph -i Yin
167      2804519  0.1  0.1 846084 52108 ?        Ssl  16:04   0:01 ceph-osd --cluster ceph --setuser ceph --setgroup ceph -i 0
167      2804764  0.0  0.0 432280 23616 ?        Sl   16:04   0:00 ceph-mds --cluster ceph --setuser ceph --setgroup ceph -i demo
167      2804820  0.1  0.1 5074132 46348 ?       Ssl  16:04   0:00 radosgw --cluster ceph --setuser ceph --setgroup ceph -n client.rgw.Yin -k /var/lib/ceph/radosgw/ceph-rgw.Yin/keyring
167      2805754  0.0  0.0 980576 17624 ?        Ssl  16:05   0:00 rbd-mirror --cluster ceph --setuser ceph --setgroup ceph
root     2805762  0.0  0.0 819428 30880 ?        Sl   16:05   0:00 /usr/bin/python2.7 /usr/bin/ceph --cluster ceph -w
root     2807572  0.0  0.0  15960  2620 pts/43   S+   16:18   0:00 grep --color=auto -E ceph|rados
```
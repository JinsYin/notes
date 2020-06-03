# rados df

```sh
$ rados df
POOL_NAME              USED OBJECTS CLONES COPIES MISSING_ON_PRIMARY UNFOUND DEGRADED  RD_OPS      RD  WR_OPS     WR
.rgw.root           2.9 KiB       7      0     21                  0       0        0     171 114 KiB       7  7 KiB
cephfs_data             0 B       0      0      0                  0       0        0       0     0 B       0    0 B
cephfs_metadata     2.2 KiB      22      0     66                  0       0        0       0     0 B      45 13 KiB
default.rgw.control     0 B       8      0     24                  0       0        0       0     0 B       0    0 B
default.rgw.log         0 B     207      0    621                  0       0        0 2102560 2.0 GiB 1401004    0 B
default.rgw.meta        0 B       0      0      0                  0       0        0       0     0 B       0    0 B

total_objects    244
total_used       294 GiB
total_avail      109 TiB
total_space      109 TiB
```

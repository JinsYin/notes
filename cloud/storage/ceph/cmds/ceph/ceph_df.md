# ceph df

## 示例

```sh
$ ceph df
GLOBAL:
    SIZE        AVAIL       RAW USED     %RAW USED
    109 TiB     109 TiB      294 GiB          0.26
POOLS:
    NAME                    ID     USED        %USED     MAX AVAIL     OBJECTS
    cephfs_data             1          0 B         0        34 TiB           0
    cephfs_metadata         2      2.2 KiB         0        34 TiB          22
    .rgw.root               3      2.9 KiB         0        34 TiB           7
    default.rgw.control     4          0 B         0        34 TiB           8
    default.rgw.meta        5          0 B         0        34 TiB           0
    default.rgw.log         6          0 B         0        34 TiB         207
    aisfs_data              7          0 B         0        34 TiB           0
    aisfs_metadata          8          0 B         0        34 TiB           0
    rbdpool                 9       14 MiB         0        34 TiB          16
```

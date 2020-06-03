# ceph fs dump

## 用法

```sh
ceph fs dump {<int[0-]>}
```

## 示例

```sh
$ ceph fs dump
dumped fsmap epoch 8
e8
enable_multiple, ever_enabled_multiple: 0,0
compat: compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object,5=mds uses versioned encoding,6=dirfrag is stored in omap,8=no anchor table,9=file layout v2,10=snaprealm v2}
legacy client fscid: 1

Filesystem 'cephfs' (1)
fs_name	cephfs
epoch	5
flags	12
created	2020-01-06 17:12:18.331072
modified	2020-01-06 17:13:33.259782
tableserver	0
root	0
session_timeout	60
session_autoclose	300
max_file_size	1099511627776
min_compat_client	-1 (unspecified)
last_failure	0
last_failure_osd_epoch	0
compat	compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object,5=mds uses versioned encoding,6=dirfrag is stored in omap,8=no anchor table,9=file layout v2,10=snaprealm v2}
max_mds	1
in	0
up	{0=4894}
failed
damaged
stopped
data_pools	[1]
metadata_pool	2
inline_data	disabled
balancer
standby_count_wanted	1
4894:	192.168.100.206:6801/1865461827 'ip-206-gw-ceph-ew' mds.0.4 up:active seq 2


Standby daemons:

4844:	192.168.100.207:6800/459550508 'ip-207-gw-ceph-ew' mds.-1.0 up:standby seq 1
104102:	192.168.100.205:6800/1327609439 'ip-205-gw-ceph-ew' mds.-1.0 up:standby seq 1
```

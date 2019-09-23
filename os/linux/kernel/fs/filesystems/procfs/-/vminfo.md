# /proc/vminfo

## 参数

| 参数     | 描述                                                                                        |
| -------- | ------------------------------------------------------------------------------------------- |
| MemTotal | 总的可用内存，即物理内存减去一些保留位和内核二进制代码（`/boot/vmlinuz`）运行时所占用的内存 |

## 示例

```sh
MemTotal:        1015008 kB
MemFree:          123692 kB
MemAvailable:     611748 kB
Buffers:            2396 kB
Cached:           604204 kB
SwapCached:            0 kB
Active:           432736 kB
Inactive:         289716 kB
Active(anon):     121432 kB
Inactive(anon):    20480 kB
Active(file):     311304 kB
Inactive(file):   269236 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                24 kB
Writeback:             0 kB
AnonPages:        115884 kB
Mapped:            68564 kB
Shmem:             26060 kB
Slab:             115004 kB
SReclaimable:      70584 kB
SUnreclaim:        44420 kB
KernelStack:        2816 kB
PageTables:         5324 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      507504 kB
Committed_AS:     613856 kB
VmallocTotal:   34359738367 kB
VmallocUsed:       90256 kB
VmallocChunk:   34359537660 kB
HardwareCorrupted:     0 kB
AnonHugePages:     16384 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:       79844 kB
DirectMap2M:      968704 kB
DirectMap1G:           0 kB
```

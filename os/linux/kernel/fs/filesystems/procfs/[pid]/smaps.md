# /proc/[pid]/smaps

显示每个进程映射的内存消耗。

## 示例

```sh
# 每个映射包含类似如下的一系列行
$ cat /proc/self/smaps
00400000-0040b000 r-xp 00000000 fd:01 12613123                           /usr/bin/cat
Size:                 44 kB
Rss:                  28 kB
Pss:                  28 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:        28 kB
Private_Dirty:         0 kB
Referenced:           28 kB
Anonymous:             0 kB
AnonHugePages:         0 kB
Swap:                  0 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Locked:                0 kB
VmFlags: rd ex mr mp me dw sd
......
01296000-012b7000 rw-p 00000000 00:00 0                                  [heap]
Size:                132 kB
Rss:                  12 kB
Pss:                  12 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        12 kB
Referenced:           12 kB
Anonymous:            12 kB
AnonHugePages:         0 kB
Swap:                  0 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Locked:                0 kB
VmFlags: rd wr mr mp me ac sd
.......
```

# free

显示系统中空闲和已用的物理内存、交换内存的数量，以及内核使用的缓存区（buffer）和缓存（cache）。

## 用法

```sh
free [option]
```

## 选项

| 选项            | 描述                                    |
| --------------- | --------------------------------------- |
| `-b`、`--bytes` | 以字节（B）为单位显示内存数量；默认选项 |
| `-m`、`--mega`  | 以 KB 为单位显示内存数量                |
| `-h`、`--human` | 以可读形式显示内存数量                  |

> 以较小单位显示时，会发现每次执行的结果都在变化

## 字段

CentOS 7+ 和 Ubuntu 16.04+：

| 列名       | 描述                                                                                                                                                                                                     |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| total      | 总内存；源自 `/proc/meminfo` 的 “MemTotal” 或 “SwapTotal”                                                                                                                                                |
| used       | 已用内存；**used = total - free - buffers - cache**                                                                                                                                                      |
| free       | 空闲内存；源自 `/proc/meminfo` 的 “MemFree” 或 “SwapFree”                                                                                                                                                |
| shared     | 共享内存；（主要）由 tmpfs 使用的内存；源自 `/proc/meminfo` 的 “Shmem”                                                                                                                                   |
| buffers    | 由 Kernel Buffer 占用的内存；源自 `/proc/meminfo` 的 “Buffers”                                                                                                                                           |
| cache      | 由 Page Cache 和 Slab 占用的内存；源自 `/proc/meminfo` 的 “Cached” 与 “Slab” 之和                                                                                                                        |
| buff/cache | **buffers + cache**                                                                                                                                                                                      |
| available  | 评估有多少内存可用于启动新的应用程序；不同于 **cache** 和 **free** 字段提供的数据，该字段考虑 page cache，而且并非所有可回收的内存 slab 都将因为项正在使用而被回收；源自 `/proc/meminfo` 的 MemAvailable |

Ubuntu 14.04：

| 列名    | 描述                                                            |
| ------- | --------------------------------------------------------------- |
| total   | 同上表                                                          |
| used    | 已用内存；**used = total - free**                               |
| free    | 未被使用的内存；源自 `/proc/meminfo` 的 “MemFree” 或 “SwapFree” |
| shared  | 同上表                                                          |
| buffers | 同上表                                                          |
| cached  | 由 Page Cache 占用的内存；源自 `/proc/meminfo` 的 “Cached”      |

## 示例

* free -h

```sh
# Ubuntu 16.04+ | CentOS 7+
$ free -h
              total        used        free      shared  buff/cache   available
Mem:           1.8G        239M        1.0G         65M        588M        1.3G
Swap:          7.0G          0B        7.0G
```

```sh
# Ubuntu 14.04
$ free -h
             total       used       free     shared    buffers     cached
Mem:           31G        11G        19G       162M       1.7G       2.5G
-/+ buffers/cache:       7.9G        23G
Swap:          19G         0B        19G
```

* free -k 对比 /proc/meminfo

```sh
#x Ubuntu 16.04+ | CentOS 7+
$ free -k && cat /proc/meminfo | grep -E '^Shmem|^Buffers|^Cached|^Slab|^MemAvailable'
              total        used        free      shared  buff/cache   available
Mem:        1877992      291916      981140       67428      604936     1332172
Swap:       7340028           0     7340028
MemAvailable:    1332264 kB
Buffers:            2108 kB # buff/cache = "Buffers" + cache = 604936
Cached:           529688 kB # cache = "Cached" + "Slab" = 602828
Shmem:             67428 kB # "Shmem" = shared
Slab:              73140 kB
```

```sh
# Ubuntu 14.04
$ free -k && cat /proc/meminfo | grep -E '^Shmem|^Buffers|^Cached|^Slab|^MemAvailable'
             total       used       free     shared    buffers     cached
Mem:      32901336   12603804   20297532     170608    1774068    2583820
-/+ buffers/cache:    8245916   24655420
Swap:     20971516          0   20971516
MemAvailable:   25084356 kB
Buffers:         1774068 kB # "Buffers" = buffers
Cached:          2583820 kB # "Cached" = cached
Shmem:            170608 kB # "Shmem" = shared
Slab:            1146684 kB
```

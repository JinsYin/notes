# Proc 伪文件系统（proc pseudo filesystem）

为了更便捷地获取和（或）修改内核属性，Linux 提供了一个 proc 伪文件系统，该文件系统驻留于 `/proc` 目录，包含了各种用于展示内核信息的文件。

之所以将 proc 称为伪文件系统（pseudo：假的；伪的），是因为其包含的文件并未存储在磁盘上，而是由内核在进程访问此类信息时动态创建而成。

## 目录层级

| 子目录              | 描述                   |
| ------------------- | ---------------------- |
| `/proc/`            | 系统相关信息           |
| `/proc/[pid]/`      | 进程相关信息           |
| `/proc/net/`        | 网络和套接字的状态信息 |
| `/proc/sys/fs/`     | 文件系统相关设置       |
| `/proc/sys/kernel/` | 常规的内核设置         |
| `/proc/sys/net/`    | 网络和套接字的设置     |
| `/proc/sys/vm/`     | 内存管理设置           |
| `/proc/sysvipc/`    | System V IPC 对象信息  |

| symlink       | 描述 | 示例                                |
| ------------- | ---- | ----------------------------------- |
| `mounts`      |      | `mounts -> self/mounts`             |
| `self`        |      | `self -> 795328`                    |
| `thread-self` |      | `thread-self -> 795328/task/795328` |

| 子文件 | 描述 |
| ------ | ---- |
|        |      |

## 查看和修改

```sh
$ echo 1000000 > /proc/sys/kernel/pid_max
$ cat /pro/sys/kernel/pid_max
```

注意：

* `/proc` 目录下的一些文件是只读的，仅用于显示内核信息，但无法对其进行修改，多见于 `/proc/[pid]/` 目录下的文件
* `/proc` 目录下的一些文件仅能有文件拥有者（或特权级进程）读取
* 除 `/proc/[pid]/` 子目录下的文件，`/proc` 目录的其他文件大多属于 root 用户

## 相关

```bash
# 手册页
$ man proc
```

```bash
# Debian
$ apt-get install procinfo

$ lsdev

$ procinfo
```

## 示例

```sh
$ tree -L 1
├── acpi
│   └── wakeup
├── asound
│   ├── card0
│   ├── card1
│   ├── cards
│   ├── devices
│   ├── hwdep
│   ├── modules
│   ├── NVidia -> card1
│   ├── oss
│   ├── PCH -> card0
│   ├── pcm
│   ├── seq
│   ├── timers
│   └── version
├── buddyinfo
├── bus
│   ├── input
│   └── pci
├── cgroups
├── cmdline
├── consoles
├── cpuinfo
├── crypto
├── devices
├── diskstats
├── dma
├── driver
│   └── rtc
├── execdomains
├── fb
├── filesystems
├── fs
│   ├── aufs
│   ├── ext4
│   ├── fscache
│   ├── jbd2
│   ├── lockd
│   ├── nfs
│   ├── nfsd
│   ├── nfsfs
│   └── xfs
├── interrupts
├── iomem
├── ioports
├── irq
│   ├── 0
│   ├── 1
│   ├── 10
│   ├── 11
│   ├── 12
│   ├── 13
│   ├── 14
│   ├── 15
│   ├── 16
│   ├── 17
│   ├── 2
│   ├── 23
│   ├── 25
│   ├── 26
│   ├── 27
│   ├── 28
│   ├── 29
│   ├── 3
│   ├── 30
│   ├── 4
│   ├── 5
│   ├── 6
│   ├── 7
│   ├── 8
│   ├── 9
│   └── default_smp_affinity
├── kallsyms
├── kcore
├── keys
├── key-users
├── kmsg
├── kpagecgroup
├── kpagecount
├── kpageflags
├── loadavg
├── locks
├── mdstat
├── meminfo
├── misc
├── modules
├── mounts -> self/mounts
├── mtrr
├── net -> self/net
├── pagetypeinfo
├── partitions
├── sched_debug
├── schedstat
├── scsi
│   ├── device_info
│   ├── scsi
│   ├── sg
│   └── usb-storage
├── self -> 795328
├── slabinfo
├── softirqs
├── stat
├── swaps
├── sys
│   ├── abi
│   ├── debug
│   ├── dev
│   ├── fs
│   ├── fscache
│   ├── kernel
│   ├── net
│   ├── sunrpc
│   └── vm
├── sysrq-trigger
├── sysvipc
│   ├── msg
│   ├── sem
│   └── shm
├── thread-self -> 795328/task/795328
├── timer_list
├── timer_stats
├── tty
│   ├── driver
│   ├── drivers
│   ├── ldisc
│   └── ldiscs
├── uptime
├── version
├── version_signature
├── vmallocinfo
├── vmstat
└── zoneinfo
```

## 内核代码

```c
/*
 * <include/linux/proc_fs.h>
 *
 *
 *
 */
```
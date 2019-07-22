# Proc 伪文件系统

映射到一个挂载点：`/proc`

```bash
$ tree -L 1
-----------
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

| 子目录            | 描述                   |
| ----------------- | ---------------------- |
| /proc/            | 各种系统信息           |
| /proc/[pid]/      | 进程相关信息           |
| /proc/net/        | 网络和套接字的状态信息 |
| /proc/sys/fs/     | 文件系统相关设置       |
| /proc/sys/kernel/ | 常规的内核设置         |
| /proc/sys/net/    | 网络和套接字的设置     |
| /proc/sys/vm/     | 内存管理设置           |
| /proc/sysvipc/    | System V IPC 对象信息  |

| symlink     | 描述 | 示例                                |
| ----------- | ---- | ----------------------------------- |
| mounts      |      | `mounts -> self/mounts`             |
| self        |      | `self -> 795328`                    |
| thread-self |      | `thread-self -> 795328/task/795328` |

| 子文件 | 描述 |
| ------ | ---- |
|        |      |

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
# /proc/[pid]/

内核为系统中的每个进程都提供了相应的目录 `/proc/[pid]/`，该目录包含了进程的相关信息。

## 目录层级

| 路径                              | 文件类型 | 描述                                                                        | 示例                                        |
| --------------------------------- | -------- | --------------------------------------------------------------------------- | ------------------------------------------- |
| [/proc/[pid]/cmdline](cmdline.md) | `-`      | 启动进程时执行的命令行（包括命令及参数）；以 `\0` 分隔                      | `pythonmain.py`                             |
| /proc/[pid]/cwd                   | `l`      | 指向进程当前工作目录（Current Work Directory）的符号链接                    | `cwd -> /proc/843054/`                      |
| /proc/[pid]/environ               | `-`      | 作用于该进程的环境变量列表；以 `\0` 分隔的 NAME=VALUE 键值对列表            | ~                                           |
| /proc/[pid]/exe                   | `l`      | 启动该进程之初的可执行文件的符号链接（相当于 _cmdline_ 命令部分的符号链接） | `exe -> /home/yin/anaconda3/bin/python3.6*` |
| /proc/[pid]/fd/                   | `d`      | 包含该进程打开的文件描述符的符号链接                                        |
| /proc/[pid]/fdinfo/               | `d`      | 包含该进程打开的文件描述符的位置和标记                                      |
| /proc/[pid]/maps                  | `-`      | 包含内存映射文件与块的信息（如堆和栈）                                      |
| /proc/[pid]/mem                   | `-`      | 进程虚拟内存（在 I/O 操作之前必须调用 `lseek()` 移动到有效偏移量）          |
| /proc/[pid]/mounts                | `-`      | 进程的挂载情况                                                              |
| /proc/[pid]/root                  | `l`      | 进程根目录的符号链接                                                        |
| [/proc/[pid]/status](status.md)   | `-`      | 进程相关信息（如：PID、凭证、内存使用量、信号）                             |
| /proc/[pid]/task/                 | `d`      | 进程中的每个线程对应一个子目录                                              |

## 特殊进程目录

* `/proc/1/` - init 进程的目录
* `/proc/$$/` - 解释该命令的 shell 进程的目录
* `/proc/self` - 指向当前进程自己的 `/proc/[pid]` 目录

## 示例

```sh
# 当前进程的相关信息
$ ll /proc/$$
-------------
dr-xr-xr-x   9 root root 0  5月 28 15:57 ./
dr-xr-xr-x 518 root root 0  5月 13 21:49 ../
dr-xr-xr-x   2 root root 0  5月 28 15:57 attr/
-rw-r--r--   1 root root 0  5月 28 15:57 autogroup
-r--------   1 root root 0  5月 28 15:57 auxv
-r--r--r--   1 root root 0  5月 28 15:57 cgroup
--w-------   1 root root 0  5月 28 15:57 clear_refs
-r--r--r--   1 root root 0  5月 28 15:57 cmdline
-rw-r--r--   1 root root 0  5月 28 15:57 comm
-rw-r--r--   1 root root 0  5月 28 15:57 coredump_filter
-r--r--r--   1 root root 0  5月 28 15:57 cpuset
lrwxrwxrwx   1 root root 0  5月 28 15:57 cwd -> /root/
-r--------   1 root root 0  5月 28 15:57 environ
lrwxrwxrwx   1 root root 0  5月 28 15:57 exe -> /bin/bash*
dr-x------   2 root root 0  5月 28 15:57 fd/
dr-x------   2 root root 0  5月 28 15:57 fdinfo/
-rw-r--r--   1 root root 0  5月 28 15:57 gid_map
-r--------   1 root root 0  5月 28 15:57 io
-r--r--r--   1 root root 0  5月 28 15:57 limits
-rw-r--r--   1 root root 0  5月 28 15:57 loginuid
dr-x------   2 root root 0  5月 28 15:57 map_files/
-r--r--r--   1 root root 0  5月 28 15:57 maps
-rw-------   1 root root 0  5月 28 15:57 mem
-r--r--r--   1 root root 0  5月 28 15:57 mountinfo
-r--r--r--   1 root root 0  5月 28 15:57 mounts
-r--------   1 root root 0  5月 28 15:57 mountstats
dr-xr-xr-x   7 root root 0  5月 28 15:57 net/
dr-x--x--x   2 root root 0  5月 28 15:57 ns/
-r--r--r--   1 root root 0  5月 28 15:57 numa_maps
-rw-r--r--   1 root root 0  5月 28 15:57 oom_adj
-r--r--r--   1 root root 0  5月 28 15:57 oom_score
-rw-r--r--   1 root root 0  5月 28 15:57 oom_score_adj
-r--------   1 root root 0  5月 28 15:57 pagemap
-r--------   1 root root 0  5月 28 15:57 personality
-rw-r--r--   1 root root 0  5月 28 15:57 projid_map
lrwxrwxrwx   1 root root 0  5月 28 15:57 root -> //
-rw-r--r--   1 root root 0  5月 28 15:57 sched
-r--r--r--   1 root root 0  5月 28 15:57 schedstat
-r--r--r--   1 root root 0  5月 28 15:57 sessionid
-rw-r--r--   1 root root 0  5月 28 15:57 setgroups
-r--r--r--   1 root root 0  5月 28 15:57 smaps
-r--------   1 root root 0  5月 28 15:57 stack
-r--r--r--   1 root root 0  5月 28 15:57 stat
-r--r--r--   1 root root 0  5月 28 15:57 statm
-r--r--r--   1 root root 0  5月 28 15:57 status
-r--------   1 root root 0  5月 28 15:57 syscall
dr-xr-xr-x   3 root root 0  5月 28 15:57 task/
-r--r--r--   1 root root 0  5月 28 15:57 timers
-rw-r--r--   1 root root 0  5月 28 15:57 uid_map
-r--r--r--   1 root root 0  5月 28 15:57 wchan
```

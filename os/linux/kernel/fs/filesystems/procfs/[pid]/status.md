# /proc/[pid]/status

* 该文件内容随时间而改变，解析内容时应当查找特殊字符串（如 PPid）来匹配行记录，而不是使用行号

```sh
$ cat /proc/self/status
-----------------------
Name:	cat                  # 进程名
State:	R (running)          # 进程状态：running
Tgid:	86487                # 线程组 ID，一个线程一定属于一个线程组（进程组）
Ngid:	0
Pid:	86487                # 当前进程的 ID
PPid:	55292                # 当前进程的父进程的 ID
TracerPid:	0                # 追踪当前进程的进程的 ID；如果是 0，表示没有追踪
Uid:	1000	1000	1000	1000 # 依次是 RUID、EUID、SUID、FSUID
Gid:	1000	1000	1000	1000 #
FDSize:	256                  # 文件描述符大小
Groups:	4 24 27 30 46 108 124 127 133 143 999 1000
NStgid:	86487
NSpid:	86487
NSpgid:	86487
NSsid:	55292
VmPeak:	   11424 kB
VmSize:	   11424 kB
VmLck:	       0 kB
VmPin:	       0 kB
VmHWM:	     716 kB
VmRSS:	     716 kB
VmData:	     188 kB
VmStk:	     132 kB
VmExe:	      44 kB
VmLib:	    1924 kB
VmPTE:	      44 kB # 占用的页表的大小
VmPMD:	      12 kB
VmSwap:	       0 kB
HugetlbPages:	       0 kB
Threads:	1
SigQ:	0/128424
SigPnd:	0000000000000000
ShdPnd:	0000000000000000
SigBlk:	0000000000000000
SigIgn:	0000000000000000
SigCgt:	0000000000000000
CapInh:	0000000000000000
CapPrm:	0000000000000000
CapEff:	0000000000000000
CapBnd:	0000003fffffffff
CapAmb:	0000000000000000
Seccomp:	0
Cpus_allowed:	f
Cpus_allowed_list:	0-3
Mems_allowed:	00000000,00000001
Mems_allowed_list:	0
voluntary_ctxt_switches:	0
nonvoluntary_ctxt_switches:	0
```

## 剖析

* TracerPid

```sh
# [窗口 1]

# 追踪 top 程序
$ strace top
```

```sh
# [窗口 2]

$ ps -ef | grep "[t]op"
root     3811608 2645745  1 09:12 pts/32   00:00:10 strace top # strace 进程的 PID=3811608
root     3811611 3811608  1 09:12 pts/32   00:00:06 top        # top 进程的 PID=3811611，父进程为 strace 进程

$ cat /proc/3811611/status | grep TracerPid
TracerPid:	3811608 # strace 进程的 PID
```

## 参考

* [Linux 下进程信息 /proc/pid/status 的深入分析](https://blog.csdn.net/beckdon/article/details/48491909)

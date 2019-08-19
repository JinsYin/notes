# /proc/[pid]/status

* 该文件内容随时间而改变，解析内容时应当查找特殊字符串（如 PPid）来匹配行记录，而不是使用行号

```bash
$ cat /proc/self/status
-----------------------
Name:	cat                  # 该进程运行的命令名
State:	R (running)          # 进程状态
Tgid:	86487
Ngid:	0
Pid:	86487
PPid:	55292
TracerPid:	0
Uid:	1000	1000	1000	1000
Gid:	1000	1000	1000	1000
FDSize:	256
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
VmPTE:	      44 kB
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
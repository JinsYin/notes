# /proc/[pid]/status

```bash
$ cat /proc/$$/status
---------------------
Name: bash
State:  S (sleeping)
Tgid: 505996
Ngid: 0
Pid:  505996
PPid: 505995
TracerPid:  0
Uid:  0 0 0 0
Gid:  0 0 0 0
FDSize: 256
Groups: 0
NStgid: 505996
NSpid:  505996
NSpgid: 505996
NSsid:  502224
VmPeak:    37524 kB
VmSize:    37012 kB
VmLck:         0 kB
VmPin:         0 kB
VmHWM:     15844 kB
VmRSS:     15844 kB
VmData:    12104 kB
VmStk:       132 kB
VmExe:       960 kB
VmLib:      2296 kB
VmPTE:        92 kB
VmPMD:        12 kB
VmSwap:        0 kB
HugetlbPages:        0 kB
Threads:  1
SigQ: 4/128424
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000010000
SigIgn: 0000000000380004
SigCgt: 000000004b817efb
CapInh: 0000000000000000
CapPrm: 0000003fffffffff
CapEff: 0000003fffffffff
CapBnd: 0000003fffffffff
CapAmb: 0000000000000000
Seccomp:  0
Cpus_allowed: f
Cpus_allowed_list:  0-3
Mems_allowed: 00000000,00000001
Mems_allowed_list:  0
voluntary_ctxt_switches:  306
nonvoluntary_ctxt_switches: 69
```
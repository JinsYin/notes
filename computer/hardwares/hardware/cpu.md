# CPU

## 获取信息

```bash
$ lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                40
On-line CPU(s) list:   0-39
Thread(s) per core:    2
Core(s) per socket:    10
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 79
Model name:            Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
Stepping:              1
CPU MHz:               1200.842
CPU max MHz:           3100.0000
CPU min MHz:           1200.0000
BogoMIPS:              4400.10
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              25600K
NUMA node0 CPU(s):     0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38
NUMA node1 CPU(s):     1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm rdt_a rdseed adx smap xsaveopt cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local ibpb ibrs stibp dtherm ida arat pln pts spec_ctrl intel_stibp
```

```bash
% cat /proc/cpuinfo
```

## CPU 压测

* 通过 bc 命令计算特别函数

```bash
$ yum install -y bc

# 计算圆周率
$ time echo "scale=5000; 4*a(1)" | bc -l -q
```

```PlainText
s (x)  The sine of x, x is in radians.    正玄函数
c (x)  The cosine of x, x is in radians.  余玄函数
a (x)  The arctangent of x, arctangent returns radians. 反正切函数
l (x)  The natural logarithm of x.  log函数(以2为底)
e (x)  The exponential function of raising e to the value x.  e的指数函数
j (n,x) The bessel function of integer order n of x.   贝塞尔函数
```

## CPU 频率冲突

```bash
$ cat /proc/cpuinfo | grep "cpu MHz"
cpu MHz     : 1200.256
cpu MHz     : 1200.024
cpu MHz     : 1200.024
cpu MHz     : 1200.140
cpu MHz     : 1200.024
cpu MHz     : 1200.024
```

```bash
$ cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq
```
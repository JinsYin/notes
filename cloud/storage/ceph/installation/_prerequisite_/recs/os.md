# 操作系统建议

* 在较新的 Stable/LTS Linux 上部署 Ceph
* 为了避免各种问题，Ceph 客户端版本最好与 Ceph 集群服务器版本一致，而不是使用内核客户端（即内核模块）

## 平台

### LUMINOUS (12.2.Z)

| Distro | Release | Code Name    | Kernel       | Notes | Testing |
| ------ | ------- | ------------ | ------------ | ----- | ------- |
| CentOS | 7       | N/A          | linux-3.10.0 | 3     | B, I, C |
| RHEL   | 7       | Maipo        | linux-3.10.0 |       | B, I    |
| Ubuntu | 16.04   | Xenial Xerus | linux-4.4.0  | 3     | B, I, C |

## 内核调优

* Kernel PID Max

```bash
$ echo "4194303" > /proc/sys/kernel/pid_max
```

* Read ahead: Set in all block devices

```bash
$ echo "8192" > /sys/block/sda/queue/read_ahead_kb
```

* Swappiness:

```bash
$ echo "vm.swappiness=0" | tee -a /etc/sysctl.conf
```

* Disable NUMA:

```bash
$ echo 0 > /proc/sys/kernel/numa_balancing

# or

$ sysctl kernel.numa_balancing=0
```

* CPU Tuning: Set "performance" mode use 100% CPU frequency always

```bash
$ echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

* I/O Scheduler:

```bash
SATA/SAS Drives:  # echo "deadline" > /sys/block/sd[x]/queue/scheduler
SSD Drivers:      # echo "noop" > /sys/block/sd[x]/queue/scheduler
```

## 参考

* [OS RECOMMENDATIONS (mimic)](http://docs.ceph.com/docs/mimic/start/os-recommendations/)
* [Best Practices & Performance Tuning - OpenStack Cloud Storage with Ceph](https://www.slideshare.net/swamireddy/ceph-barcelonav12)
# [Cgroup](../../../cgroup/README.md) 虚拟文件系统

Linux 内核并未提供系统调用 API 来操作 Cgroup，而是通过 Cgroup vfs 来管理。

```sh
$ uname -r
----------
4.4.0-121-generic

$ ls -l /sys/fs/cgroup/
-----------------------
dr-xr-xr-x 4 root root 0  6月 10 17:03 blkio
dr-xr-xr-x 5 root root 0  6月 10 17:03 cpu
dr-xr-xr-x 4 root root 0  6月 10 17:03 cpuacct
dr-xr-xr-x 4 root root 0  6月 10 17:03 cpuset
dr-xr-xr-x 4 root root 0  6月 10 17:03 devices
dr-xr-xr-x 5 root root 0  6月 10 17:03 dsystemd
dr-xr-xr-x 4 root root 0  6月 10 17:03 freezer
dr-xr-xr-x 4 root root 0  6月 10 17:03 hugetlb
dr-xr-xr-x 4 root root 0  6月 10 17:03 memory
dr-xr-xr-x 4 root root 0  6月 10 17:03 net_cls
dr-xr-xr-x 4 root root 0  6月 10 17:03 net_prio
dr-xr-xr-x 4 root root 0  6月 10 17:03 perf_event
dr-xr-xr-x 3 root root 0  6月 10 17:03 pids
dr-xr-xr-x 4 root root 0  6月 10 17:03 systemd
```

## Cgroup Driver

* cgroupfs
* systemd - `/sys/fs/cgroup/systemd`（Docker 官方已放弃对 systemd 管理的 cgroup 的支持）

## 参考

* [kubelet cgroup driver: "cgroupfs" is different from docker cgroup driver: "systemd"](https://github.com/kubernetes/kubernetes/issues/43805)

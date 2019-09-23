# /proc/[pid]/cgroup

描述进程（即任务）所属的「控制组 cgroup」

## 示例

```sh
$ cat /proc/self/cgroup
11:devices:/user.slice
10:cpuset:/
9:cpuacct,cpu:/user.slice
8:hugetlb:/
7:blkio:/user.slice
6:pids:/user.slice
5:freezer:/
4:net_prio,net_cls:/
3:perf_event:/
2:memory:/user.slice
1:name=systemd:/user.slice/user-0.slice/session-1270.scope
```

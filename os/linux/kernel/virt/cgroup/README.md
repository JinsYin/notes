# Cgroup(s)

Cgroups（EN：Control Groups，CN：控制组）是 Linux 的内核功能，用于限制、统计和隔离一组进程的资源使用情况（CPU、内存、磁盘 I/O、网络等）。简而言之，Cgroup 为一组进程提供统一的资源管理，可以理解为 _控制进程组_。一个控制组（以下简写为 “一个组”）是受相同标准约束、并与一组参数或限制相关联的进程的集合。

## 版本

| 版本 | 发布时间 | 最初的内核版本 | 描述                                                                 |
| ---- | -------- | -------------- | -------------------------------------------------------------------- |
| v1   | 2008.1   | 2.6.24         | 最初由 Paul Menage 和 Rohit Seth 编写，于 2007 年并入 Linux 内核     |
| v2   | 2016.3   | 4.5            | 之后 Tejun Heo 接管了 cgroups 的开发和维护，重新设计和编写了 cgroups |

不同于 v1，cgroup v2 只有一个进程层次结构，并且可以区分进程，而非线程。

## 功能

Cgroups 的设计目标之一是为许多不同的用例提供统一的接口，从控制当个进程到整个操作系统级虚拟化。

| 功能                          | 描述                                             |
| ----------------------------- | ------------------------------------------------ |
| 资源限制（Resource limiting） | 组可以设置内存限制、文件系统缓存                 |
| 优先级（Prioritization）      | 某些组可以获得更大的 CPU 利用率或磁盘 I/O 吞吐量 |
| 统计（Accounting）            | 统计一个组的资源使用情况（可用于计费）           |
| 控制（Control）               | 冻结进程组、检查点和重启                         |

## 用法

![Linux kernel and daemons with exclusive access](https://upload.wikimedia.org/wikipedia/commons/4/44/Linux_kernel_and_daemons_with_exclusive_access.svg)

Cgroups 可以通过多种方式使用：

* 通过手动访问 [cgroup 虚拟文件系统](../fs/vfs/cgroup/README.md)
* 通过使用 `cgcreate`、`cgexec` 和 `cgclassify` 等工具（来自 libcgroup）动态创建和管理组
* 通过 “规则引擎守护进程”，可以自动将某些用户、组或命令的进程移动到其配置中指定的 cgroup
* 间接通过使用 cgroup 的软件，如 Docker、LXC、libvirt、systemd

## 控制器（子系统）

组是可以分层的，意味着每个组都会从其父组中继承相关的限制。内核通过 cgroup 接口提供对多个控制器（也称为 _子系统_）的访问。例如，“memory” 控制器限制对内存的使用，“cpuacct” 统计 CPU 使用率等。

| 子系统     | 对应的虚拟文件系统       | 描述                                                     |
| ---------- | ------------------------ | -------------------------------------------------------- |
| hugetlb    | `/sys/fs/cgroup/hugetlb` | 限制进程对大页内存（Hugpage）的使用                      |
| memory     | `/sys/fs/cgroup/memory`  | 限制对内存和交换空间的使用，并生成每个进程使用的资源统计 |
| pid        |                          | 限制每个 CGroup 创建的进程总数                           |
| cpuset     |                          | 在多核系统中为进程分配独立的 CPU 和内存                  |
| net_cls    |                          |                                                          |
| net_prio   |                          |                                                          |
| cpu        |                          |                                                          |
| cpuacct    |                          |                                                          |
| freezer    |                          |                                                          |
| blkio      |                          |                                                          |
| perf_event |                          |                                                          |
| rdma       |                          |                                                          |

```sh
$ mount | grep cgroup
---------------------
none on /sys/fs/cgroup type tmpfs (rw)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,relatime,cpuset)
cgroup on /sys/fs/cgroup/cpu type cgroup (rw,relatime,cpu)
cgroup on /sys/fs/cgroup/cpuacct type cgroup (rw,relatime,cpuacct)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,relatime,blkio)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,relatime,memory)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,relatime,devices)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,relatime,freezer)
cgroup on /sys/fs/cgroup/net_cls type cgroup (rw,relatime,net_cls)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,relatime,perf_event)
cgroup on /sys/fs/cgroup/net_prio type cgroup (rw,relatime,net_prio)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,relatime,hugetlb)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,relatime,pids)
systemd on /sys/fs/cgroup/systemd type cgroup (rw,noexec,nosuid,nodev,none,name=systemd)
```

## Cgroup Tools

* 安装

```sh
# Debian
$ apt install cgroup-tools

# RHEL
$ yum install libcgroup-tools
```

```sh

```

## 实验

* 查看容器相关的进程

```sh
# 83f...a5a 是 CONTAINER ID（可通过 docker inspect 查询获取）
$ cat /sys/fs/cgroup/pids/docker/83ffc45b751f3889a68673b9ef54405d63fc3c76bad9be676116aa8034c6fa5a/tasks
-------------------------------------------------------------------------------------------------------
687947 # 父进程
687988 # 子进程
```

## 参考

* [Control Group v2](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html)
* [cgroups - Linux control groups](http://man7.org/linux/man-pages/man7/cgroups.7.html)
* [cgroup-v1 Documentation](https://github.com/torvalds/linux/tree/master/Documentation/cgroup-v1)

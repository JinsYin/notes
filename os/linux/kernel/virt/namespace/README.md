# Linux Namespace

Linux Namespace - 隔离系统资源

## 分类

Linux 内核中包含 6 种 Namespace：

| Namespace                     | 描述                                                                                                                                                                        |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Cgroup Namespace](cgroup.md) | 提供基于 Cgroup 的隔离能力                                                                                                                                                  |
| [IPC Namespace](ipc.md)       | 提供基于 System V 进程信道的隔离能力                                                                                                                                        |
| [Mount Namespace](mount.md)   | 提供基于磁盘挂载和文件系统的隔离能力                                                                                                                                        |
| [Net Namespace](net.md)       | 提供基于网络栈的隔离能力                                                                                                                                                    |
| [Pid Namespace](pid.md)       | 提供基于进程的隔离能力。使得容器中的首个进程成为该命名空间中 PID 为 1 的初始化进程                                                                                          |
| [User Namespace](user.md)     | 提供基于系统用户的隔离能力，即同一系统用户在不同命名空间中用于不同的 UID 和 GID                                                                                             |
| [UTS Namespace](uts.md)       | 提供基于主机名的隔离能力，即在不同的命名空间，程序可以有不同的主机名（允许重复）；包含了运行内核的名称、版本、底层体系结构类型等信息；UTS 是 Unix Timesharing System 的缩写 |

```sh
# init 进程的 Namespace
$ ls -l /proc/1/ns
lrwxrwxrwx 1 root root 0  6月 10 14:22 cgroup -> cgroup:[4026531835]
lrwxrwxrwx 1 root root 0  6月 10 14:22 ipc -> ipc:[4026531839]
lrwxrwxrwx 1 root root 0  6月 10 14:22 mnt -> mnt:[4026531840]
lrwxrwxrwx 1 root root 0  6月 10 14:22 net -> net:[4026531957]
lrwxrwxrwx 1 root root 0  6月 10 14:22 pid -> pid:[4026531836]
lrwxrwxrwx 1 root root 0  6月 10 14:22 user -> user:[4026531837]
lrwxrwxrwx 1 root root 0  6月 10 14:22 uts -> uts:[4026531838]
```

```sh
# 当前进程的 Namespace
$ ls -l /proc/$$/ns
-------------------
lrwxrwxrwx 1 root root 0  6月 10 15:45 cgroup -> cgroup:[4026531835]
lrwxrwxrwx 1 root root 0  6月 10 15:45 ipc -> ipc:[4026531839]
lrwxrwxrwx 1 root root 0  6月 10 15:45 mnt -> mnt:[4026531840]
lrwxrwxrwx 1 root root 0  6月 10 15:45 net -> net:[4026531957]
lrwxrwxrwx 1 root root 0  6月 10 15:45 pid -> pid:[4026531836]
lrwxrwxrwx 1 root root 0  6月 10 15:45 user -> user:[4026531837]
lrwxrwxrwx 1 root root 0  6月 10 15:45 uts -> uts:[4026531838]
```

未使用容器时，系统中所有进程都具有相同的 Namespace ID 组合。

## 数据结构

`<include/linux/nsproxy.h>`：

```c
/*
 * A structure to contain pointers to all per-process
 * namespaces - fs (mount), uts, network, sysvipc, etc.
 *
 * The pid namespace is an exception -- it's accessed using
 * task_active_pid_ns.  The pid namespace here is the
 * namespace that children will use.
 *
 * 'count' is the number of tasks holding a reference.
 * The count for each namespace, then, will be the number
 * of nsproxies pointing to it, not the number of tasks.
 *
 * The nsproxy is shared by tasks which share all namespaces.
 * As soon as a single namespace is cloned or unshared, the
 * nsproxy is copied.
 */
struct nsproxy {
	atomic_t count;
	struct uts_namespace *uts_ns;
	struct ipc_namespace *ipc_ns;
	struct mnt_namespace *mnt_ns;
	struct pid_namespace *pid_ns_for_children;
	struct net 	     *net_ns;
	struct cgroup_namespace *cgroup_ns;
};
```

## 进程与命名空间的关系

命名空间的实现需要两部分：

1. 每个子系统的命名空间结构，将此前所有的全局组件包装到命名空间中
2. 将给定进程关联到所属各个命名空间的机制

## 系统调用

Linux 提供了以下系统调用来直接或间接管理命名空间：

| 系统调用                            | 描述                                                                                                                 |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| [clone()](../syscalls/clone.md)     | 默认创建一个新进程。传递一个或多个 `CLONE_NEW*` 标志可以为每个标志创建新的命名空间，并使子进程称为这些命名空间的成员 |
| [unshare()](../syscalls/unshare.md) | 使某进程脱离某个 Namespace                                                                                           |
| [setns()](../syscalls/setns.md)     | 允许一个进程加入已存在的命名空间。namspace 由 proc/[pid]/ns 中文件的文件描述符指定。                                 |


## 参考

* [Linux 的 CGroup 和 Namespace](https://kuops.com/2019/01/23/docker-namespace-cgroup/#NameSpace)

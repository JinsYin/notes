# Linux 能力

Linux 能力模型将传统的 all-or-nothing UNIX 权限模型划分成一个个能单独启用或禁用的 _能力（capability）_。

## 基本原理

传统的 Unix 权限模型将进程分为两类：能通过所有权限检测的有效用户 ID 为 0 （即超级用户）的进程，以及其他所有需要根据用户和组 ID 进行权限检测的进程。

## 能力列表

| 能力（capability）  | 进程特权                                                                                                                                                          |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CAP_AUDIT_CONTROL   | * 启用和禁用进程内核审计日志、修改审计的过滤规则、读取审计状态和过滤规则                                                                                          |
| CAP_AUDIT_WRITE     | * 向内核审计日志写入记录                                                                                                                                          |
| CAP_CHOWN           | * 修改文件的用户 ID （即所有者）或将文件的组 ID 修改为不包含进程的一个组（`chown()`）                                                                             |
| CAP_DAC_OVERRIDE    | * 绕过文件的读、写和执行权限检查（DAC 即 Discretionary Access Control）；<br> 读取 `/proc/[pid]` 中 cwd、exe 和 root 符号链接的内容                               |
| CAP_DAC_READ_SEARCH | * 绕过文件的读权限检查以及目录的读和搜索权限检查                                                                                                                  |
| CAP_FOWNER          |                                                                                                                                                                   |
| CAP_FSETID          | * 修改文件时使内核不关闭 set-user-ID 和 set-group-ID 位（`write()`、`truncate()`） <br> * 为 GID 与进程的文件系统 GID 或补充 GID 不匹配的文件启用 set-group-ID 位 |
| CAP_IPC_LOCK        | * 覆盖内存加锁限制（`mlock()`、`mlockall()`、`shmctl(SHM_LOCK)`、`shmctl(SHM_UNLOCK)`） <br> * 使用 `shmget()` 的 SHM_HUGETLB 标记和 `mmap()` 的 MAP_HUGETLB 标记 |

```sh
# 查看 Linux 能力
$ cat /usr/include/linux/capability.h
```

## 进程能力

每个进程/文件有三个能力集：_许可的（permitted，P）_、_有效的（effective，E）_ 和 _可继承的（inheritable，I）_，每个能力集包含零个或多个能力。

| 能力集      | 描述                                                                                   |
| ----------- | -------------------------------------------------------------------------------------- |
| permitted   | 定义了进程能够使用的能力                                                               |
| effective   | 定义了进程当前使用的能力；内核使用此能力集来进程进程是否有足够的权限执行某个特定的操作 |
| inheritable |                                                                                        |

`fork()` 创建的子进程会继承其父进程的能力集的副本。

## 特权

## 示例

```sh
# 查看进程的三个能力集（十六进制表示）
$ cat /proc/self/status | grep -i "Cap"
CapInh:	0000000000000000 # 继承的
CapPrm:	0000000000000000 # 许可的
CapEff:	0000000000000000 # 有效的
CapBnd:	0000003fffffffff
CapAmb:	0000000000000000
```

```sh
# getpcaps 来自 libcap 包
$ getpcaps 1
Capabilities for `1': = cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,cap_block_suspend,37+ep
```

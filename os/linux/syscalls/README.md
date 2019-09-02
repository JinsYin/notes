# Linux 系统调用与库函数

Linux 系统调用，也叫 Linux 编程接口（The Linux Programming Interface）。
库函数，也就是标准库的库接口。

## 帮助

```sh
$ man 2 syscalls
```

## 处理器模式和上下文切换

## syscall、glibc、kernel-headers 的关系

## nolibc

* `tools/include/nolibc/nolibc.h`

## unistd.h

* `include/linux/syscalls.h`
* `include/uapi/asm-generic/unistd.h`（`kill()` 对应于 `sys_kill()`） - 各种系统调用的原型

## 系统调用的内核查找方式

1. 用户空间的 `xyz()` 方法，对应于系统调用层的方法是 `sys_xyz()`
2. `include/uapi/asm-generic/unistd.h` 中记录着系统调用中断号的信息以及 `sys_xyz` 修改信息（包括其定义所在文件）

```c
/*
 * <include/uapi/asm-generic/unistd.h>
 */
...
/* kernel/signal.c */
__SYSCALL(__NR_kill, sys_kill)
```

3. 宏定义 SYSCALL_DEFINEx(xyz, ...) 展开后对应的方法就是 `sys_xyz()`

```c
/**
 * <include/uapi/asm-generic/unistd.h>
 *
 *  sys_kill - send a signal to a process
 *  @pid: the PID of the process
 *  @sig: signal to be sent
 */
SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
{
	struct kernel_siginfo info;

	prepare_kill_siginfo(sig, &info);

	return kill_something_info(sig, &info, pid);
}
```

4. 方法的参数个数为 `x`，对应于 SYSCALL_DEFINEx(xyz, ...) 的 `x`
5. 比如kill命令, 有两个参数. 则可以直接在kernel目录下搜索 “SYSCALL_DEFINE2(kill”,即可直接找到,所有对应的Syscall方法位于signal.c

## 参考

* [Linux 系统调用列表](https://www.ibm.com/developerworks/cn/linux/kernel/syscall/part1/appendix.html)
* [从 glibc 源码看系统调用原理](https://my.oschina.net/fileoptions/blog/908682)
* [Linux 系统调用（syscall）原理](http://gityuan.com/2016/05/21/syscall/)
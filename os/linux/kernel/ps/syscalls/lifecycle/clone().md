# clone() - 创建一个新进程

`clone()` 是 Linux 特有的系统调用，类似于 `fork()` 和 `vfokr()`，但不同的是，`clone()` 在进程创建期间对步骤的控制更为精准。由于 `clone()` 有损于程序的移植性，应避免在程序中直接使用。

`clone()` 主要用于线程库的实现。

## 手册

```sh
$ man 2 clone
```

## 语法

```c
#define _GNU_SOURCE /* glibc 包装函数的功能测试要求，见 feature_test_macros(7) */
#include <sched.h>

/*
 * @Return：调用成功则返回子进程的 PID，调用失败则返回 -1
 */
int clone(int (*fn)(void *), void *child_stack,
            int flags, void *arg, ...
            /* pid_t *ptid, struct user_desc *tls, pid_t *ctid */ );

/* Prototype for the raw system call */
long clone(unsigned long flags, void *child_stack,
            void *ptid, void *ctid,
            struct pt_regs *regs);
```

不同于 `fork()`，`clone()` 克隆的子进程继续运行时不以调用处为起点，而是去执行 fn 参数所指定的函数，fn 又称为「子函数」（child function）。调用子函数的参数有 args 指定。

## 内核源码

`fork()`、`vfork()` 和 `clone()` 都是由内核中的同一函数（`kernel/fork.c` 中的 `do_fork()`）实现的。

```c
/*
 * <kernel/fork.c>
 */

/*
 *  Ok, this is the main fork-routine.
 *
 * It copies the process, and if successful kick-starts
 * it and waits for it to finish using the VM if required.
 */
long _do_fork(unsigned long clone_flags,
	      unsigned long stack_start,
	      unsigned long stack_size,
	      int __user *parent_tidptr,
	      int __user *child_tidptr,
	      unsigned long tls)
{
	struct completion vfork;
	struct pid *pid;
	struct task_struct *p;
	int trace = 0;
	long nr;

	/*
	 * Determine whether and which event to report to ptracer.  When
	 * called from kernel_thread or CLONE_UNTRACED is explicitly
	 * requested, no event is reported; otherwise, report if the event
	 * for the type of forking is enabled.
	 */
	if (!(clone_flags & CLONE_UNTRACED)) {
		if (clone_flags & CLONE_VFORK)
			trace = PTRACE_EVENT_VFORK;
		else if ((clone_flags & CSIGNAL) != SIGCHLD)
			trace = PTRACE_EVENT_CLONE;
		else
			trace = PTRACE_EVENT_FORK;

		if (likely(!ptrace_event_enabled(current, trace)))
			trace = 0;
	}

	p = copy_process(clone_flags, stack_start, stack_size, parent_tidptr,
			 child_tidptr, NULL, trace, tls, NUMA_NO_NODE);
	add_latent_entropy();

	if (IS_ERR(p))
		return PTR_ERR(p);

	/*
	 * Do this prior waking up the new thread - the thread pointer
	 * might get invalid after that point, if the thread exits quickly.
	 */
	trace_sched_process_fork(current, p);

	pid = get_task_pid(p, PIDTYPE_PID);
	nr = pid_vnr(pid);

	if (clone_flags & CLONE_PARENT_SETTID)
		put_user(nr, parent_tidptr);

	if (clone_flags & CLONE_VFORK) {
		p->vfork_done = &vfork;
		init_completion(&vfork);
		get_task_struct(p);
	}

	wake_up_new_task(p);

	/* forking complete and child started to run, tell ptracer */
	if (unlikely(trace))
		ptrace_event_pid(trace, pid);

	if (clone_flags & CLONE_VFORK) {
		if (!wait_for_vfork_done(p, &vfork))
			ptrace_event_pid(PTRACE_EVENT_VFORK_DONE, pid);
	}

	put_pid(pid);
	return nr;
}

#ifndef CONFIG_HAVE_COPY_THREAD_TLS
/* For compatibility with architectures that call do_fork directly rather than
 * using the syscall entry points below. */
long do_fork(unsigned long clone_flags,
	      unsigned long stack_start,
	      unsigned long stack_size,
	      int __user *parent_tidptr,
	      int __user *child_tidptr)
{
	return _do_fork(clone_flags, stack_start, stack_size,
			parent_tidptr, child_tidptr, 0);
}
#endif
```

## 示例

```c
```

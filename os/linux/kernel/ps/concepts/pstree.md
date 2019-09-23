# 进程家族树（process tree）

所有进程都是 PID 为 1 的 init 进程的后代。内核在系统启动的最后阶段启动 init 进程，该进程读取系统的初始化脚本（initscript）并执行其他的相关程序，最终完成系统启动的整个过程。

每个进程都有一个父进程，相应的，每个进程也可以拥有零个或多个子进程。拥有相同父进程的所有进程被称为兄弟。

init 进程的进程描述符是作为 `init_task` 静态分配的。

```c
/*
 * <include/linux/sched.h>
 */

struct task_struct {
    ...
    /*
	 * Pointers to the (original) parent process, youngest child, younger sibling,
	 * older sibling, respectively.  (p->father can be replaced with
	 * p->real_parent->pid)
	 */

    /* Real parent process: */
	struct task_struct __rcu	*real_parent; /* 父进程 */

	/* Recipient of SIGCHLD, wait4() reports: */
	struct task_struct __rcu	*parent;

	/*
	 * Children/sibling form the list of natural children:
	 */
	struct list_head		children; /* 子进程链表 */
	struct list_head		sibling;
	struct task_struct		*group_leader;
    ...
};
```

## 示例

```c
/* 获取父进程的进程描述符 */
struct task_struct *myparent = current->parent;
```

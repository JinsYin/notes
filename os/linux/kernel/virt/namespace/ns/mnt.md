# Mount Namespace/FS Namespace

Linux 内核支持针对每个进程的挂载命名空间（mount namespace），意味着每个进程都可能拥有属于自己的一组文件系统挂载点，因此进程视角下的单根目录层级彼此会有所不同。

进程的文件系统挂载点，见 `/proc/[pid]/mounts`
系统的文件系统挂载点，见 `/proc/mounts`

## 内核代码

```c
/*
 * <fs/mount.h>
 */
struct mnt_namespace {
	atomic_t		count;
	struct ns_common	ns;
	struct mount *	root;
	struct list_head	list;
	struct user_namespace	*user_ns;
	struct ucounts		*ucounts;
	u64			seq;	/* Sequence number to prevent loops */
	wait_queue_head_t poll;
	u64 event;
	unsigned int		mounts; /* # of mounts in the namespace */
	unsigned int		pending_mounts;
} __randomize_layout;
```

```c
/*
 * <fs/namespace.c>
 */
```
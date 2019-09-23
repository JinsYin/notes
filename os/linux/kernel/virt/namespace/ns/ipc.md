# IPC Namespace

## 内核代码

```c
/*
 * <include/linux/ipc.h>
 *
 * used by in-kernel data structures
 */
struct kern_ipc_perm {
	spinlock_t	lock;
	bool		deleted;
	int		id;
	key_t		key;
	kuid_t		uid;
	kgid_t		gid;
	kuid_t		cuid;
	kgid_t		cgid;
	umode_t		mode;
	unsigned long	seq;
	void		*security;

	struct rhash_head khtnode;

	struct rcu_head rcu;
	refcount_t refcount;
} ____cacheline_aligned_in_smp __randomize_layout;
```

```c
/*
 * <ipc/namespace.c>
 *
 *
 *
 */
```

# file_lock_context

```c
/*
 * <include/linux/fs.h>
 */
struct file_lock_context {
	spinlock_t		flc_lock;
	struct list_head	flc_flock;
	struct list_head	flc_posix;
	struct list_head	flc_lease;
};
```
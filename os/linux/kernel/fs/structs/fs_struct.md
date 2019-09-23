# fs_struct

```c
/*
 * <include/linux/fs_struct.h>
 */
struct fs_struct {
	int users;
	spinlock_t lock;
	seqcount_t seq;
	int umask;
	int in_exec;
	struct path root, pwd;
} __randomize_layout;
```

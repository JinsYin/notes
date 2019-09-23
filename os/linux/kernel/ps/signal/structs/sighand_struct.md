# sighand_struct

```c
/*
 * <include/linux/sched/signal.h>
 */
struct sighand_struct {
	refcount_t		count;
	struct k_sigaction	action[_NSIG];
	spinlock_t		siglock;
	wait_queue_head_t	signalfd_wqh;
};
```

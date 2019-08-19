# 信号量（semaphore）

## 数据结构

```c
/*
 * <ipc/sem.c>
 *
 * One semaphore structure for each semaphore in the system.
 */
struct sem {
	int	semval;		/* current value */
	/*
	 * PID of the process that last modified the semaphore. For
	 * Linux, specifically these are:
	 *  - semop
	 *  - semctl, via SETVAL and SETALL.
	 *  - at task exit when performing undo adjustments (see exit_sem).
	 */
	struct pid *sempid;
	spinlock_t	lock;	/* spinlock for fine-grained semtimedop */
	struct list_head pending_alter; /* pending single-sop operations */
					/* that alter the semaphore */
	struct list_head pending_const; /* pending single-sop operations */
					/* that do not alter the semaphore*/
	time64_t	 sem_otime;	/* candidate for sem_otime */
} ____cacheline_aligned_in_smp;
```
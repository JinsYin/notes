# hmm

```c
/*
 * <include/linux/hmm.h>
 *
 * struct hmm - HMM per mm struct
 *
 * @mm: mm struct this HMM struct is bound to
 * @lock: lock protecting ranges list
 * @ranges: list of range being snapshotted
 * @mirrors: list of mirrors for this mm
 * @mmu_notifier: mmu notifier to track updates to CPU page table
 * @mirrors_sem: read/write semaphore protecting the mirrors list
 * @wq: wait queue for user waiting on a range invalidation
 * @notifiers: count of active mmu notifiers
 * @dead: is the mm dead ?
 */
struct hmm {
	struct mm_struct	*mm;
	struct kref		kref;
	struct mutex		lock;
	struct list_head	ranges;
	struct list_head	mirrors;
	struct mmu_notifier	mmu_notifier;
	struct rw_semaphore	mirrors_sem;
	wait_queue_head_t	wq;
	struct rcu_head		rcu;
	long			notifiers;
	bool			dead;
};
```
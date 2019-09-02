# file_lock

```c
/*
 * <include/linux/fs.h>
 *
 * struct file_lock represents a generic "file lock". It's used to represent
 * POSIX byte range locks, BSD (flock) locks, and leases. It's important to
 * note that the same struct is used to represent both a request for a lock and
 * the lock itself, but the same object is never used for both.
 *
 * FIXME: should we create a separate "struct lock_request" to help distinguish
 * these two uses?
 *
 * The varous i_flctx lists are ordered by:
 *
 * 1) lock owner
 * 2) lock range start
 * 3) lock range end
 *
 * Obviously, the last two criteria only matter for POSIX locks.
 */
struct file_lock {
	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
	struct list_head fl_list;	/* link into file_lock_context */
	struct hlist_node fl_link;	/* node in global lists */
	struct list_head fl_blocked_requests;	/* list of requests with
						 * ->fl_blocker pointing here
						 */
	struct list_head fl_blocked_member;	/* node in
						 * ->fl_blocker->fl_blocked_requests
						 */
	fl_owner_t fl_owner;
	unsigned int fl_flags;
	unsigned char fl_type;
	unsigned int fl_pid;
	int fl_link_cpu;		/* what cpu's list is this on? */
	wait_queue_head_t fl_wait;
	struct file *fl_file;
	loff_t fl_start;
	loff_t fl_end;

	struct fasync_struct *	fl_fasync; /* for lease break notifications */
	/* for lease breaks: */
	unsigned long fl_break_time;
	unsigned long fl_downgrade_time;

	const struct file_lock_operations *fl_ops;	/* Callbacks for filesystems */
	const struct lock_manager_operations *fl_lmops;	/* Callbacks for lockmanagers */
	union {
		struct nfs_lock_info	nfs_fl;
		struct nfs4_lock_info	nfs4_fl;
		struct {
			struct list_head link;	/* link in AFS vnode's pending_locks list */
			int state;		/* state of grant or error if -ve */
			unsigned int	debug_id;
		} afs;
	} fl_u;
} __randomize_layout;
```
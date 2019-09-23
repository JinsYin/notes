# fuse_file

```c
/*
 * <fs/fuse/fuse_i.h>
 *
 * FFUSE specific file data
 */
struct fuse_file {
	/** Fuse connection for this file */
	struct fuse_conn *fc;

	/*
	 * Request reserved for flush and release.
	 * Modified under relative fuse_inode::lock.
	 */
	struct fuse_req *reserved_req;

	/** Kernel file handle guaranteed to be unique */
	u64 kh;

	/** File handle used by userspace */
	u64 fh;

	/** Node id of this file */
	u64 nodeid;

	/** Refcount */
	refcount_t count;

	/** FOPEN_* flags returned by open */
	u32 open_flags;

	/** Entry on inode's write_files list */
	struct list_head write_entry;

	/* Readdir related */
	struct {
		/*
		 * Protects below fields against (crazy) parallel readdir on
		 * same open file.  Uncontended in the normal case.
		 */
		struct mutex lock;

		/* Dir stream position */
		loff_t pos;

		/* Offset in cache */
		loff_t cache_off;

		/* Version of cache we are reading */
		u64 version;

	} readdir;

	/** RB node to be linked on fuse_conn->polled_files */
	struct rb_node polled_node;

	/** Wait queue head for poll */
	wait_queue_head_t poll_wait;

	/** Has flock been performed on this file? */
	bool flock:1;
};
```

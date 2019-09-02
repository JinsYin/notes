# 文件系统

**struct file_system_type** 描述了文件系统。

```c
struct file_system_type {
	const char *name; /* 文件系统类型的名称，如 ext2、xfs 等等 */
	int fs_flags; /* 各种文件系统标志，即 FS_REQUIRES_DEV、FS_NO_DCACHE 等 */
    struct dentry *(*mount) (struct file_system_type *, int,
                    const char *, void *);
    void (*kill_sb) (struct super_block *);
    struct module *owner;
    struct file_system_type * next;
    struct list_head fs_supers;
	struct lock_class_key s_lock_key;
	struct lock_class_key s_umount_key;
};
```
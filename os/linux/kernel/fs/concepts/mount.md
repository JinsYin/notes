# 挂载与卸载

## 单根目录层级与多根目录层级

Linux 上所有文件系统中的文件都位于单根目录树下，树根是根目录 `/`。其他文件系统被挂载在根目录之下，视为整个目录层级的子树（subtree）。

## 挂载与卸载

挂载文件系统:

```sh
# 将名为 device 的文件系统挂载到 directory 目录
$ sudo mount -t <type> <device> <directory>
```

卸载：

```sh
$ sudo umount <device>
# 或
$ sudo umount <directory>
```

查看已挂载的文件系统：

```sh
$ mount
```

## 内核代码

```c
/*
 * <fs/mount.h>
 */
struct mount {
	struct hlist_node mnt_hash;
	struct mount *mnt_parent;
	struct dentry *mnt_mountpoint;
	struct vfsmount mnt;
	union {
		struct rcu_head mnt_rcu;
		struct llist_node mnt_llist;
	};
#ifdef CONFIG_SMP
	struct mnt_pcp __percpu *mnt_pcp;
#else
	int mnt_count;
	int mnt_writers;
#endif
	struct list_head mnt_mounts;	/* list of children, anchored here */
	struct list_head mnt_child;	/* and going through their mnt_child */
	struct list_head mnt_instance;	/* mount instance on sb->s_mounts */
	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
	struct list_head mnt_list;
	struct list_head mnt_expire;	/* link in fs-specific expiry list */
	struct list_head mnt_share;	/* circular list of shared mounts */
	struct list_head mnt_slave_list;/* list of slave mounts */
	struct list_head mnt_slave;	/* slave list entry */
	struct mount *mnt_master;	/* slave is on master->mnt_slave_list */
	struct mnt_namespace *mnt_ns;	/* containing namespace */
	struct mountpoint *mnt_mp;	/* where is it mounted */
	struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
	struct list_head mnt_umounting; /* list entry for umount propagation */
#ifdef CONFIG_FSNOTIFY
	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
	__u32 mnt_fsnotify_mask;
#endif
	int mnt_id;			/* mount identifier */
	int mnt_group_id;		/* peer group identifier */
	int mnt_expiry_mark;		/* true if marked for expiry */
	struct hlist_head mnt_pins;
	struct fs_pin mnt_umount;
	struct dentry *mnt_ex_mountpoint;
} __randomize_layout;
```

## 示例

```sh
# 查看当前内核所知道的文件系统
$ cat /proc/filesystems

# 第一列是 inode 编号
$ ls -li /etc/passwd
702721 -rw-r--r--  1 root  wheel  6804  2 26 11:36 /etc/passwd
```
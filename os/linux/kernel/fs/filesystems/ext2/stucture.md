# Ext2 文件系统结构

## 磁盘布局

在引导块之后，ext2 文件系统被划分为一系列大小相等的块组（block group）。每个块组都包含一份超级块的拷贝、与块相关的参数信息，以及该块组的 inode 表和数据块。ext2 会尽量在同一个组存储一个文件的所有块，以期在对文件线性访问时缩短寻道时间。

```graph
                          +-------------+-------------+-------------+
                          | Partition 0 | Partition 1 | Partition 2 |    Disk
                          +-------------+-------------+-------------+
                                        |             |
                                        v             v
           +----------------------------+             +----------------------------+
           v                                                                       v
           +------------+---------------+---------------+----------+---------------+
           | Boot Block | Block Group 0 | Block Group 1 |  ......  | Block Group N |    File system
           +------------+---------------+---------------+----------+---------------+
                                        |               |
                                        v               v
+---------------------------------------+               +----------------------------------------+
v                                                                                                v
+-------------+-------------------+-------------------+--------------+-------------+-------------+
| Super Block | Group Descriptors | Data Block Bitmap | Inode Bitmap | Inode Table | Data Blocks |    Block Group
+-------------+-------------------+-------------------+--------------+-------------+-------------+
    1 block          N blocks            1 block           1 block       N blocks      N blocks
```

## 文件系统结构

## 超级块（Super block）

```c
struct ext2_super_block {
	__u32	s_inodes_count;		/* Inodes count */
	__u32	s_blocks_count;		/* Blocks count */
	...
	__u32	s_free_blocks_count;	/* Free blocks count */
	__u32	s_free_inodes_count;	/* Free inodes count */
	__u32	s_first_data_block;	/* First Data Block */
	__u32	s_log_block_size;	/* Block size */
	...
	__u32	s_blocks_per_group;	/* # Blocks per group */
	...
	__u16	s_magic;		/* Magic signature */
	...
};
```

## 组描述符（Group descriptors）

```c
struct ext2_group_desc
{
	__u32	bg_block_bitmap;	/* Blocks bitmap block */
	__u32	bg_inode_bitmap;	/* Inodes bitmap block */
	__u32	bg_inode_table;		/* Inodes table block */
	__u16	bg_free_blocks_count;	/* Free blocks count */
	__u16	bg_free_inodes_count;	/* Free inodes count */
	__u16	bg_used_dirs_count;	/* Directories count */
	__u16	bg_pad;
	__u32	bg_reserved[3];
};
```

## 块位图（Block bitmap）

## inode 位图（inode bitmap）

## inode 表

```c
static void read_inode(fd, inode_no, group, inode)
     int                           fd;        /* the floppy disk file descriptor */
     int                           inode_no;  /* the inode number to read  */
     const struct ext2_group_desc *group;     /* the block group to which the inode belongs */
     struct ext2_inode            *inode;     /* where to put the inode */
{
	lseek(fd, BLOCK_OFFSET(group->bg_inode_table)+(inode_no-1)*sizeof(struct ext2_inode), SEEK_SET);
	read(fd, inode, sizeof(struct ext2_inode));
}

```

## 参考

* [The Ext2 Filesystem](http://cs.smith.edu/~nhowe/Teaching/csc262/oldlabs/ext2.html)
* [Design and Implementation of the Second Extended Filesystem](http://e2fsprogs.sourceforge.net/ext2intro.html)
* [Disk layout of ext2 and ocfs2](https://oss.oracle.com/projects/ocfs2/dist/documentation/disklayout.pdf)
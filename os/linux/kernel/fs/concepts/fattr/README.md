# 文件属性（File Attribute）

文件属性是与文件系统中的文件相关联的文件元数据（file metadata）。

* 设备号
* inode 编号
* 文件所有权
* 链接数
* 文件类型
  * 常规文件的权限
  * 目录权限
* 文件权限
* 文件大小、已分配块、最优 I/O 块大小
* 文件时间戳
* 文件属主

## 查看文件属性

```sh
$ stat /dev/null
  File: ‘/dev/null’
  Size: 0         	Blocks: 0          IO Block: 4096   character special file
Device: 6h/6d	Inode: 6           Links: 1     Device type: 1,3
Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2019-07-22 02:10:05.847834016 +0800
Modify: 2019-07-22 02:10:05.847834016 +0800
Change: 2019-07-22 02:10:05.847834016 +0800
 Birth: -
```

## 内核代码

```c
/*
 * <include/linux/fs.h>
 *
 * Attribute flags.  These should be or-ed together to figure out what
 * has been changed!
 */
#define ATTR_MODE	(1 << 0)
#define ATTR_UID	(1 << 1)
#define ATTR_GID	(1 << 2)
#define ATTR_SIZE	(1 << 3)
#define ATTR_ATIME	(1 << 4)
#define ATTR_MTIME	(1 << 5)
#define ATTR_CTIME	(1 << 6)
#define ATTR_ATIME_SET	(1 << 7)
#define ATTR_MTIME_SET	(1 << 8)
#define ATTR_FORCE	(1 << 9) /* Not a change, but a change it */
#define ATTR_KILL_SUID	(1 << 11)
#define ATTR_KILL_SGID	(1 << 12)
#define ATTR_FILE	(1 << 13)
#define ATTR_KILL_PRIV	(1 << 14)
#define ATTR_OPEN	(1 << 15) /* Truncating from open(O_TRUNC) */
#define ATTR_TIMES_SET	(1 << 16)
#define ATTR_TOUCH	(1 << 17)
```

```c
/*
 * <fs/stat.c>
 *
 * generic_fillattr - Fill in the basic attributes from the inode struct
 * @inode: Inode to use as the source
 * @stat: Where to fill in the attributes
 *
 * Fill in the basic attributes in the kstat structure from data that's to be
 * found on the VFS inode structure.  This is the default if no getattr inode
 * operation is supplied.
 */
void generic_fillattr(struct inode *inode, struct kstat *stat)
{
	stat->dev = inode->i_sb->s_dev;
	stat->ino = inode->i_ino;
	stat->mode = inode->i_mode;
	stat->nlink = inode->i_nlink;
	stat->uid = inode->i_uid;
	stat->gid = inode->i_gid;
	stat->rdev = inode->i_rdev;
	stat->size = i_size_read(inode);
	stat->atime = inode->i_atime;
	stat->mtime = inode->i_mtime;
	stat->ctime = inode->i_ctime;
	stat->blksize = i_blocksize(inode);
	stat->blocks = inode->i_blocks;
}
EXPORT_SYMBOL(generic_fillattr);
```

## 相关命令

* [stat](.) - 显示文件或文件系统状态

## 系统调用

* `stat()`、`lstat()`、`fstat()`

## 参考

* [File attribute](https://en.wikipedia.org/wiki/File_attribute)

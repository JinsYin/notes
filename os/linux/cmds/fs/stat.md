# stat

查看文件或文件系统的状态。其中，文件状态包括文件大小、文件块数量、文件块大小、文件类型、文件模式、inode 编号、链接数、文件所有者及所在组、atime、mtime、ctime 等（注意，没有文件名）

## 示例

```sh
$ stat /etc/passwd
  File: ‘/etc/passwd’
  Size: 2965      	Blocks: 8          IO Block: 4096   regular file
Device: 811h/2065d	Inode: 3677017     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2019-07-16 00:15:01.047041045 +0800
Modify: 2019-06-21 14:14:16.037970261 +0800
Change: 2019-06-21 14:14:16.041970348 +0800
 Birth: -
```
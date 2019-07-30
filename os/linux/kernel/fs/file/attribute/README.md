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

## 系统调用

* `stat()`、`lstat()`、`fstat()`

## 参考

* [File attribute](https://en.wikipedia.org/wiki/File_attribute)
# stat

显示文件或文件系统的状态（没有参数选项时，默认显示文件状态）。

文件状态包括（注：没有文件名））：

* 文件大小
* 文件块数量
* 文件块大小
* 文件类型
* 文件模式
* inode 编号
* 链接数、
* 文件所有者及所在组
* 文件时间戳：atime、mtime、ctime 等

文件系统状态包括：

* 文件系统 ID
* 文件系统类型
* 文件系统（逻辑）块大小
* 块的数量：总数、空闲数、可用数
* inode 数量：总数、空闲数

## 语法

```sh
stat [OPTION]... FILE...
```

## 选项

| 选项 | 描述                           |
| ---- | ------------------------------ |
| `-f` | 显示文件系统状态，而非文件状态 |

## 示例

### 文件状态

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

### 文件系统状态

```sh
# 当前目录所在的文件系统
$ stat -f .
  File: "."
    ID: b6b5bba30b643afb Namelen: 255     Type: ext2/ext3
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 28811658   Free: 3047444    Available: 1642021
Inodes: Total: 7331840    Free: 5513334
```

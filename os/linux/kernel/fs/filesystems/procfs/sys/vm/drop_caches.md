# /proc/sys/vm/drop_caches

写入数值（1、2、3）到此文件，以使内核释放内存中的 cache、dentry 和 inode，从而使内存空闲出来。

## 值含义

| 值  | 描述                        |
| --- | --------------------------- |
| 0   | 默认值，不做任何操作        |
| 1   | 释放页缓存（page cache）    |
| 2   | 释放 dentry 和 inode        |
| 3   | 释放页缓存、dentry 和 inode |

为了避免内存中的数据丢失，必须首先执行 `sync` 命令将内存数据刷新至磁盘。

## 示例

```sh
# 释放页缓存
$ sync && echo 1 > /proc/sys/vm/drop_caches

# 释放 dentry 和 inode
$ sync && echo 2 > /proc/sys/vm/drop_caches

# 释放页缓存、dentry 和 inode
$ sync && echo 3 > /proc/sys/vm/drop_caches
```

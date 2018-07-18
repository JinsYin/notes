# 内存

## 清除缓存

```bash
# 释放 pagecache
$ sync && echo 1 > /proc/sys/vm/drop_caches

# 释放 dentry and inode
$ sync && echo 2 > /proc/sys/vm/drop_caches

# 释放 pagecache, dentry 和 inode
$ sync && echo 3 > /proc/sys/vm/drop_caches
```

生产环境下，通常只释放 pagecache。

参数说明：

  0：不释放（系统默认值）
  1：释放页缓存
  2：释放dentries和inodes
  3：释放所有缓存

```bash
% sysctl vm.drop_caches=1
```

## 释放交换空间

```bash
% swapoff -a && swapon -a
```
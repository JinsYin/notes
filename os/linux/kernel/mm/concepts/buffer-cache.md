# Buffer Cache、Buffer 与 Cache

「缓冲区缓存」（Buffer Cache）
「缓冲区」（Buffer）
「缓存」（Cache）

`sync` 命令强制刷新「缓冲区」数据到磁盘，可以在希望确保所有数据都被安全写入时使用。

## 缓存（cache）

缓存实际上并不缓冲文件，而是块，它是磁盘 I/O 的最小单元。这样，还缓存了目录、超级块、其他文件系统记账（bookkeeping）数据和非文件系统磁盘。

为了最有效地利用实际内存，Linux自动使用所有空闲RAM进行缓冲区缓存，但在程序需要更多内存时也会自动使缓存更小。

在Linux下，您不需要做任何事情来使用缓存，它会完全自动发生。

## 清除缓存

* 永久

```sh
# 释放 pagecache
$ sync && echo 1 > /proc/sys/vm/drop_caches

# 释放 dentry 和 inode
$ sync && echo 2 > /proc/sys/vm/drop_caches

# 释放 pagecache、 dentry 和 inode
$ sync && echo 3 > /proc/sys/vm/drop_caches
```

参数说明：

  0：不释放（系统默认值）
  1：释放页缓存
  2：释放dentries和inodes
  3：释放所有缓存

* 临时

```sh
% sysctl vm.drop_caches=1
```


## 参考

* [The buffer cache](https://www.tldp.org/LDP/sag/html/buffer-cache.html)

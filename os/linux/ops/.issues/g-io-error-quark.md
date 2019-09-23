# g-io-error-quark

## QA

* Question

重启任何服务都会收到以下错误信息，并且服务器重启后无法自动进入系统（会进入紧急模式 **emergency mode**）：

```plain
Error getting authority: Error initializing authority: Could not connect: No such file or directory (g-io-error-quark, 1) when booted into Rescue Mode from an installation media
```

* Answer

这个问题是由于 `/etc/fstab` 文件中添加的分区已不存在，导致开机后无法加载相应的分区，进入 **emergency mode** 后手动删除即可解决该问题。

```sh
# 删除前可能需要先查一查各分区的 UUID
$ blkid

# 从中删除不存在的分区
$ vi /etc/fstab
```

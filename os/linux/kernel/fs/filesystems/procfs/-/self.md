# /proc/self

指向当前进程的 proc 目录，即 `/proc/[pid]`。

## 示例

```sh
# 重复执行，发现 PID 在增加
$ ls -l /proc/self # 相当于 ls -l /proc/12427
lrwxrwxrwx. 1 root root 0 7月   5 02:53 /proc/self -> 12427

$ ls -l /proc/self/mounts
-r--r--r--. 1 root root 0 7月  22 08:11 /proc/self/mounts
```

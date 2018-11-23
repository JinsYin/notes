# init

`init` 是一个初始化工具，不同的操作系统可能使用不同的初始化工具，比如 CentOS 使用 `systemd` 作为 init.

```bash
# CentOS 7
$ ll /sbin/init
lrwxrwxrwx. 1 root root 22 10月  9 17:49 /sbin/init -> ../lib/systemd/systemd
```
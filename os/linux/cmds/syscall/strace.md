# strace

`strace` 用于追踪（**trace**）进程执行过程中调用的系统调用（**s**ystem calls）以及接收到的信号（**s**ignals）。

## 示例

```sh
# 每一行是一个系统调用
# 等号左边是系统调用的名称及其参数
# 等号右边是调用的返回值
$ strace /dev/null
execve("/bin/cat", ["cat", "/dev/null"], [/* 79 vars */]) = 0
brk(0)                                  = 0x7e0000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=146460, ...}) = 0
mmap(NULL, 146460, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7efe80d7f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P \2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1857312, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7efe80d7e000
mmap(NULL, 3965632, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7efe807b8000
mprotect(0x7efe80976000, 2097152, PROT_NONE) = 0
mmap(0x7efe80b76000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1be000) = 0x7efe80b76000
mmap(0x7efe80b7c000, 17088, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7efe80b7c000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7efe80d7c000
arch_prctl(ARCH_SET_FS, 0x7efe80d7c740) = 0
mprotect(0x7efe80b76000, 16384, PROT_READ) = 0
mprotect(0x60a000, 4096, PROT_READ)     = 0
mprotect(0x7efe80da3000, 4096, PROT_READ) = 0
munmap(0x7efe80d7f000, 146460)          = 0
brk(0)                                  = 0x7e0000
brk(0x801000)                           = 0x801000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=7216688, ...}) = 0
mmap(NULL, 7216688, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7efe800d6000
close(3)                                = 0
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 25), ...}) = 0
open("/dev/null", O_RDONLY)             = 3
fstat(3, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) = 0
read(3, "", 65536)                      = 0
close(3)                                = 0
close(1)                                = 0
close(2)                                = 0
exit_group(0)                           = ?
+++ exited with 0 +++
```

## 参考

* [strace 跟踪进程中的系统调用](https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/strace.html)

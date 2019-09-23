# /proc/[pid]/maps

## 字段

| 字段     | 描述                                                                                                                                                                                                                                                                                                                                                                                       |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| address  | 进程中映射所占用的地址空间                                                                                                                                                                                                                                                                                                                                                                 |
| perms    | 权限集：<br>* r = read <br>* w = write <br>* x = execute <br>* s = shared <br>* p = private (copy on write)                                                                                                                                                                                                                                                                                |
| offset   | 文件或一切事物的偏移量                                                                                                                                                                                                                                                                                                                                                                     |
| dev      | 设备号，格式：`主设备号:副设备号`。若 **pathname** 是伪路径，则为 `00:00`                                                                                                                                                                                                                                                                                                                  |
| inode    | 对应设备文件的 inode 。其中，0 表示没有 inode 与内存区域相关联，就像 BSS（未初始化数据段）那样。若 **pathname** 是伪路径，则为 `0`                                                                                                                                                                                                                                                         |
| pathname | 通常是可映射的文件。对于 ELF 文件，可以通过查看 ELF 程序头（`readelf-l`）中的偏移字段轻松地与偏移字段进行协调。若该字段为空，则表示一个通过 `mmap()` 映射创建的匿名映射。额外伪路径：<br>* `[stack]`：初始化进程（亦称主线程）的栈 <br>* `[stack:<tid>]`：线程的栈（`<tid>` 即线程 ID），对应于 `/proc/[pid]/tasks/[tid]/` <br>* `[vdso]`：虚拟动态链接的共享对象 <br>* `[heap]`：进程的堆 |

## 示例

```sh
address           perms offset  dev   inode       pathname
00400000-00452000 r-xp 00000000 08:02 173521      /usr/bin/dbus-daemon
00651000-00652000 r--p 00051000 08:02 173521      /usr/bin/dbus-daemon
00652000-00655000 rw-p 00052000 08:02 173521      /usr/bin/dbus-daemon
00e03000-00e24000 rw-p 00000000 00:00 0           [heap]
00e24000-011f7000 rw-p 00000000 00:00 0           [heap]
...
35b1800000-35b1820000 r-xp 00000000 08:02 135522  /usr/lib64/ld-2.15.so
35b1a1f000-35b1a20000 r--p 0001f000 08:02 135522  /usr/lib64/ld-2.15.so
35b1a20000-35b1a21000 rw-p 00020000 08:02 135522  /usr/lib64/ld-2.15.so
35b1a21000-35b1a22000 rw-p 00000000 00:00 0
35b1c00000-35b1dac000 r-xp 00000000 08:02 135870  /usr/lib64/libc-2.15.so
35b1dac000-35b1fac000 ---p 001ac000 08:02 135870  /usr/lib64/libc-2.15.so
35b1fac000-35b1fb0000 r--p 001ac000 08:02 135870  /usr/lib64/libc-2.15.so
35b1fb0000-35b1fb2000 rw-p 001b0000 08:02 135870  /usr/lib64/libc-2.15.so
...
f2c6ff8c000-7f2c7078c000 rw-p 00000000 00:00 0    [stack:986]
...
7fffb2c0d000-7fffb2c2e000 rw-p 00000000 00:00 0   [stack]
7fffb2d48000-7fffb2d49000 r-xp 00000000 00:00 0   [vdso]
```

```sh
$ cat /proc/$$/maps
-------------------
00400000-004f0000 r-xp 00000000 08:11 3801155                            /bin/bash
006ef000-006f0000 r--p 000ef000 08:11 3801155                            /bin/bash
006f0000-006f9000 rw-p 000f0000 08:11 3801155                            /bin/bash
006f9000-006ff000 rw-p 00000000 00:00 0
00c43000-0175d000 rw-p 00000000 00:00 0                                  [heap]
7f75c3928000-7f75c3932000 r-xp 00000000 08:11 4224737                    /lib/x86_64-linux-gnu/libnss_files-2.19.so
7f75c3932000-7f75c3b31000 ---p 0000a000 08:11 4224737                    /lib/x86_64-linux-gnu/libnss_files-2.19.so
7f75c3b31000-7f75c3b32000 r--p 00009000 08:11 4224737                    /lib/x86_64-linux-gnu/libnss_files-2.19.so
7f75c3b32000-7f75c3b33000 rw-p 0000a000 08:11 4224737                    /lib/x86_64-linux-gnu/libnss_files-2.19.so
7f75c3b33000-7f75c3b3e000 r-xp 00000000 08:11 4224725                    /lib/x86_64-linux-gnu/libnss_nis-2.19.so
7f75c3b3e000-7f75c3d3d000 ---p 0000b000 08:11 4224725                    /lib/x86_64-linux-gnu/libnss_nis-2.19.so
7f75c3d3d000-7f75c3d3e000 r--p 0000a000 08:11 4224725                    /lib/x86_64-linux-gnu/libnss_nis-2.19.so
7f75c3d3e000-7f75c3d3f000 rw-p 0000b000 08:11 4224725                    /lib/x86_64-linux-gnu/libnss_nis-2.19.so
7f75c3d3f000-7f75c3d56000 r-xp 00000000 08:11 4224741                    /lib/x86_64-linux-gnu/libnsl-2.19.so
7f75c3d56000-7f75c3f55000 ---p 00017000 08:11 4224741                    /lib/x86_64-linux-gnu/libnsl-2.19.so
7f75c3f55000-7f75c3f56000 r--p 00016000 08:11 4224741                    /lib/x86_64-linux-gnu/libnsl-2.19.so
7f75c3f56000-7f75c3f57000 rw-p 00017000 08:11 4224741                    /lib/x86_64-linux-gnu/libnsl-2.19.so
7f75c3f57000-7f75c3f59000 rw-p 00000000 00:00 0
7f75c3f59000-7f75c3f62000 r-xp 00000000 08:11 4224740                    /lib/x86_64-linux-gnu/libnss_compat-2.19.so
7f75c3f62000-7f75c4161000 ---p 00009000 08:11 4224740                    /lib/x86_64-linux-gnu/libnss_compat-2.19.so
7f75c4161000-7f75c4162000 r--p 00008000 08:11 4224740                    /lib/x86_64-linux-gnu/libnss_compat-2.19.so
7f75c4162000-7f75c4163000 rw-p 00009000 08:11 4224740                    /lib/x86_64-linux-gnu/libnss_compat-2.19.so
7f75c4163000-7f75c4845000 r--p 00000000 08:11 1842190                    /usr/lib/locale/locale-archive
7f75c4845000-7f75c4a03000 r-xp 00000000 08:11 4224736                    /lib/x86_64-linux-gnu/libc-2.19.so
7f75c4a03000-7f75c4c03000 ---p 001be000 08:11 4224736                    /lib/x86_64-linux-gnu/libc-2.19.so
7f75c4c03000-7f75c4c07000 r--p 001be000 08:11 4224736                    /lib/x86_64-linux-gnu/libc-2.19.so
7f75c4c07000-7f75c4c09000 rw-p 001c2000 08:11 4224736                    /lib/x86_64-linux-gnu/libc-2.19.so
7f75c4c09000-7f75c4c0e000 rw-p 00000000 00:00 0
7f75c4c0e000-7f75c4c11000 r-xp 00000000 08:11 4224727                    /lib/x86_64-linux-gnu/libdl-2.19.so
7f75c4c11000-7f75c4e10000 ---p 00003000 08:11 4224727                    /lib/x86_64-linux-gnu/libdl-2.19.so
7f75c4e10000-7f75c4e11000 r--p 00002000 08:11 4224727                    /lib/x86_64-linux-gnu/libdl-2.19.so
7f75c4e11000-7f75c4e12000 rw-p 00003000 08:11 4224727                    /lib/x86_64-linux-gnu/libdl-2.19.so
7f75c4e12000-7f75c4e37000 r-xp 00000000 08:11 4198947                    /lib/x86_64-linux-gnu/libtinfo.so.5.9
7f75c4e37000-7f75c5036000 ---p 00025000 08:11 4198947                    /lib/x86_64-linux-gnu/libtinfo.so.5.9
7f75c5036000-7f75c503a000 r--p 00024000 08:11 4198947                    /lib/x86_64-linux-gnu/libtinfo.so.5.9
7f75c503a000-7f75c503b000 rw-p 00028000 08:11 4198947                    /lib/x86_64-linux-gnu/libtinfo.so.5.9
7f75c503b000-7f75c505e000 r-xp 00000000 08:11 4224733                    /lib/x86_64-linux-gnu/ld-2.19.so
7f75c5239000-7f75c523d000 rw-p 00000000 00:00 0
7f75c5256000-7f75c525d000 r--s 00000000 08:11 2104076                    /usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache
7f75c525d000-7f75c525e000 r--p 00022000 08:11 4224733                    /lib/x86_64-linux-gnu/ld-2.19.so
7f75c525e000-7f75c525f000 rw-p 00023000 08:11 4224733                    /lib/x86_64-linux-gnu/ld-2.19.so
7f75c525f000-7f75c5260000 rw-p 00000000 00:00 0
7ffc14e76000-7ffc14e97000 rw-p 00000000 00:00 0                          [stack]
7ffc14fe8000-7ffc14feb000 r--p 00000000 00:00 0                          [vvar]
7ffc14feb000-7ffc14fed000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
```

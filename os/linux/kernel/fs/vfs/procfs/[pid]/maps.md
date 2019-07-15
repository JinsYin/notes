# /proc/[pid]/maps

```bash
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
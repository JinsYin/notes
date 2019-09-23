# /proc/[pid]/map_files/

## 示例

```sh
$ ls -l /proc/self/map_files/
lr--------. 1 root root 64 8月  25 03:10 400000-41a000 -> /usr/bin/ls
lr--------. 1 root root 64 8月  25 03:10 61a000-61b000 -> /usr/bin/ls
lr--------. 1 root root 64 8月  25 03:10 61b000-61c000 -> /usr/bin/ls
lr--------. 1 root root 64 8月  25 03:10 7f2541901000-7f254190d000 -> /usr/lib64/libnss_files-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f254190d000-7f2541b0c000 -> /usr/lib64/libnss_files-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2541b0c000-7f2541b0d000 -> /usr/lib64/libnss_files-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2541b0d000-7f2541b0e000 -> /usr/lib64/libnss_files-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2541b14000-7f254803e000 -> /usr/lib/locale/locale-archive
lr--------. 1 root root 64 8月  25 03:10 7f254803e000-7f2548055000 -> /usr/lib64/libpthread-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548055000-7f2548254000 -> /usr/lib64/libpthread-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548254000-7f2548255000 -> /usr/lib64/libpthread-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548255000-7f2548256000 -> /usr/lib64/libpthread-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f254825a000-7f254825e000 -> /usr/lib64/libattr.so.1.1.0
lr--------. 1 root root 64 8月  25 03:10 7f254825e000-7f254845d000 -> /usr/lib64/libattr.so.1.1.0
lr--------. 1 root root 64 8月  25 03:10 7f254845d000-7f254845e000 -> /usr/lib64/libattr.so.1.1.0
lr--------. 1 root root 64 8月  25 03:10 7f254845e000-7f254845f000 -> /usr/lib64/libattr.so.1.1.0
lr--------. 1 root root 64 8月  25 03:10 7f254845f000-7f2548461000 -> /usr/lib64/libdl-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548461000-7f2548661000 -> /usr/lib64/libdl-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548661000-7f2548662000 -> /usr/lib64/libdl-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548662000-7f2548663000 -> /usr/lib64/libdl-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548663000-7f25486c3000 -> /usr/lib64/libpcre.so.1.2.0
lr--------. 1 root root 64 8月  25 03:10 7f25486c3000-7f25488c3000 -> /usr/lib64/libpcre.so.1.2.0
lr--------. 1 root root 64 8月  25 03:10 7f25488c3000-7f25488c4000 -> /usr/lib64/libpcre.so.1.2.0
lr--------. 1 root root 64 8月  25 03:10 7f25488c4000-7f25488c5000 -> /usr/lib64/libpcre.so.1.2.0
lr--------. 1 root root 64 8月  25 03:10 7f25488c5000-7f2548a87000 -> /usr/lib64/libc-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548a87000-7f2548c87000 -> /usr/lib64/libc-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548c87000-7f2548c8b000 -> /usr/lib64/libc-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548c8b000-7f2548c8d000 -> /usr/lib64/libc-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f2548c92000-7f2548c99000 -> /usr/lib64/libacl.so.1.1.0
lr--------. 1 root root 64 8月  25 03:10 7f2548c99000-7f2548e99000 -> /usr/lib64/libacl.so.1.1.0
lr--------. 1 root root 64 8月  25 03:10 7f2548e99000-7f2548e9a000 -> /usr/lib64/libacl.so.1.1.0
lr--------. 1 root root 64 8月  25 03:10 7f2548e9a000-7f2548e9b000 -> /usr/lib64/libacl.so.1.1.0
lr--------. 1 root root 64 8月  25 03:10 7f2548e9b000-7f2548e9f000 -> /usr/lib64/libcap.so.2.22
lr--------. 1 root root 64 8月  25 03:10 7f2548e9f000-7f254909e000 -> /usr/lib64/libcap.so.2.22
lr--------. 1 root root 64 8月  25 03:10 7f254909e000-7f254909f000 -> /usr/lib64/libcap.so.2.22
lr--------. 1 root root 64 8月  25 03:10 7f254909f000-7f25490a0000 -> /usr/lib64/libcap.so.2.22
lr--------. 1 root root 64 8月  25 03:10 7f25490a0000-7f25490c4000 -> /usr/lib64/libselinux.so.1
lr--------. 1 root root 64 8月  25 03:10 7f25490c4000-7f25492c3000 -> /usr/lib64/libselinux.so.1
lr--------. 1 root root 64 8月  25 03:10 7f25492c3000-7f25492c4000 -> /usr/lib64/libselinux.so.1
lr--------. 1 root root 64 8月  25 03:10 7f25492c4000-7f25492c5000 -> /usr/lib64/libselinux.so.1
lr--------. 1 root root 64 8月  25 03:10 7f25492c7000-7f25492e9000 -> /usr/lib64/ld-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f25494a6000-7f25494ad000 -> /usr/lib64/gconv/gconv-modules.cache
lr--------. 1 root root 64 8月  25 03:10 7f25494ad000-7f25494dc000 -> /usr/share/locale/zh_CN/LC_TIME/coreutils.mo
lr--------. 1 root root 64 8月  25 03:10 7f25494e8000-7f25494e9000 -> /usr/lib64/ld-2.17.so
lr--------. 1 root root 64 8月  25 03:10 7f25494e9000-7f25494ea000 -> /usr/lib64/ld-2.17.so
```

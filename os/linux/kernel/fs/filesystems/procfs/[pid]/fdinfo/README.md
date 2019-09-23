# /proc/[pid]/fdinfo/

包含进程打开的所有文件描述符的信息，每一个已打开的文件描述符对应一个文件，并以文件描述符的数值来命名。例如，`/proc/self/fdinfo/1` 表示当前进程打开的文件描述符 `1` 的相关信息。

* 该目录下的所有文件均只读

## 文件内容

| 字段          | 描述                                                                                                       | 示例                                                                                                                    |
| ------------- | ---------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| pos           | 当前的文件偏移量                                                                                           | `pos: 0`                                                                                                                |
| flags         | 文件的访问模式（只读、只写、读写）和打开文件的状态标志（`open()` 系统调用的 flags 参数）；由八进制数来表示 | `flags: 0100002`                                                                                                        |
| mnt_id        |                                                                                                            | `mnt_id: 23`                                                                                                            |
| clockid       |                                                                                                            | `clockid: 1`                                                                                                            |
| ticks         |                                                                                                            | `ticks: 0`                                                                                                              |
| settime flags |                                                                                                            | `settime flags: 01`                                                                                                     |
| it_value      |                                                                                                            | `it_value: (107, 206068399)`                                                                                            |
| it_interval   |                                                                                                            | `it_interval: (0, 0)`                                                                                                   |
| tfd           |                                                                                                            | `tfd: 5`                                                                                                                |
| events        |                                                                                                            | `events: 19`                                                                                                            |
| data          |                                                                                                            | `data: 5588c80d6280`                                                                                                    |
| sigmask       |                                                                                                            | `sigmask: 7be3c0fe28014a03`                                                                                             |
| inotify       |                                                                                                            | `inotify wd:1 ino:1fcd sdev:14 mask:80 ignored_mask:0 fhandle-bytes:c fhandle-type:1 f_handle:b9bb1e5dcd1f000000000000` |

## 示例

```sh
$ ls -l /proc/self/fdinfo/1
-r--------. 1 root root 0 7月  23 10:25 /proc/self/fdinfo/1
```

```sh
$ cat /proc/self/fdinfo/1
pos:	0
flags:	0100002
mnt_id:	23
```

```sh
$ find /proc/1/fdinfo -type f | xargs cat
```

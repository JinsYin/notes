# 文件类型（File type）

* 常规文件（Regular File）
* 特殊文件/专有文件（Special File）
  * 目录（Directory）
  * 符号链接（Symbolic Link）
  * 设备文件（Device File）
    * 块设备（Block Device）
    * 字符设备（Charater Device）
      * 伪设备（Pseudo Device）
  * 套接字（Socket）
  * 命名管道（Named Pipe）

块设备与字符设备的区别在于操作系统与硬件之间读写多少数据。设备文件通常作为虚拟文件系统（VFS）的一部分被挂载在 `/dev`。

| 文件类型                     | 字符标记 | 描述                                                                                                         | 示例                                                            |
| ---------------------------- | -------- | ------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------- |
| 常规文件（Regular File）     | `f`/`-`  | 文本文件、二进制文件...                                                                                      | `find /tmp -type f`、`ls -l /etc/hosts`                         |
| 目录（Directory）            | `d`      |                                                                                                              | `ls -ld 、`                                                     |
| 符号链接（Symbolic Link）    | `l`      | 对另一个文件的引用；硬链接是其他类型的文件                                                                   | `ls -l /sbin/halt`                                              |
| 块设备（Block Device）       | `b`      | 提供了对硬件设备的缓存访问；可随机访问的设备文件                                                             | `ls -l /dev/sda`                                                |
| 字符设备（Character Device） | `c`      | 提供了对硬件设备的无缓冲、直接访问；仅提供串行输入流或接受串行输出流，比如终端、伪设备                       | `ls -l /dev/tty`、`ls -l /dev/null`                             |
| Socket                       | `s`      | 用于 IPC 的特殊文件                                                                                          | `ls -l /run/docker.sock`                                        |
| 命名管道（Named Pipe）       | `p`      | 管道将一个进程的输出连接到另一个进程的输入（IPC 方式之一），命名管道是可以存在于文件系统中任何位置的特殊文件 | `sudo sh -c 'find /run -type p | xargs ls -l'`、`mkfifo mypipe` |

`ls -l` 命令的第一个字符描述的是文件类型，其中，`-` 表示常规文件。

> 在同一位置，不能创建两个同名的常规文件和目录，因为两者都属于文件

## 相关命令

* [ls](../../../cmds/file/ls.md)
* [find](../../../cmds/file/find.md)
* [file](../../../cmds/file/file.md)
* [stat](../../../cmds/file/stat.md)

## 参考

* [Unix file types](https://en.wikipedia.org/wiki/Unix_file_types)
* [Hard Link and Symbolic Link](https://medium.com/@meghamohan/hard-link-and-symbolic-link-3cad74e5b5dc)
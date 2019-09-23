# man - 查看 Linux 参考手册的接口/命令

注：手册页默认在 `less` 程序中打开（`q`：退出，空格：下一页，`b`：上一页）。

## 安装

```sh
# CentOS
$ sudo yum install -y man-pages
```

## Section

手册页分为以下几个部分（sections）：

| Section | 描述 |
| ------- | ---- |
| `1`     |      |
| `2`     |      |
| `3`     |      |
| `4`     |      |
| `5`     |      |
| `6`     |      |
| `7`     |      |
| `8`     |      |

* 【第 `1` 部分】用户命令（user commands）
* 【第 `2` 部分】系统调用（system calls）
* 【第 `3` 部分】库函数（library functions）
* 【第 `4` 部分】特殊文件（special files），如 `/dev` 目录中的设备
* 【第 `5` 部分】文件格式（file formats）
* 【第 `6` 部分】游戏（games）
* 【第 `7` 部分】概述和杂项（overview and miscellany）
* 【第 `8` 部分】管理和特权命令（administration and privileged commands）

当上述部分的名字相同时，需要指定从哪个部分获取正确的手册页（指定数字即可）。

```sh
# man 手册
$ man man

# 命令手册
$ man pwd
$ man which

# C 标准库的库函数手册
$ man isspace # <ctype.h>
$ man printf  # <stdio.h>

# 名字相同时
$ man 2 write # 系统调用手册
$ man 3 write # 库函数手册
```

## 示例

```sh
# WRITE(2) 中的 2 指的是这是第 2 部分
$ man 2 write

WRITE(2)                                                                                Linux Programmer's Manual                                                                                WRITE(2)

NAME
       write - write to a file descriptor

SYNOPSIS
       #include <unistd.h>

       ssize_t write(int fd, const void *buf, size_t count);

```

## Apropos

如果不知道函数或命令的名称，可以使用 `apropos` 程序搜索所列关键字的手册页描述，并查找认为匹配的命令或函数。

```sh
$ apropos "working directory"
chdir (2)            - change working directory
fchdir (2)           - change working directory
get_current_dir_name (3) - get current working directory
getcwd (2)           - get current working directory
getcwd (3)           - get current working directory
getwd (3)            - get current working directory
git-stash (1)        - Stash the changes in a dirty working directory away
pwd (1)              - print name of current/working directory
pwdx (1)             - report current working directory of a process
```

## 参考

* [The Linux man-pages project](https://www.kernel.org/doc/man-pages/)
* [Linux man pages online](http://man7.org/linux/man-pages/)

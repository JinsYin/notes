# open()

打开或创建一个文件。

## 手册

```sh
$ man 2 open
```

## 语法

```c
#include <sys/types.h> /* mode_t*/
#include <sys/stat.h>
#include <fcntl.h>     /* O_RDONLY ... */

/*
 * 打开一个文件，并返回文件描述符
 *
 * @pathname：文件路径；若是符号链接，会对其解引用
 * @flags：文件的访问模式
 * @mode：创建文件时只读文件的访问权限，若 flags 未指定 O_CREAT，则省略 mode 参数
 *
 * @Return: 成功则返回文件描述符，错误则返回 -1
 */
int open(const char *pathname, int flags);
int open(const char *pathname, int flags, mode_t mode);
```

| 访问模式（mode） | 描述                                    |
| ---------------- | --------------------------------------- |
| O_RDONLY         | 以 “只读”（read only）方式打开文件      |
| O_WRONLY         | 以 “只写”（write only）方式打开文件     |
| O_RDWR           | 以 “读写”（read and write）方式打开文件 |

> 上述常量通常定义为 0、1、2，所以 O_RDWR 并不等同于 “O_RDONLY | O_WRONLY”

## 示例

* 打开文件

```c
```

* 创建文件

* copy

```c

```

## 其他

```sh
# 需要安装 kernel-headers
$ cat /usr/include/asm-generic/fcntl.h
```

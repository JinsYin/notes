# umask

`umask`（user mask）用于设置新文件的默认模式（即权限）。

## 原理

```plain
文件默认模式 = | 文件初始模式 - umask 值的向下取偶值 |
目录默认模式 = | 目录初始模式 - umask 值 |
```

| umask 值 | 文件权限     | 目录权限     |
| -------- | ------------ | ------------ |
| 0        | `rw-`（`6`） | `rwx`（`7`） |
| 1        | `rw-`（`6`） | `rw-`（`6`） |
| 2        | `r--`（`4`） | `r-x`（`5`） |
| 3        | `r--`（`4`） | `r--`（`4`） |
| 4        | `-w-`（`2`） | `-wx`（`3`） |
| 5        | `-w-`（`2`） | `-w-`（`2`） |
| 6        | `--x`（`1`） | `--x`（`1`） |
| 7        | `---`（`0`） | `---`（`0`） |

## 文件默认模式

通常，Unix/Linux 的文件（除目录以外的文件）初始模式是 `666`（`rw-rw-rw`），而目录的初始模式是 `777`（`rwxrwxrwx`）。

| 系统           | umask 默认值    | 文件默认模式             | 目录默认模式             |
| -------------- | --------------- | ------------------------ | ------------------------ |
| macOS          | `0022`（`022`） | `-rw-r--r--`（即 `644`） | `drwxr-xr-x`（即 `755`） |
| CentOS         | `0022`（`022`） | `-rw-r--r--`（即 `644`） | `drwxr-xr-x`（即 `755`） |
| Ubuntu Server  | `0022`（`022`） | `-rw-r--r--`（即 `644`） | `drwxr-xr-x`（即 `755`） |
| Ubuntu Desktop | `0002`（`002`） | `-rw-rw-r--`（即 `664`） | `drwxrwxr-x`（即 `775`） |

改变文件默认模式（即修改 umask 默认值）：

```sh
$ vi ~/.bashrc
umask 002 # 或 umask u=rwx,g=rwx,o= （这种方式不用加加减减）
```

## Also

* chmod

## 示例

* Ubuntu Desktop

```sh
$ umask
0002

$ touch f1
$ mkdir d1

$ ls -ld f1 d1
drwxrwxr-x 2 yin yin 4096  7月 16 11:32 d1 # 775（进一步说明 ubuntu 的 umask 值是 002）
-rw-rw-r-- 1 yin yin    0  7月 16 11:32 f1 # 664


# 临时改变 umask
$ umask 004

$ touch f2
$ mkdir d2

$ ls -ld f2 d2
drwxrwx-wx 2 yin yin 4096  7月 16 11:35 d2 # 773
-rw-rw--w- 1 yin yin    0  7月 16 11:35 f2 # 662
```

* macOS

```sh
$ umask
0022

$ touch f1

$ ls -l f1
-rw-r--r--  1 in  staff  0  7 16 11:20 f1 # 644

# 临时改变 umask
$ umask 002

$ touch f2

$ ls -l f2
-rw-rw-r--  1 in  staff  0  7 16 11:22 f2 # 664
```

## 参考

* [What is Umask and How To Setup Default umask Under Linux?](https://www.cyberciti.biz/tips/understanding-linux-unix-umask-value-usage.html)
* [Default File Permissions (umask)](https://docs.oracle.com/cd/E19683-01/817-3814/userconcept-95347/index.html)

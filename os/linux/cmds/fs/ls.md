# ls

## 语法

```sh
ls [-ABCFGHLOPRSTUW@abcdefghiklmnopqrstuwx1] [file ...]
```

## 选项

| 选项             | 描述                                                                       |
| ---------------- | -------------------------------------------------------------------------- |
| `-a`             | 显示匿名文件，包括 `.` 和 `..` 两个硬链接                                  |
| `-d`             | 列出目录本身，而非目录条目                                                 |
| `-i` / `--inode` | 显示每个文件的索引号（inode 编号）                                         |
| `-s` / `--size`  | 显示每个文件所分配的文件块数量                                             |
| `-t`             | 按文件修改时间排序（最近修改的排在前面），如果修改时间相同在按字典顺序排序 |

## 示例

### ls -l

```sh
$ ls -l
-rw-r--r--   1 in  staff    27  7 10 20:46 package-lock.json # 对应的绝对模式是 644
drwxr-xr-x   3 in  staff    96  7  8 21:09 resources         # 对应的绝对模式是 755
```

第 1 列（文件类型及文件权限）：

> 第 1 位：文件类型；`-` 表示普通文件，`d` 表示目录，`l` 表示链接文件 ...
> 第 2-4 位：文件所有者权限；`rw-`：可读可写、不可执行或不可搜索
> 第 5-7 位：成员组权限；`r--`：可读、不可写、不可执行或不可搜索
> 第 8-10 位：其他人权限

第 2 列：硬链接数

### ls -li

```sh
$ ls -li /etc/resolv.conf
3670217 lrwxrwxrwx 1 root root 29  4月 14  2017 /etc/resolv.conf
```

### ls -ls

```sh
$ ls -ls /etc/hosts
4 -rw-r--r--. 1 root root 662 4月  12 05:49 /etc/hosts
```

### ls -ld

```sh
$ ls -ld /etc
drwxr-xr-x. 81 root root 8192 8月   1 00:34 /etc
```

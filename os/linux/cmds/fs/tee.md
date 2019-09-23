# tee

读取标准输入（stdin）的内容，并写入到文件 **和** 标准输出（stdout）中。

## 语法

```sh
# 命令后面包含两部分：可选参数（[OPTION]...）和文件列表（[FILE]...）
$ tee [OPTION]... [FILE]...
```

## 参数

| 参数           | 描述                                 |
| -------------- | ------------------------------------ |
| `-a, --append` | 追加内容到文件；没有参数时默认是覆写 |

## 示例

* stdin -> overwrite + stdout

```sh
$ tee README.md
Hello # stdin
Hello # stdout
^C    # Ctrl+C

# 查看文件内容（若已有内容会被覆写）
$ cat README.md
123
```

* 管道 stdin -> 覆写多个文件 + stdout

```sh
# 管道 “|” 将前一个命令的 stdout 作为后一个命令的 stdin
$ echo "Hello,world" | tee READMD.md README.rst
Hello,world # stdout

# overwrite
$ cat README.md
Hello,world

$ cat README.md
Hello,world
```

可以解决重定向没有权限的问题：

```sh
# 普通用户没有写入权限
$ echo 123 > /etc/README.md
bash: /etc/README.md: Permission denied

# 加个 sudo ?
$ sudo echo 123 > /etc/README.md
bash: /etc/README.md: Permission denied

# 正解 1
$ echo 123 | sudo tee /etc/README.md

# 正解 2
$ sudo sh -c 'echo 123 > /etc/README.md'
```

* 重定向 -> 追加到文件末尾

```sh
$ tee -a /tmp/file <<EOF
1234567890
abcdefghij
EOF
```

# tee

从标准输入读取内容，写入到 **文件** 和 **标准输出**。

## 命令详解

| 参数           | 描述                                 |
| -------------- | ------------------------------------ |
| `-a, --append` | 追加内容到文件；没有参数时默认是覆写 |

## 示例

* stdin -> overwrite + stdout

```bash
$ tee README.md
Hello # stdin
Hello # stdout
^C    # Ctrl+C

# 覆写
$ cat README.md
123
```

* 管道 stdin -> 覆写多个文件 + stdout

```bash
# 管道 “|” 将前一个命令的 stdout 作为后一个命令的 stdin
$ echo "Hello,world" | tee READMD.md README.rst
Hello,world # stdout

# overwrite
$ cat README.md
Hello,world

$ cat README.md
Hello,world
```

* 重定向 -> 追加到文件末尾
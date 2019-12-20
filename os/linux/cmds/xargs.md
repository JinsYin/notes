# xargs

从 stdin 中读取空格（space）、制表符（tab）、新行（newline）以及文件结束符（EOF），并执行参数列表中的命令。

## 语法

```c
xargs [-0opt] [-E eofstr] [-I replstr [-R replacements]] [-J replstr] [-L number] [-n number [-x]] [-P maxprocs] [-s size]
           [utility [argument ...]]
```

## 示例

```sh
# 统计每个 md 文件的字数（其中，/def/fd/0 指代当前进程的标准输入 ）
$ find . -name '*.md' | xargs wc -w /dev/fd/0
```

```sh
$ cat /etc/hosts | xargs -I{} ssh root@{} hostname
```

```sh
$ find . -type d | xargs chmod 755 # 修改目录的权限
$ find . -type f | xargs chmod 644 # 修改普通文件的权限
```

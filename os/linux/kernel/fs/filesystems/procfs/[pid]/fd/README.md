# /proc/[pid]/fd/

`/proc/[pid]/fd/` 目录为进程打开的每个文件描述符都包含一个符号链接，每个符号链接的名称与文件描述符的数值相匹配。

## 示例

```sh
# Linux & macOS
$ ls | wc -l /dev/fd/0 # 在 Linux 上等同于：ls | wc -l /proc/self/fd/0
```

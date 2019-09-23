# /proc/[pid]/cwd

该文件是一个符号链接，链向的是进程的当前工作目录。当前工作目录对解释相对路径名提供了参照点。

## 示例

```sh
$ ls -l /proc/self/cwd
lrwxrwxrwx. 1 root root 0 7月  22 14:42 /proc/self/cwd -> /root
```

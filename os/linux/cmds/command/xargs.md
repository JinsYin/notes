# xargs

对 stdin 执行相应命令行

## 示例

```sh
$ find . -name '*.py' | xargs grep some_function
```

```sh
$ cat hosts | xargs -I{} ssh root@{} hostname
```

```sh
$ find . -type d | xargs chmod 755
$ find . -type f | xargs chmod 644
```
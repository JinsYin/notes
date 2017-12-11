# Linux I/O 重定向

## I/O 数字标识

Handle | Name   | Description |
------ | ------ | ----------- |
0      | stdin  | 标准输入     |
1      | stdout | 标准输出     |
2      | stderr | 标准错误输出  |

重定向：将 stderr 输出到 stdout，或者将 stdout 输出到 stderr，亦或者将 stderr/stdout 输出到文件。


## stdout 重定向

使用 `>` 符号将命令或程序的标准输出（正常输出）结果输出到文件（如果文件有数据会被清空），使用 `>>` 符号将命令或程序的标准输出结果追加到文件。

* **>**

```bash
$ ls > out.log
$ # 等同于
$ ls 1> out.log
```

```bash
$ # 由于 stdout 的结果为空，所以 out.log 的内容也是为空的（没有产生正常的输出）
$ ls non_exist > out.log
```

* **>>**

```bash
$ ls >> out.log
$ # 等同于
$ ls 1>> out.log
```


## stderr 重定向

将命令或程序的标准错误输出结果输出到文件。

```bash
$ ls non_exist 2> err.log

$ non_exist_command 2> err.log
```


## stdout vs stderr

* 将 stdout 和 stderr 全部输出一个文件

`2>&1` 表示把 stderr 导入到 stdout；然后再通过 `>` 将 stdout 输出到文件。

```bash
$ non_exist_command > out_and_err.log 2>&1
$ # OR
$ non_exist_command &> out_and_err.log
$ # OR
$ non_exist_command >& out_and_err.log
```

变换一下，通过 `1>&2` 先把 stdout 导入到 stderr，再输出到文件，结果是一样的。

```bash
$ non_exist_command > out_and_err.log 1>&2
```

* stdout 与 stderr 各自输出到不同的文件

将 stdout 输出到 out.log 文件，而将 stderr 输出到 err.log 文件。

```bash
$ ls non_exist > out.log 2> err.log
```


## stdin

* 从键盘获取输入

直接执行 `cat` 时，会等待用户从键盘输入信息，并将收到的信息输出到屏幕上。

```bash
$ cat
```

也可以结合 `<<EOF` 和 `EOF` 将多个输入一并输入到 stdin。

```bash
$ cat <<EOF
1234567890
abcdefghij
EOF
```

通常的做法是将多行输入一并输出到文件。

```bash
$ cat <<EOF > /tmp/output.txt
1234567890
abcdefghij
EOF
```

* 从文件获取输入

可以使用 `<` 符号将文件作为命令的标准输入。

```bash
$ cat < in.log
$ # 等同于
$ cat 0< in.log
$ # 等同于
$ cat in.log
```

我们常用到的 grep、head 等操作文件的命令也是这个原来。

```bash
$ grep 123 in.log
$ # 等同于
$ grep 123 < in.log
```

从某个文件获取输入，再输出到另一个文件中。

```bash
$ cat < in.log > out.log
```

## 管道（pipe）

![Linux Pipe](./img/linux-pipe.png)

管道的用途是将命令或程序的输入和输出串联起来。

```bash
$ ls | grep keyword | nl | head -n 5
```


## 参考

* [BASH Shell: How To Redirect stderr To stdout ( redirect stderr to a File )](https://www.cyberciti.biz/faq/redirecting-stderr-to-stdout/)
* [Linux I/O重定向的一些小技巧](https://www.ibm.com/developerworks/cn/linux/l-iotips/index.html)
* [Linux I/O 輸入與輸出重新導向，基礎概念教學](https://blog.gtwang.org/linux/linux-io-input-output-redirection-operators/)
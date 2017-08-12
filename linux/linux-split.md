# Linux 拆分文件

`split` 命令可以按 `行数`、`指定大小` 将大文件拆分成多个小文件，而且拆分速度非常快。

* 参数

> * -a: 设置拆分文件的后缀长度
> * -b: 设置每个输出文件的字节数
> * -l: 设置每个输出文件的行数
> * -d: 用数字作为拆分的后缀


## 按行数进行拆分

* 方法一

```bash
$ split -l 100 src.csv -d -a 1 dist
$
$ wc -l dist0
```

* 方法二

```bash
$ head src.csv -n 10000 > dist.csv
$
$ tail src.csv -n 10000 > dist.csv
```


## 按字节进行拆分

`-b` 不加单位默认表示字节，也可以带单位比如 KB,MB 等

```bash
$ split -b 100 src.csv -d -a 1 dist
$
$ split -b 100MB src.csv -d -a 1 dist
```
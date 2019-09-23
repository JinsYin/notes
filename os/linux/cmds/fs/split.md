# split

`split` 命令可以按 `行数`、`指定大小` 将大文件拆分成多个小文件，而且拆分速度非常快。

## 参数

* `-a`: 设置拆分文件的后缀长度
* `-b`: 设置每个输出文件的字节数
* `-l`: 设置每个输出文件的行数
* `-d`: 用数字作为拆分的后缀

## 按行数拆分

* 方法一

```sh
$ split -l 100 src.csv -d -a 1 dist

# 校验
$ wc -l dist0
```

* 方法二

```sh
# 行首
$ head src.csv -n 10000 > dist.csv

# 行尾
$ tail src.csv -n 10000 > dist.csv
```

## 按字节拆分

`-b` 不加单位默认表示字节，也可以带单位比如 `KB`、`MB` 等

```sh
# 字节
$ split -b 100 src.csv -d -a 1 dist

# MB
$ split -b 100MB src.csv -d -a 1 dist
```

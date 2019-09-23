# grep

`grep` 查找过滤命令

## 参数

| 参数   | 描述            |
| ------ | --------------- |
| `-i`   | 忽略大小写      |
| `-A n` | 匹配上文 n 行   |
| `-B n` | 匹配下文 n 行   |
| `-C n` | 匹配上下文 n 行 |

## egrep、fgrep、rgrep

`egrep` = `grep -E` （已弃用）
`fgrep` = `grep -F` （已弃用）
`rgrep` = `grep -r`

## 示例

* 不分大小写

```sh
$ env | grep -i "proxy"
```

* 匹配上文

```sh
$ env | grep "HOSTNAME" -A 1
LC_MONETARY=zh_CN.UTF-8
TERM=xterm
```

* 匹配下文

```sh
$ env | grep "HOSTNAME" -B 1
LC_ADDRESS=zh_CN.UTF-8
HOSTNAME=centos-node-1
```

* 匹配上下文

```sh
$ env | grep "HOSTNAME" -C 1
LC_ADDRESS=zh_CN.UTF-8
HOSTNAME=centos-node-1
LC_MONETARY=zh_CN.UTF-8
```

* 排除自身

```sh
$ ps aux | grep "[b]ash"
root      3843  0.0  0.0 115564  2208 pts/0    Ss   8月08   0:00 -bash
root      8211  0.0  0.0 115436  2088 tty1     Ss+   2018   0:00 -bash
```

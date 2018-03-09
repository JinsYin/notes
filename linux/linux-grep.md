# Linux Grep

`grep`、`egrep` 查找命令


## 不分大小写

```bash
$ env | grep -i "proxy"
```


## 匹配上下文

* `-A` 匹配上文

```bash
$ env | grep "HOSTNAME" -A 1
LC_MONETARY=zh_CN.UTF-8
TERM=xterm
```

* `-B` 匹配下文

```bash
$ env | grep "HOSTNAME" -B 1
LC_ADDRESS=zh_CN.UTF-8
HOSTNAME=centos-node-1
```

* `-C` 匹配上下文

```bash
$ env | grep "HOSTNAME" -C 1
LC_ADDRESS=zh_CN.UTF-8
HOSTNAME=centos-node-1
LC_MONETARY=zh_CN.UTF-8
```
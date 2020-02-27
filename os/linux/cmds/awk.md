---
---
# awk

定向模式扫描处理语言

## 用法

```sh
awk [ -F fs ] [ -v var=value ] [ 'prog' | -f progfile ] [ file ...  ]
```

## 选项

| 选项           | 描述     |
| -------------- | -------- |
| `-v var=value` | 设置变量 |

## 示例

* 匹配列

```sh
$ ps aux | awk '$8=="S"'
```

* 设置变量

```sh
psstatus() { ps aux | awk -v pattern=$1 '$8==pattern'; };

psstatus "S"
```

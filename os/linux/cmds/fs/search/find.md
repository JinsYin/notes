# find

`sort -n` 表示按数字进行排列，所以其对 `du -h` 的结果进行排序其实是不准确的，因为 `du -h` 的结果还带有单位（16K、8M、1.8G 等），实际排序时却忽略了单位，因此应该对 `sort -hm` 后的结果进行才正确。

`find` 属于实时查找。

## 参数

| 参数                | 描述                                                                                                                                                |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-type`             | 指定文件类型：<br>* `b`：块文件<br>* `c`：字符文件<br>* `d`：目录<br>* `p`：命名管道（FIFO）<br>* `f`：普通文件<br>* `l`：符合链接<br>* `s`：Socket |
| `-exec`             | 对查找结果的每一项都执行某个命令                                                                                                                    |
| `-empty`            | 如果文件或目录是空的则返回 True                                                                                                                     |
| `-d`、`--max-depth` | 指定目录深度                                                                                                                                        |
| `-m`                | 文件大小以 1M 为单位                                                                                                                                |
| `-h`                | 以可读格式（如 1K、2M、3G）打印文件大小                                                                                                             |

## 示例

* `-exec`

```sh
$ find . -type f -exec grep 'data' {} \;`
$ find . -type d -exec chmod 755 {} \;
```

* 查看大文件

```sh
# 查找所有大于 100MB 的文件
$ find . -type f -size +100M

# 查找大于 100MB 的文件并按数字进行逆排序（并非完全逆排序，而是忽略单位后的逆排序）
$ find . -type f -size +100M -print0 | xargs -0 du -h | sort -nr

# 查找大于 100MB 的前十个文件（完全逆排序，统一单位为 MB）
$ find . -type f -size +100M -print0 | xargs -0 du -hm | sort -nr | head -n 10
```

* 查找大目录

```sh
# 查看 1 - 2 层子目录的大小
$ du -hd 2

# 查看 1 - 3 层子目录的大小并进行逆排序（并非完全逆排序，而是忽略单位后的逆排序）
$ du -hd 3 . | sort -nr

# 查看最大的前十个子目录（完全逆排序，统一单位为 MB）
$ du -hmd 2 . | sort -nr | head -n 10
```

* 排除子目录

```sh
# 排除 .git 目录
$ find . -type d -not -path "./.git/*" -exec chmod 755 {} \;
```

* 查找空文件或空目录

```sh
$ find . -empty -type f # 空文件
$ find . -empty -type d # 空目录
```

* 查找文件时执行命令

```sh
$ find . -type d -exec chmod 755 {} \;
$ find . -type d | xargs chmod 755
```

* 对比

```sh
$ find . -name "*.md" | wc -l       # 对管道前输出的所有结果统计行数
$ find . -name "*.md" | wc -l -
$ find . -name "*.md" | wc -l /dev/fd/0

$ find . -name "*.md" | xargs wc -l # 对管道前输出的每一项都统计行数（按空格、Tab 和行分隔一项）
$ find . -name "*.md" | xargs wc -l -
$ find . -name "*.md" | xargs wc -l /dev/fd/0
```

* 查询 HOME 目录下的所有隐藏文件

```sh
$ find ~ -d 1 -type f -name '\.*'
```

# Linux Find

`sort -n` 表示按数字进行排列，所以其对 `du -h` 的结果进行排序其实是不准确的，因为 `du -h` 的结果还带有单位（16K、8M、1.8G 等），实际排序时却忽略了单位，因此应该对 `sort -hm` 后的结果进行才正确。

## 查看大文件

```bash
$ # 查找大于 100MB 的所有文件
$ find ~ -type f -size +100M
$
$ # 查找大于 100MB 的文件并按数字进行逆排序（并非完全逆排序，而是忽略单位后的逆排序）
$ find ~ -type f -size +100M -print0 | xargs -0 du -h | sort -nr
$
$ # 查找大于 100MB 的前十个文件（完全逆排序，统一单位为 MB）
$ find ~ -type f -size +100M -print0 | xargs -0 du -hm | sort -nr | head -n 10
```

## 查找大目录

```bash
$ # 查看　1 - 2　层子目录的大小
$ du -h --max-depth=2
$
$ # 查看　1 - 3　层子目录的大小并进行逆排序（并非完全逆排序，而是忽略单位后的逆排序）
$ du -h ~ --max-depth=3 | sort -nr
$
$ # 查看最大的前十个子目录（完全逆排序，统一单位为 MB）
$ du -hm ~ --max-depth=2 | sort -nr | head -n 10
```
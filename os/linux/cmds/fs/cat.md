# cat

打印文件的内容到 stdout

## 参数

| 参数 | 描述                 |
| ---- | -------------------- |
| `-n` | 输出行号（包括空行） |
| `-d` | 输出行号（不含空行） |

## SEE ALSO

* tac

## 示例

* 将 stdin 作为文件输入

```sh
$ cat <<EOF > /tmp/file
1234567890
abcdefghij
EOF
```

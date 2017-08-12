# Linux cat

## 添加多行内容到文件

* 方法一

```bash
$ 视情况决定使用 ">>" 还是 ">"
$ cat <<EOF >> /tmp/file
aaa
bbb
EOF
```

* 方法二

```bash
$ # 貌似不支持追加
$ tee /tmp/file <<EOF
123
456
EOF
```
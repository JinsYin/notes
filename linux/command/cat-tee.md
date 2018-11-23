# cat | tee

## 添加多行内容到文件

* 方法一

```bash
# 覆盖
$ cat <<EOF > /tmp/file
1234567890
abcdefghij
EOF

# 追加
$ cat <<EOF >> /tmp/file
1234567890
abcdefghij
EOF
```

* 方法二

```bash
# 覆盖
$ tee /tmp/file <<EOF
1234567890
abcdefghij
EOF

# 追加
tee -a /tmp/file <<EOF
1234567890
abcdefghij
EOF
```
---
---
# alias

Linux 的 `alias` 可以用于临时设置别名，如果需要别名永久生效，可以将别名添加到 `~/.bashrc` 文件中。

## 命令

```sh
# 查看别名
$ alias

# 设置别名
$ alias ll='ls -alF'

# 删除别名
$ unalias <alias-name>
```

## 永久生效

```sh
# 直接添加到 “~/.bashrc” 文件中
$ echo "alias ll='ls -alF'" >> ~/.bashrc
$ source ~/.bashrc

# 最好将别名单独添加到 “~/.bash_aliases” 文件中（“~/.bashrc” 中引用了 “~/.bash_aliases”）
$ echo "alias ll='ls -alF'" >> ~/.bash_aliases
$ source ~/.bashrc
```

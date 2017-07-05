# Git 标签

标签实质上是版本库的一个快照，也就是指向某个 commit 的指针。类似于分支，但不同的是分支可以移动，标签不能移动。

## 创建标签

```bash
# 默认标签是创建在最新提交的 commit 上
$ git tag [tag] # 例如 v1.0
```

```bash
# 在指定的 commit 上创建标签
$ git tag [tag] [commit]
$ git tag -a [tag] -m [message] [commit] # 创建带有说明的标签，用 -a 指定标签名，-m 指定说明文字
$ git tag -s [tag] -m [message] [commit] # 用PGP签名创建标签（须首先安装 gpg，即GnuPG）
```

## 查看标签
```bash
# 查看所有标签
$ git tag # 等价于 git tag -l
$ git tag -ln # 带提交信息
```

```bash
# 查看标签信息
$ git show [tag]
```

## 切换到标签

```bash
$ git checkout [tag]
```

## 推送标签

```bash
# 推送标签到远程
$ git push origin [tag] # 推送某个标签
$ git push origin --tags # 推送所有未推送的标签
```

## 删除标签

```bash
# 删除本地标签
$ git tag -d [tag]
$ rm .git/refs/tags/[tag]
```

```bash
# 删除远程标签
$ git push origin :refs/tags/[tag]
$ git push origin :[tag]
$ git push origin --delete tag [tag]
```

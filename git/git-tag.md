# Git 标签

标签实质上是版本库的一个快照，也就是指向某个 commit 的指针。类似于分支，但不同的是分支可以移动，标签不能移动。

```bash
# 默认标签是创建在最新提交的 commit 上
$ git tag v1.0
```

```bash
# 对历史提交的 commit 创建标签
$ git tag v0.9 6224937
$ git tag -a v0.1 -m "version 0.1 released" 3628164 # 创建带有说明的标签，用 -a 指定标签名，-m 指定说明文字
$ git tag -s <tagname> -m "blablabla" 3628164 # 用PGP签名创建标签（须首先安装 gpg，即GnuPG）
```

```bash
# 查看所有标签
$ git tag # 等价于 git tag -l
$ git tag -ln # 带提交信息
```

```bash
# 查看标签信息
$ git show v0.9
```

```bash
# 推送标签到远程
$ git push origin v0.9 # 推送某个标签
$ git push origin --tags # 推送所有未推送的标签
```

```bash
# 删除标签
$ git tag -d v0.9 # 从本地删除（等同于 rm .git/refs/tags/v0.9）
$ git push origin :refs/tags/v0.9 # 从远程删除（需先从本地删除）
$ git push origin :v0.9
$ git push origin --delete tag v0.9
```

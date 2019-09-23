# 实验

## 创建 Git 仓库

```sh
$ git init git_learning && cd git_learning
```

## 最小配置

```sh
$ git config --global user.name "jinsyin"
$ git config --global user.email "jinsyin@gmail.com"
```

## 小试牛刀

* 创建文件

```sh
$ echo "Git 学习笔记" > README.md
```

* 查看文件状态

```sh
# 此时 README.md 文件还没有被 Git 管理和追踪
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)

    README.md

nothing added to commit but untracked files present (use "git add" to track)
```

* 将文件添加到暂存区

```sh
$ git add README.md
```

* 再次查看文件状态

```sh
# 此时 README.md 文件已被 Git 管理和追踪，下一步可以选择提交（commit）到本地仓库或者从暂存区撤销（unstage）到工作区
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

    new file:   README.md
```

* 提交到本地仓库

```sh
$ git commit -m "Add README"
[master (root-commit) 7810d92] Add README
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
```

* 查看提交日志

```sh
$ git log
commit 7810d9296e19d518bdcdab8af495d03f3673e728 (HEAD -> master)
Author: jinsyin <jinsyin@gmail.com>
Date:   Tue Feb 19 16:00:25 2019 +0800

    Add README
```

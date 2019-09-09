# Git stash

将工作区和暂存区的修改隐藏（stash）/保存到 “脏工作区”（dirtry working directory）（不包括为追踪的文件），以记录工作区和暂存区的当前状态，从而得到一个干净的工作区（还原到 HEAD commit）。

切换分支之前，要么 stash，要么 commit；如果采用 stash，最好记录 stash 时所在的分支（默认会记录 “wip on branchname…”）。

## 用途

* 合并其他分支前，要么先提交本地修改（相对于 HEAD 的修改），要么先暂存（`git stash`）本地修改，否则不能合并

## 用法

```sh
git stash list [<options>] # 列表
git stash show [<stash>]
git stash drop [-q|--quiet] [<stash>]
git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>] # 恢复
git stash branch <branchname> [<stash>]
git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
            [-u|--include-untracked] [-a|--all] [-m|--message <message>]
            [--] [<pathspec>...]] # git stash = git stash push
git stash clear
git stash create [<message>]
git stash store [-m|--message <message>] [-q|--quiet] <commit>
```

`git stash pop [<stash>]` 等价于：

```sh
git stash apply [<stash>]
git stash drop [<stash>]
```

`git stash pop` = `git stash pop 0` = `git stash pop stash@{0}`

## 示例

* 建议

```sh
```

* git stash list

默认情况下，stash 被列为 “wip on branchname…”，但创建 stash 时，可以在命令行上给出更具描述性的消息。

```sh
$ git stash list
stash@{0}: WIP on (no branch): bb2c8a6 设计理论和设计模式 # 栈顶
stash@{1}: WIP on master: 7013644 Kubernetes 入门教程   # 栈底
```

* git stash show

```sh
$ git stash show 0
 README.md                   |   2 +-
 bigdata/spark/README.md     |  14 +++++------
 bigdata/spark/spark-rdd.md  | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------------------
 languages/scala/sbt.md      |  24 +++++++++++++++++-
 storage/databases/README.md |   3 ++-
 5 files changed, 147 insertions(+), 128 deletions(-)
```

```sh
$ git stash show 1
 scala/sbt.md       | 24 +++++++++++++++++++++++-
 spark/README.md    |  5 +++++
 spark/spark-rdd.md |  3 ++-
 3 files changed, 30 insertions(+), 2 deletions(-)
```
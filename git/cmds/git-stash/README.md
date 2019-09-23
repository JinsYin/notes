# GIT-STASH 「储藏」

将工作区和暂存区的修改储藏（stashing）到 “脏工作区”（dirtry working directory）（不包括为追踪的文件），以记录工作区和暂存区的当前状态，从而得到一个干净的工作区（还原到 HEAD commit）。

GitStash 获取工作区的中间状态（即修改过的被追踪文件和暂存区的变更），并将其保存到一个未完结变更的堆栈中（简称 「储藏区」），以后随时可以重新应用。

## 用法

```sh
git stash list [<options>] # ①
git stash show [<stash>] # ②
git stash drop [-q|--quiet] [<stash>] # ③
git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>] # ④
git stash branch <branchname> [<stash>] # ⑤
git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet] # ⑥
            [-u|--include-untracked] [-a|--all] [-m|--message <message>]
            [--] [<pathspec>...]] # git stash = git stash push
git stash clear # ⑦
git stash create [<message>] # ⑧
git stash store [-m|--message <message>] [-q|--quiet] <commit> # ⑨
```

## 式④

* `git stash pop` = `git stash pop 0` = `git stash pop stash@{0}`
* `git stash pop [<stash>]` = `git stash apply [<stash>]` && `git stash drop [<stash>]`

## 式⑥

`git stash` // stash 已追踪的文件
`git stash -u/--include-untracked ` // 同上 + stash 未追踪的文件
`git stash -a/--all` // 同上 + stash 被 `.gitignore` 忽略的文件

## 技巧

* 切换或者合并分支之前，要么 GitStash，要么 GitCommit，否则不能切换或合并分支
* 在某个分支上储藏的变更可以重新应用到另一个分支上
* 使用 GitStash 时，一定要记录 stashing 时所在的分支（默认会记录 “wip on branchname…”），以便将储藏的变更应用到合适的分支上

## 取消储藏（Un-applying a Stash）

在某些情况下，你可能想应用储藏的修改，在进行了一些其他的修改后，又要取消之前所应用储藏的修改。

```sh
# 可以通过取消该储藏的补丁来实现
$ git stash show -p stash@{0} | git apply -R
```

## 用例

`git stash save "...."` // stash 并自行添加注释
`git stash list` // 列出；从上到下：栈顶 -> 栈底
`git stash apply stash@{N}` // 应用储藏的某个 stash，但不移除
`git stash pop stash@{N}` // 应用储藏的某个 stash，并移除之
`git stash drop stash@{N}` //
`git stash show` // 显示 stash 内容与创建 stash 时的大体差异
`git stash show -p` // 显示 stash 内容与创建 stash 时的完整差异
`git stash branch <branch> <stash>` // 基于 stash 创建分支并自动切换到该分支
`git stash clear` // 清除所有 stash

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

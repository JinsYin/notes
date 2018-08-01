# git fetch

<!--
The git fetch command imports commits from a remote repository into your local repo. The resulting commits are stored as remote branches instead of the normal local branches that we’ve been working with.This gives you a chance to review changes before integrating them into your copy of the project.
-->

`git fetch` 命令从远程仓库拉取提交到本地仓库，提交结果被存储在远程分支，而不是本地分支，所以它不会对本地开发工作产生影响。

## 远程分支

远程分支可以看作是只读分支。

## 用法

```bash
# 从远程仓库中拉取所有分支
$ git fetch <remote>

# 拉取指定分支
$ git fetch <remote> <branch>
```

## Examples

```bash
$ git branch -v -a
  2.3.0  05b56ff Spark 2.3.0
* master 05b56ff Spark 2.3.0

# 拉取远程
$ git fetch origin master

$ git branch -v -a
  2.3.0                 05b56ff Spark 2.3.0
* master                05b56ff Spark 2.3.0
  remotes/origin/master bb01475 Initial commit
```

## 参考

* <https://www.atlassian.com/git/tutorials/syncing>
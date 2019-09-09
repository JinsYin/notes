# GIT-PUSH

更新远程引用（即分支）以及关联对象。

## 用法

```sh
git push [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
                  [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
                  [-u | --set-upstream] [-o <string> | --push-option=<string>]
                  [--[no-]signed|--signed=(true|false|if-asked)]
                  [--force-with-lease[=<refname>[:<expect>]]]
                  [--no-verify] [<repository> [<refspec>...]]
```

## 示例

| 示例                          | 描述                                                                                                                                                                              |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| git push origin master        | 将本地仓库中的 master 引用（即本地的 `refs/heads/master`）更新到 origin 仓库中的同名（即 master）引用（即 origin 的 `refs/heads/master`）；等同于 `git push origin master:master` |
| git push origin HEAD          | 将当前分支更新到远程同名的分支                                                                                                                                                    |
| git push origin HEAD:master   | 将当前分支更新到远程 origin 仓库的 master 分支，不考虑本地当前分支的名称                                                                                                          |
| git push origin :experimental | 删除远程 origin 仓库的 experimental 分支（相当于将本地空分支更新到远程 experimental 分支）                                                                                        |
| git push origin dev test      | 将本地的 dev 、test 分支更新到远程 origin 仓库，并保持同名；等同于 `git push origin dev:dev test:test`                                                                            |

* 移除远程分支

```sh
$ git fetch origin # 首先同步所有远程分支
$ git push origin --delete testbranch # 或 git push origin :testbranch
```

* 设置当前分支的上游分支

```sh
# 使用 git remote show origin 查看上游分支
$ git push --set-upstream origin dev # git push origin dev 将自动关联上游分支
```
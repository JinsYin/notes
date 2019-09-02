# git pull

获取且合并另一个仓库或者本地分支

## 帮助

```sh
$ man git-pull
$ git pull --help
```

## 用法

```sh
git pull [<options>] [<repository> [<refspec>...]]
```

## 选项

| 选项                                                      | 描述 |
| --------------------------------------------------------- | ---- |
| `-r`、`--rebase[=false|true|merges|preserve|interactive]` |      |

## 描述

将远程仓库的更改合并到当前分支。在默认模式中，<ins>git pull = git fetch + git merge FETCH_HEAD</ins>。

```graph
     A---B---C master on origin                                   A---B---C origin/master
    /                                       git pull             /         \
D---E---F---G master                      ===========>       D---E---F---G---H master
    ^
    origin/master in local repository
```

## 对比

| -                   | 描述                                                                                    |
| ------------------- | --------------------------------------------------------------------------------------- |
| `git pull`          | <ins>git pull = git fetch + git merge</ins>                                             |
| `git pull --rebase` | `git fetch` + `git rebase`；建议使用后者代替前者，避免误操作，比如少打了一个 `--rebase` |
| `git rebase`        | 顾名思义就是重新定义（re）起点（base）的作用，即重新定义分支的版本库状态                |
| `git merge`         |                                                                                         |
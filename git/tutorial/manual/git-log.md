# git-log 显示提交日志

## 命令详解

```bash
# 帮助文档
$ git help [--web] log
```

| 参数                    | 描述                                                                | 示例                  |
| ----------------------- | ------------------------------------------------------------------- | --------------------- |
| `master` / [空]         | 显示 master 分支的提交历史                                          | git log               |
| [分支名]                | 显示特定分支的提交历史                                              | git log dev           |
| `--oneline`             | 按行显示每一次的提交历史                                            | git log --oneline     |
| `-n [数字]` / `-[数字]` | 显示最近的 N 次提交历史                                             | git log -2            |
| `--all`                 | 显示所有分支的提交历史                                              | git log --all         |
| `--graph`               | 图形化显示提交历史；组合 `--all` 参数可以直观地查看分支间的分叉关系 | git log --all --graph |
| `--stat`                | 格外显示每次提交的文件                                              |                       |
| `-S [关键字]`           | 从提交日志中全文检索关键字                                          | git log -S README     |
| `-p [文件名]`           | 查看指定文件每次提交的 difference                                   | git log -p README.md  |

```bash
$ git config alias.lg
log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
```

## 不同用户的提交

```bash
$ git shortlog
$ git shortlog -sn # 显示所有提交过的用户，按提交次数排序
$ git blame [file] # 显示指定文件是什么人在什么时间修改过
```

## 查看某次提交的变化

```bash
$ git show [commit] # 内容变化
$ git show --name-only [commit] # 查看哪些文件发生了变化
```

## 查看提交和回滚历史

```bash
$ git reflog
```
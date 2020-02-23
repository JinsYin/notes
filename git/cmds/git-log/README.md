# GIT-LOG

显示提交日志

## 命令详解

```sh
# 帮助文档
$ git help [--web] log
```

| 参数                    | 描述                                                                                               | 示例                       |
| ----------------------- | -------------------------------------------------------------------------------------------------- | -------------------------- |
| `master` / [空]         | 显示 master 分支的提交历史                                                                         | git log                    |
| [分支名]                | 显示特定分支的提交历史                                                                             | git log dev                |
| `--oneline`             | 按行显示每一次的提交历史                                                                           | git log --oneline          |
| `-n [数字]` / `-[数字]` | 显示最近的 N 次提交历史                                                                            | git log -2                 |
| `--all`                 | 显示所有分支的提交历史                                                                             | git log --all              |
| `--graph`               | 图形化显示提交历史；组合 `--all` 参数可以直观地查看分支间的分叉关系                                | git log --all --graph      |
| `--stat`                | 格外显示每次提交的文件                                                                             |                            |
| `-S [关键字]`           | 从提交日志中全文检索关键字                                                                         | git log -S README          |
| `-p [文件名]`           | 比较指定文件在所有提交历史中的差异                                                                 | git log -p README.md       |
| `--follow [文件名]`     | 按行列出哪里提交涉及了该文件，包括重命名该文件而涉及的历史记录（默认不包括）；可以和 `-p` 一起使用 | git log --follow README.md |

```sh
$ git config alias.lg
log --color --graph --abbrev-commit --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
```

## 用例

| 命令                                         | 描述                                                           |
| -------------------------------------------- | -------------------------------------------------------------- |
| `git log --oneline`                          | 按行显示当前分支的提交历史（hash + message）                   |
| `git log --oneline origin/master`            | 按行显示远程（origin）master 分支的提交历史（hash + message）  |
| `git log --oneline --all --graph`            | 按行显示所有分支的提交历史，并使用文本图形来显示分叉关系       |
| `git log --oneline [--] <filename>`          | 按行列出哪里提交涉及了该文件（不包括重命名文件）               |
| `git log --oneline --follow [--] <filename>` | 按行列出哪里提交涉及了该文件，包括重命名该文件而涉及的历史记录 |
| `git log --oneline --stat <commit-or-ref>`   | 统计该提交或引用到第一次提交的信息                             |

## 格式选项

`git log --pretty=format` 常用的选项：

| 选项 | 描述                        |
| ---- | --------------------------- |
| %H   | commit 对象的完整哈希字符串 |

## 不同用户的提交

```sh
$ git shortlog
$ git shortlog -sn # 显示所有提交过的用户，按提交次数排序
$ git blame [file] # 显示指定文件是什么人在什么时间修改过
```

## 查看某次提交的变化

```sh
$ git show [commit] # 内容变化
$ git show --name-only [commit] # 查看哪些文件发生了变化
```

## 查看提交和回滚历史

```sh
$ git reflog
```

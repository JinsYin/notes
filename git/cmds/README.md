# Git 命令

## 常用 Git 命令

```sh
$ git --help
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout    Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
```

## 撤销、丢弃

| 命令                             | 描述                                                                                                                                                                                                                                           |
| -------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `git commit --amend`             | 撤销最近一次提交，并自动提交暂存区的内容以及修改新提交的信息                                                                                                                                                                                   |
| `git reset [HEAD] -- <paths>`    | 撤销 <paths> 在暂存区相对于 HEAD 的修改（unstage），并将其修改放回到工作区                                                                                                                                                                     |
| `git checkout [HEAD] -- <paths>` | 丢弃 <paths> 在工作区的修改，使之与暂存区或版本库的状态一致；如果暂存区存在该 <paths> 之前添加的修改则回滚到暂存区中的状态（即回滚到最近一次 `git add <paths>` 时的状态），否则回滚到版本库中的状态（即 回滚到最近一次 `git commit` 时的状态） |
| `git rm --cached <paths>`        |                                                                                                                                                                                                                                                |
| `git restore <paths>`            | 还原 <paths> 在工作区的修改，使之与暂存区状态一致                                                                                                                                                                                              |
| `git restore --staged <paths>`   |                                                                                                                                                                                                                                                |

## 参考

* [Git 基础 - 撤消操作](https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-%E6%92%A4%E6%B6%88%E6%93%8D%E4%BD%9C)

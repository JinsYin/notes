# Git add

| 参数选项   | 描述                                                                                                       |
| ---------- | ---------------------------------------------------------------------------------------------------------- |
| git add .  |                                                                                                            |
| git add -u | 将已追踪（tracked）文件（即已被 Git 管理）的更新（update：`修改` 和 `删除`）添加到暂存区                   |
| git add -A | 将所有文件（已被追踪 tracked 和未被追踪 untracked）的变更（changes：`修改`、`删除` 和 `新建`）添加到暂存区 |

* **tracked** - 已被追踪，即已经通过 `git add` 操作将文件交由 Git 管理
* **untracked** - 未被追踪，即还没有通过 `git add` 将文件交由 Git 管理
* **staged** - 已被暂存，即已经加入到暂存区

## 撤销暂存区

* 如果该文件是一个新建文件（即未 commit），使用 `git rm --cached xxx` 命令可以将文件从暂存区撤销
* 如果该文件是一个修改文件（即已 commit），使用 `git reset HEAD xxx` 命令可以将文件从暂存区撤销

## 文件重命名

* 方式一

```bash
$ mv README README.md
$ git add README README.md # or: git add .
```

* 方式二

```bash
$ mv README README.md
$ git add README.md
$ git rm README
```

* 方式三

```bash
$ git mv README README.md
```
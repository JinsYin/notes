# GIT-COMMIT

## 选项

| 参数      | 说明                                                                        |
| --------- | --------------------------------------------------------------------------- |
| `-a`      | 将已追踪文件的修改和删除添加到提交，但不包括新文件                          |
| `--amend` | 启动 Git 的默认编辑器修正当前分支最近一次提交的 CommitMessage，并提交暂存区 |

## 用例

| 用例                     | 描述                                                                                                                                   |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| `git commit --amend`     | 启动 Git 的默认编辑器修正当前分支最近一次提交的 CommitMessage；无论是否有改动，最终都会生成新的 CommitID；该命令会将暂存区中的文件提交 |
| `git commit -a --aemond` | 提交已追踪文件的更改，并启动 Git 的默认编辑器修正当前分支最近一次提交的 CommitMessage；无论是否有改动，最终都会生成新的 CommitID       |

## 示例

* 修改最新 commit 的 message

```sh
git init e1 && cd e1
echo "README" > README.md
git add . && git commit -m "README"
```

```sh
$ git log --oneline
a9c0935 (HEAD -> master) README
```

```sh
$ git commit --amend
Document # 修改后的 message
```

```sh
# Commit ID 和 message 都不相同
$ git log --oneline
b03da2e (HEAD -> master) Document
```
# commit

## 命令详解

| 参数     | 说明                                                   |
| -------- | ------------------------------------------------------ |
| `-amend` | 通过重新创建提交的方式，修改当前分支最近一次提交的提示 |

## 实验一 · 修改最新 commit 的 message

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

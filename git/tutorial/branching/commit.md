# commit

## 命令详解

| 参数     | 说明                                                       |
| -------- | ---------------------------------------------------------- |
| `-amend` | 通过重新创建提交的方式，修改当前分支最近一次提交的提示信息 |

## 实验一 · 修改最新 commit 的 message

```bash
git init e1 && cd e1
echo "README" > README.md
git add . && git commit -m "README"
```

```bash
$ git log --oneline
a9c0935 (HEAD -> master) README
```

```bash
$ git commit --amend
Document # 修改的 message
```

```bash
# Commit ID 和 message 都不相同
$ git log --oneline
b03da2e (HEAD -> master) Document
```

## 实验二 · 合并连续的多个 commit 成 1 个

# Git 日志

## 提交日志

```bash
$ git log # 查看 commit 历史
$ git log --stat # 查看 commit 历史，以及每次变更的文件
```

## 搜索提交日志

```bash
$ git log -S [keyword]
```

## 查看指定文件每次 commit 的 difference

```bash
$ git log -p [file]
```

## 最近提交历史

```bash
$ git log -5 --pretty --oneline # 最近 5 次
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
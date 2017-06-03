# Git 分支

## 查看分支
```bash
$ git branch
```

## 创建分支
```bash
$ git branch <name>
```

## 切换分支
```bash
$ git checkout <name>
```

## 创建 + 切换分支
```bash
$ git checkout -b <name>
```

## 合并某分支到当前分支
```bash
$ git merge <name> # Fast-Forward 模式，删除分支后不会保留 commit 日志
$ git merge --no-ff <name> # Non-Fast-Forward 模式，删除分支后会保留 commit 日志（推荐）
```

## 删除分支
```bash
$ git branch -d <name> # 被合并后才能被删除
$ git branch -D <name> # 没被合并也能被删除
```

## 分支管理策略
- master分支是主分支，应该是非常稳定的，仅用来发布新版本（平时不能在上面干活），因此要时刻与远程同步；
- dev分支是开发分支，是不稳定的，团队所有成员都需要在上面工作，所以也需要与远程同步；
- bug分支只用于在本地修复bug，就没必要推到远程了，除非老板要看看你每周到底修复了几个bug；
- feature分支是否推到远程，取决于你是否和你的小伙伴合作在上面开发；
- 每个人都在dev分支上干活，每个人都应该有自己的分支，时不时地往dev分支上合并就可以了。

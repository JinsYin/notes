# Git 分支

## 查看分支
```bash
$ git branch # 列出所有本地分支
$ git branch -r # 列出所有远程分支
$ git branch -a # 列出所有本地分支和远程分支
```

## 创建分支
```bash
$ git branch <name>
$ git branch --track [name] [remote-branch] # 新建分支，并与指定远程分支建立追踪关系
```

## 切换分支
```bash
$ git checkout <name>
$ git checkout - # 求换到上一个分支（类似 cd -）
```

## 创建 + 切换分支
```bash
$ git checkout -b <name>
```

## 建立分支追踪关系
```bash
$ git branch --set-upstream-to=origin/<branch> dev # 将本地分支与指定的远程分支建立最总关系
```

## 合并某分支到当前分支
```bash
$ git merge <name> # Fast-Forward 模式，删除分支后不会保留 commit 日志
$ git merge --no-ff <name> # Non-Fast-Forward 模式，删除分支后会保留 commit 日志（推荐）
$ git cherry-pick [commit] # 选择一个 commit，合并进当前分支
```

## 删除分支
```bash
$ git branch -d <name> # 删除本地分支，被合并后才能被删除
$ git branch -D <name> # 删除本地分支，没被合并也能被删除
```

```bash
# 三个命令可以用于删除远程分支
$ git branch -dr [origin/branch]
$ git push origin :[origin/branch]
$ git push origin --delete [origin/branch]
```
## 推送分支到远程
```bash
$ git push origin master
```

## 对比分支差异
```bash
$ git log dev ^master # 查看 dev 分支有的，而 master 分支没有的内容
$ git log master ^dev # 查看 master 分支有的，而 dev 分支没有的内容
```

## 分支管理策略
- master分支是主分支，应该是非常稳定的，仅用来发布新版本（平时不能在上面干活），因此要时刻与远程同步；
- dev分支是开发分支，是不稳定的，团队所有成员都需要在上面工作，所以也需要与远程同步；
- bug分支只用于在本地修复bug，就没必要推到远程了，除非老板要看看你每周到底修复了几个bug；
- feature分支是否推到远程，取决于你是否和你的小伙伴合作在上面开发；
- 每个人都在dev分支上干活，每个人都应该有自己的分支，时不时地往dev分支上合并就可以了。

# Git 远程

远程仓库默认名为`origin`。

## 查看远程仓库
```bash
$ git remote -v # 查看所有远程仓库
$ git remote show [remote] # 查看指定远程仓库
```

## 添加远程仓库
```bash
$ git remote add [remote] [url] # git remote add origin git@github.com:jinsyin/learn-git.git
```

## 同步远程
```bash
$ git fetch [remote] [branch] # 获取远程某分支的最新版本，但不会自动合并与本地当前分支合并
$ git fetch [remote] # 获取远程所有分支的最新版本，但不会自动合并与本地分支合并
```

```bash
# git pull origin master == (git fetch origin master && git merge origin/master)
$ git pull [remote] [branch] # 获取远程某分支的最新版本，并与本地当前分支合并。合并后，工作区同步版本库
```

## 推送分支
```bash
$ git push [remote] [branch] # 上传本地指定分支到远程仓库
$ git push [remote] --force # 强行推送当前分支到远程仓库，远程仓库会被完全覆盖
$ git push [remote] --all # 推送所有分支到远程仓库
```

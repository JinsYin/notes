# GIT-REMOTE

远程仓库默认名为 `origin`。

## 查看远程仓库

```sh
$ git remote -v # 查看所有远程仓库
$ git remote show [remote] # 查看指定远程仓库
```

## 添加远程仓库

```sh
$ git remote add [remote] [url] # git remote add origin git@github.com:jinsyin/learn-git.git
```

## 同步远程

```sh
$ git fetch [remote] [branch] # 获取远程某分支的最新版本，但不会自动合并与本地当前分支合并
$ git fetch [remote] # 获取远程所有分支的最新版本，但不会自动合并与本地分支合并
```

```sh
# git pull origin master == (git fetch origin master && git merge origin/master)
$ git pull [remote] [branch] # 获取远程某分支的最新版本，并与本地当前分支合并。合并后，工作区同步版本库
```

## 推送分支

```sh
$ git push [remote] [branch] # 上传本地指定分支到远程仓库
$ git push [remote] --force # 强行推送当前分支到远程仓库，远程仓库会被完全覆盖
$ git push [remote] --all # 推送所有分支到远程仓库
```

## 示例

```sh
$ git remote show origin
* remote origin
  Fetch URL: git@github.com:JinsYin/cloud-native-handbook.git
  Push  URL: git@github.com:JinsYin/cloud-native-handbook.git
  HEAD branch: master
  Remote branches:
    application tracked
    master      tracked
  Local refs configured for 'git push':
    application pushes to application (up to date)
    master      pushes to master      (local out of date)
```

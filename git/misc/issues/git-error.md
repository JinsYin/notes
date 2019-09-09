# Git 错误整理

## 错误 1

push 到远程仓库是错误
```
$ git push origin master
To git@github.com:JinsYin/learn-git.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'git@github.com:JinsYin/learn-git.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

解决办法:

方法1： 强推，即利用强覆盖方式用本地仓库的代码替代远程仓库内的内容
```sh
$ git push -f origin master
```

方法2：先把远程仓库的内容 `fetch` 到本地，然后 `merge`，之后再 `push` 到远程仓库。
```sh
# 两个命令等价于 git pull
$ git fetch
$ git merge
```

git pull 之后又出错了
```
warning: no common commits
remote: Counting objects: 21, done.
remote: Compressing objects: 100% (8/8), done.
Unpacking objects: 100% (21/21), done.
remote: Total 21 (delta 4), reused 21 (delta 4), pack-reused 0
From github.com:JinsYin/learn-git
 * [new branch]      master     -> origin/master
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details

    git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

    git branch --set-upstream-to=origin/<branch> master
```

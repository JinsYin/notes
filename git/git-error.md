# Git 错误笔记

## push 到远程仓库是错误
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
```bash
$ git push -f origin master
```

方法2：先把远程仓库的内容 `fetch` 到本地，然后 `merge`，之后再 `push` 到远程仓库。
```bash
# 两个命令等价于 git pull
$ git fetch
$ git merge
```

# GIT-REFLOG

执行 `git rebase --abort` 会丢失一些 commit，`git reflog` 可以查看所有 commit 日志。

路径：

* `.git/logs/HEAD`
* `.git/logs/refs/stash`
* `.git/logs/refs/heads/`
* `.git/logs/refs/remotes/`

## 用例

* `git reflog show --all`
* `git reflog show HEAD`
* `git reflog show otherbranch`
* `git reflog stash`

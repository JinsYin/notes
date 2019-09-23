# Github flow

GitHub 贡献代码

## Fork 开源项目

1. 访问 <https://github.com/kubernetes/website>
2. 点击右上角的 `Fork` 按钮

## Clone 到本地

```sh
$ git clone git@github.com:jinsyin/website.git

# 添加上游仓库
$ git remote add upstream git@github.com:kubernetes/website.git

# 设置不允许推送到 upstream （none：自命名）
$ git remote set-url --push upstream none

# 验证
$ git remote -v
upstream    git@github.com:kubernetes/website.git (fetch)
upstream    none (push)
```

## 分支管理

* 保持最新

```sh
# 拉取上游所有分支
$ git fetch upstream

# 让本地 master 分支保持最新
$ git checkout master
$ git rebase upstream/master
```

* 创建分支

```sh
# 功能分支
$ git checkout -b myfeature
```

* 保持分支同步

```sh
# 在 myfeature 分支
$ git fetch upstream
$ git rebase upstream/master
```

注：请不要使用 `git pull` 代替上面的 `fetch`/`rebase` 。`git pull` 会执行 `merge`，并生成毫无意义的 merge commit 。

<!--
Please don't use git pull instead of the above fetch / rebase. git pull does a merge, which leaves merge commits. These make the commit history messy and violate the principle that commits ought to be individually understandable and useful (see below). You can also consider changing your .git/config file via git config branch.autoSetupRebase always to change the behavior of git pull.
-->

* 提交

```sh
# 如果是单行可以用 -m 参数
$ git commit
```

Likely you go back and edit/build/test some more then `commit --amend` in a few cycles.

### Push

```sh
$ git push -f ${your_remote_name} myfeature
```

### 创建 PR

* https://deploy-preview-8234--kubernetes-io-master-staging.netlify.com/

## 参考

* [Understanding the GitHub flow](https://guides.github.com/introduction/flow/)
* [Kubernetes Workflow](https://github.com/kubernetes/community/blob/master/contributors/guide/github-workflow.md)

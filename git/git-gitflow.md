# GitFlow

## GitHub 贡献代码

1. Fork 开源项目

    1.1. 访问 <https://github.com/kubernetes/website>
    1.2. 点击右上角的 `Fork` 按钮

2. Clone 到本地

```bash
$ git clone git@github.com:jinsyin/website.git

$ git remote add upstream git@github.com:kubernetes/website.git

# 不允许推送到 upstream master
$ git remote set-url --push upstream no_push

# 验证
$ git remote -v
```

3. 分支管理

拉取上游所有分支，并让本地 master 分支保持最新状态：

```bash
$ git fetch upstream
$ git checkout master
$ git rebase upstream/master
```

建立分支：

```bash
$ git checkout -b myfeature
```

4. 保持分支同步

```bash
# While on your myfeature branch
$ git fetch upstream
$ git rebase upstream/master
```

<!--
Please don't use git pull instead of the above fetch / rebase. git pull does a merge, which leaves merge commits. These make the commit history messy and violate the principle that commits ought to be individually understandable and useful (see below). You can also consider changing your .git/config file via git config branch.autoSetupRebase always to change the behavior of git pull.
-->

5. commit

```bash
$ git commit
```

Likely you go back and edit/build/test some more then `commit --amend` in a few cycles.

6. Push

```bash
$ git push -f ${your_remote_name} myfeature
```

7. 创建 PR

* https://deploy-preview-8234--kubernetes-io-master-staging.netlify.com/

## 参考

* [Kubernetes Workflow](https://github.com/kubernetes/community/blob/master/contributors/guide/github-workflow.md)
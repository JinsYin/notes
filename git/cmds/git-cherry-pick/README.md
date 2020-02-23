# GIT-CHERRY-PICK 「精心挑选」

在当前分支或某个提交之上，重新应用挑选的已有提交。

## Rebase 与 Cherry-pick

rebase: 将当前分支相较于目标分支的差异提交（通常是多个）重新应用到目标分支上，最终在目标分支上创建了一个个新的提交（即差异提交的 hash 发生改变）
cherry-pick: 将目标分支上的某个提交重新应用到当前分支上，最终在当前分支上创建了一个新的提交（即挑选的提交的 hash 发生改变）

## Author 与 Committer

当挑选某个开发者的 commit 引用到自己的代码上时，author 将是被挑选者的 name，而 commit 则是自己的 name 。

典型的是，引用了创建 Github 仓库时所创建的 `README.md` 和 `LICENSE` 。

## 范例

```sh
git cherry-pick # 把某个分支的一次或几次提交在当前分支上重演（即重新应用），而原来的分支保持不变（可以用来避免了分支合并）
git cherry-pick <commit> # 单独合并一个提交
git cherry-pick -x <commit> # 同上，不同点：保留原提交者信息。
git cherry-pick <start_commit>..<end_commit>
git cherry-pick <start_commit>^..<end_commit>
```

## 应用场景

* 当在 A 分支上做了几次 commit 后，发现实际应该在 B 分支上工作，因此需要将 A 分支上的 commit 重新应用到 B 分支上

## 参考

* [git cherry-pick 使用指南](https://www.jianshu.com/p/08c3f1804b36)

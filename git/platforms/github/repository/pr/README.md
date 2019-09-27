# Github Pull Request（PR）

## 合并 PR 的方式

create a merge commit // 将 PR 分支（compare）和基分支（base）进行合并，并产生一个 merge 提交 ——  PR 分支和基分支新的交叉

squash and merge // 将 PR 分支上与基分支分叉后的所有提交（预）组合成一个提交后应用到基分支上，最终，PR 分支保持不变，主分支生成一个新的提交

rebase and merg // 将 PR 分支上与基分支分叉后的所有提交重新应用到基分支上，最终 PR 分支保存不变，主分支产生新的提交（本地的 `git rebase` 是基分支不变，源分支更新到了基分支）

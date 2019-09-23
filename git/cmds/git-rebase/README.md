# GIT-REBASE 「变基」

「变基」：在另一个基础提交之上重新应用提交（Reapply commits on top of another base tip）。换而言之，在基分支上重演，最终基分支不变，当前分支被更新

> GitRebase 出错时 Git 很可能处于分离头指针状态

## 用法

```sh
git rebase [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
        [<upstream> [<branch>]] # ①
git rebase [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
        --root [<branch>] # ②
git rebase --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch # ③
```

## 选项

| 参数                | 描述                                                                                                                        |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `-i, --interactive` | 交互模式                                                                                                                    |
| `--amend`           | 相当于 `git rebase -i HEAD~1` 的 `edit` 行为；如果需要修订非最近一次提交，采用 `git rebase -i` 的 `reword` 或 `edit` 等行为 |

## 式③

| 参数                    | 描述                                                                                                      |
| ----------------------- | --------------------------------------------------------------------------------------------------------- |
| `git rebase --continue` | 修复完冲突后运行此命令                                                                                    |
| `git rebase --abort`    | 放弃合并，回到 rebase 之前的状态，不会丢弃之前的提交                                                      |
| `git rebase --skip`     | 直接丢弃引起冲突的 commit/patch；或者解决冲突后完成了自我提交（`git commit [--amend] ...`），之后需要跳过 |

对于 `git rebase --skip`，当 Patch 与 HEAD 出现冲突时，如果解决冲突时所有冲突文件 **将** 全部采用 HEAD 的内容，即使按照此方式依次解决了冲突再 `git add ..`，最后使用 `git rebase --continue` 仍然会提示 “No changes”，这是应该使用 `git rebase --skip` 而不是 `git rebase --continue`。如果一开始就是跳过，下一个 Patch 时可能还会遇到该问题。

## 描述

```graph
      A---B---C topic (HEAD)           [git rebase master]                           A'--B'--C' topic (HEAD)
     /                            ---------------------------->                     /
D---E---F---G master                [git rebase master topic]          D---E---F---G master
```

「变基（rebasing）」：

1. 找到两个分支（即源当前分支 topic 和目标基底分支 master）的最近共同祖先 E
2. 提取源当前分支相对于祖先 E 的历次提交，并将其另存为临时文件
3. 将当前分支（HEAD）指向目标基底 G，并将之前临时文件的一系列提交按原有次序依次应用到该分支上，HEAD 随着应用的提交逐步更新
4. 整个过程中，基底分支不会发生变化，而源当前分支会随之更新到基底分支的主干上，因此 “变基” 之前最好对源当前分支进行备份

## 交互模式

命令：`git rebase -i START_COMMIT END_COMMIT`

行格式：

```vim
// 从上到下排序、从上到下执行
// 如果删除某一行，该提交将被丢弃
// 如果删除所有行，rebase 将被终止（abort）
(action) (partial-sha) (short commit message)
```

交互行为：

| 行为（action） | 描述                                                 |
| -------------- | ---------------------------------------------------- |
| `p`、`pick`    | （默认行为）使用该 commit，但不做任何修改            |
| `r`、`reword`  | use commit, but edit the commit message              |
| `e`、`edit`    | use commit, but stop for amending                    |
| `s`、`squash`  | 使用该 commit，但合并到之前的提交                    |
| `f`、`fixup`   | like "squash", but discard this commit's log message |
| `x`、`exec`    | run command (the rest of the line) using shell       |
| `d`、`drop`    | remove commit                                        |

交互流程：

1. 交互前对源当前分支进行备份（`git branch <srcbak> <srcbranch>`），防止交互结果不理想
2. 交互前如果工作区和/或暂存区存在修改，需要进行储藏（`git stash save -u "..."`）
3. `git rebase -i <START_COMMIT> <END_COMMIT>`
   1. 合并时 HEAD 指向 START_COMMIT，意味着整个过程将一直处于无分支（即分离头指针）状态
   2. 在编辑视图中，Commit 对象的范围是：`(START_COMMIT, END_COMMIT]`，END_COMMIT 的缺省值是 HEAD
   3. 合并时如果 END_COMMIT 不是 HEAD，合并完成后将依然处于无分支状态，最终 HEAD 指向 END_COMMIT（该方式意义不大）
   4. 通常是将 END_COMMIT 设置为 HEAD，对于 `(END_COMMIT, HEAD]` 之间不需要修改的 commit 直接设置为 `pick` 行为
   5. 交互过程中，可以随时终止：`git rebase --abort`，最终回到原来的分支
4. Git 将启动默认编辑器，根据需求编辑相关行为（action）然后保存
   1. 如果要使用 `squash` 行为，必须确保前一个提交的行为是 `pick`，所以可能需要手动添加一个 `pick` 行或者移动一个 `pick` 行
   2. 如何直接编辑行为外，还可以移动、添加一个 ”提交行“
5. 保存行为后 Git 会根据相关行为自动应用提交
   1. `squash` 行为且无冲突，会再次启动编辑器，需要编辑合并的 commit 信息
6. 解决冲突的办法（使用 `git diff <file>...` 或 `diff [-r] <HEAD-path> <PATCH-path>` 定位冲突标记，以及使用 `git grep '<<<<<<<'` 查找冲突文件）
   * 编辑、删除冲突文件和其他（如新增、删除文件） -> `git add` -> `git rebase --continue`，其中 `git add` 就是告知 Git 冲突已被解决
   * 编辑、删除冲突文件和其他（如新增、删除文件） -> `git add` -> `git commit -m "message"` -> `git rebase --skip`，也就是自行完成提交以修改 Patch 的 commit message
   * 编程、删除冲突文件和其他（如新增、删除文件） -> `git add` -> `git commit --amend`，也就是将解决好的冲突并入最近一次提交
   * 放弃解决冲突，选择直接跳过：`git rebase --skip`
7. 重新应用提交会从 START_COMMIT 开始生成新的 CommitID
8. 比较新当前分支与备份分支之间的差异，看看结果是否理想。如果合并没有问题，记得删除备份分支：`git branch <srcbak>`
9. 如果结果满意，可以恢复之间工作区和暂存区的内容：`git stash pop 0`

交互技巧：

* 如果要合并两个或多个离散的 commit，需要移动 commit 的位置并使之连续，然后再设置相应的行为
* 如果要使用第一个 commit，可以在 `git rebase -i <first_commit>` 进入交互模式后在第一行手动添加 `pick <first_commit>`
* 完成交换操作后，当前 commit ID 及其之后的 commit ID 通常会改变，而日期不会发生改变
* commit 的范围是 `(x, y]`，如果需求是合并（squash、fixup 等），至少需要选择被合并的 commit 前两个的 commit；如果需求是编辑（edit、reword 等），至少要选择需要被编辑的 commit 的前一个 commit

## 合并流程

1. 合并前对源分支进行备份（`git branch <srcbak> <srcbranch>`），以免合并结果不理想
2. 合并（`git rebase <dstbranch>`）
   * 它将从目标分支（即基分支）和源分支的分叉点开始，自动在基分支上依次应用分叉点到源分支上的每一个 commit（亦称 patch），并且 CommitID 会发生改变
   * 整个合并过程一直处于无分支（no branch）/分离头指针（detached HEAD）状态，HEAD 指向基分支上最近一次应用成功的 commit（最开始时指向基分支）
   * 应用的 Rebase 信息位于 `.git/rebase-apply/` 目录
   * 合并过程中，可以随时终止合并：`git rebase --abort`，最终回到原来的分支
3. 如果有冲突，GitRebase 将停在有冲突的 commit/patch 处（即 incoming commit），冲突提示显示在 `git status` 的 “Unmerged paths” 区域
4. 解决冲突的方法同 ”交互流程“，不同的可能是 ”冲突提示“，解决完冲突之后，Git 会继续 Rebase 进程，以应用下一个的 commit
5. 遇到冲突时可以查看 Patch 信息：`git am --show-current-patch`
   1. 需要注意的是，此处的 Patch 不是 incoming commit 相当于目标分支上 HEAD 所做的修改，而是 incoming commit 在源分支上相对于前一个 commit 所在的修改，因此参考的意义基本在于查看 Patch 的 commit id 和 commit message
   2. 如果要查看 incoming commit 相对于 HEAD 做的修改，可以：`git diff HEAD <patch-commit>`
   3. 可以使用 `git diff HEAD -- <paths>` 比较暂存区与版本库的差异
   4. 可以使用 `git diff --cached HEAD [<paths>]` 比较暂存区与版本库的差异
6. 解决完冲突并 GitAdd 之后，应当对比暂存区和 HEAD（`git diff --cached HEAD [<paths>...]`），以及 Patch 的 commit message（`git am --show-current-patch`），看看是否前后内容满意
   * 如果对此次的 Patch 或者 commit message 不满意，可以自行进行一次提交（`git commit -m ....`）或合并到最近一次提交（`git commit --amend`），然后直接跳过 Patch `git rebase --skip`（或者不自行提交和合并到最近一次提交，直接跳过，但可能下一个 incoming commit 还会遇到）
   * 如果觉得符合，继续下一个 patch：`git rebase --continue`
   * 冲突时，可能已经有文件被自动添加到了暂存区，一定要先检查暂存区的文件是否是需要的!
7. 合并完成后两个分支变为一个分支，目标分支保存不变，原先的源分支被应用到目标分支上且分支名不变，最终 HEAD 指向新的 <srcbranch>
8. 比较新当前分支与备份分支之间的差异，看看结果是否理想。如果合并没有问题，记得删除备份分支：`git branch <srcbak>`

## 冲突提示

“冲突提示” 显示在 `git status` 的 “Unmerged paths” 区域。

| 冲突提示        | 描述                                                          |
| --------------- | ------------------------------------------------------------- |
| both added      | incoming commit 和 HEAD 都新建了同一文件且存在冲突            |
| both modified   | incoming commit 和 HEAD 都修改了同一文件且存在冲突            |
| both deleted    | incoming commit 和 HEAD 都删除了同一文件                      |
| added by us     | HEAD（即 us） 相对于 incoming commit 所添加的文件             |
| deleted by us   | HEAD（即 us） 删除了该文件，但 incoming commit 又增加了该文件 |
| added by them   | incoming commit（即 them） 相对于 HEAD 所添加的文件           |
| deleted by them | incoming commit（即 them） 相对于 HEAD 所删除的文件           |

采用 HEAD 的内容：`git checkout --ours <conflict-file>`
采用 incoming commit 的内容：`git checkout --theirs <conflict-file>`

```sh
rm-bd = !git status | grep 'both deleted' | awk '{print $3}' | xargs git rm
rm-abus = !git status | grep 'added by us' | awk '{print $4}' | xargs git rm
rm-abthem = !git status | grep 'added by them' | awk '{print $4}' | xargs git rm
rm-dbus = !git status | grep 'deleted by us' | awk '{print $4}' | xargs git rm
add-abus = !git status | grep 'added by us' | awk '{print $4}' | xargs git add
add-abthem = !git status | grep 'added by them' | awk '{print $4}' | xargs git add
add-dbus = !git status | grep 'deleted by us' | awk '{print $4}' | xargs git add // 被我们删除，incoming commit 有添加了回来
```

* 相对于 incoming commit 的上一次 commit 所做的修改，而不是相对于 HEAD；
    * 可以使用 `git diff HEAD -- <paths>` 比较暂存区与版本库的差异
    * 可以使用 `git diff --cached HEAD [<paths>]` 比较暂存区与版本库的差异
* 当 patch 相对于 HEAD 没有作任何修改是，可以直接跳过 `git rebase --skip`

## 实验场景一 · 合并多个连续的 commit 成 1 个

```sh
git init e1 && cd e1

echo "Web" > README && git add . && git commit -m "Add README"

echo "<html></html>" > index.html && git add . && git commit -m "Home page"

mkdir js && touch js/script.js && git add . && git commit -m "Add js"

mkdir css && touch css/style.js && git add . && git commit -m "Add css"

git mv README README.md && git commit -m "rename README to README.md"
```

```sh
$ git log --oneline --graph
* e6706f9 (HEAD -> master) rename README to README.md
* 0a12fcd Add css
* 17b0128 Add js
* f9bfb66 Home page
* fb7cb97 Add README
```

``````sh
# 基于第一个提交（可以写成 HEAD~n 形式）
$ git rebase -i fb7cb97 # (startCommit, endCommit]，缺省 endCommit 时默认是 HEAD （即最近一次提交）

```
# 将 #3 和 #4 合并到 #2 （使用 squash 必须确保前一个提交为 pick）
p f9bfb66 Home page #2 （base tip 必须是 pick）
s 17b0128 Add js       #3
s 0a12fcd Add css      #4
p e6706f9 rename README to README.md #5
````

```
# 修改 commit message
Web frontend
```
``````

```sh
$ git log --oneline --graph
* 94576fb (HEAD -> master) rename README to README.md
* a2cd20e Web frontpage
* fb7cb97 Add README
```

## 实验场景二 · 把几个间隔的 commit 整合成 1 个

根据实验一，合并 94576fb 和 fb7cb97 为 1 个 commit：

``````sh
$ git rebase -i fb7cb97 # (fb7cb97, HEAD]

```
pick fb7cb97 # 手动添加 base tip
s 2a50998 rename README to README.md # 改变顺序并合并到 base tip
pick 4ad2f07 Web frontend
```

```sh
$ git rebase --continue
README # 修改后的 commit message
```

```sh
$ git log --oneline --graph
* 2c84512 (HEAD -> master) Web frontend
* 5f0c43a README
```
``````

---

```sh
# 希望将 #1 和 #2 合并为一个提交
$ git lg
* 2019-09-12 4102626 - (HEAD -> master) 文档及项目文档 [jinsyin]  #1
* 2019-09-12 ab35fcb - Extended Node.js [jinsyin]
* 2019-09-12 0ae3841 - Extended Java [jinsyin]
* 2019-09-12 9f886a6 - Extended Go [jinsyin]
* 2019-09-12 b85b0fc - Extended scala [jinsyin]
* 2019-09-12 cc1eb9f - Extended Python [jinsyin]
* 2019-05-06 00f95af - (origin/master, origin/HEAD) Initial commit [GitHub] #2
```

```sh
$ git rebase -i 00f95af
pick 00f95af # 手动添加 base tip
s 00f95af 文档及项目文档
pick cc1eb9f Extended Python
...
```

```sh
$ git rebase --continue # 遇到冲突解决冲突，直到完成
```

## 实验场景三 · 拆分提交

## 参考

* [Git 之 交互式 rebase](https://segmentfault.com/a/1190000012897755)

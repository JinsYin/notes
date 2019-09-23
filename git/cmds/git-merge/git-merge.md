# GIT-MERGE 「三方合并」

将两个或多个开发历史连接在一起。

## 用法

```sh
git merge [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
        [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
        [--[no-]allow-unrelated-histories]
        [--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
```

```sh
# 只能在合并导致冲突后运行
# 将中止合并进程，并尝试重建预合并状态。但是如果在合并开始是有未提交的更改（尤其是在合并开始后进一步修改了这些更改），则它在某些情况下将无法重建原始（预合并）更改，因此：警告：不鼓励使用不重要的未提交更改运行git merge：如果可能，它可能会使您处于一种在发生冲突时很难退出的状态。
git merge --abort
```

```sh
# 只能在合并导致冲突后运行
git merge --continue
```

## 选项

| 选项      | 描述                               |
| --------- | ---------------------------------- |
| --ff      | 快进（fast-forward）合并；默认行为 |
| --no-ff   | 创建一个新的提交对象               |
| --ff-only |                                    |

## 描述

将命名提交的更改（从其历史记录与当前分支分离是起）合并到当前分支。`git pull` 使用此命令合并来自另一个仓库的更改，以及可以手动将一个分支的更改合并到另一个分支。

```graph
      A---B---C topic                                       A---B---C topic
     /                           git merge topic           /         \
D---E---F---G master (HEAD)    ------------------>    D---E---F---G---H master (HEAD)
```

* 合并结果会记录在新的 commit （即图中的 H），换而言之，合并后会产生一个新的提交

原理（三方合并）：

1. 找到两个分支（即当前分支和待合并分支）的最近共同祖先 E
2. 两个分支的最新快照（C 和 G）以及二者最近的共同祖先 E 进行三方合并
3. 合并结果生成一个新的快照（H）并提交

## 快进合并流程

1. 确保 `<newbranch>` 在 `<oldbranch>` 之后，且不存在分叉
2. 切换到靠前的分支：`git checkout <oldbranch>`
3. 合并：`git merge <newbranch>`（等同于 `git merge --ff <newbranch>`）
4. 合并完成后 `<oldbranch>` 和 `<newbranch>` 指向同一个 commit 对象
5. 如无其他需求，删除 <oldbranch>：`git branch -d <oldbranch>`

## 冲突

### 呈现

### 解决

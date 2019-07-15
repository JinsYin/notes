# GIT-REBASE

Reapply commits on top of another base tip（在一个基础提交之上重新生成提交）

> git-rebase error 时 Git 很可能处于分离头指针状态

## 比较

| 参数                  | 描述                                                 |
| --------------------- | ---------------------------------------------------- |
| git rebase --continue | 修复完冲突后运行此命令                               |
| git rebase --abort    | 放弃合并，回到 rebase 之前的状态，不会丢弃之前的提交 |
| git rebase --skip     | 丢弃引起冲突的 commit                                |

| 参数                | 描述     |
| ------------------- | -------- |
| `-i, --interactive` | 交互模式 |

```plain
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
# d, drop = remove commit
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```

## 实验一 · 合并连续的多个 commit 成 1 个

```bash
git init e1 && cd e1

echo "Web" > README && git add . && git commit -m "Add README"

echo "<html></html>" > index.html && git add . && git commit -m "Home page"

mkdir js && touch js/script.js && git add . && git commit -m "Add js"

mkdir css && touch css/style.js && git add . && git commit -m "Add css"

git mv README README.md && git commit -m "rename README to README.md"
```

```bash
$ git log --oneline --graph
* e6706f9 (HEAD -> master) rename README to README.md
* 0a12fcd Add css
* 17b0128 Add js
* f9bfb66 Home page
* fb7cb97 Add README
```

``````bash
# 基于第一个提交（可以写成 HEAD~n 形式）
$ git rebase -i fb7cb97 # (startCommit, endCommit]，缺省 endCommit 时默认是 HEAD （即最近一次提交）

```
# 将 #3 和 #4 合并到 #2 （使用 squash 必须确保前一个提交为 pick）
pick f9bfb66 Home page #2 （base tip 必须是 pick）
s 17b0128 Add js       #3
s 0a12fcd Add css      #4
pick e6706f9 rename README to README.md #5
````

```
# 修改 commit message
Web frontend
```
``````

```bash
$ git log --oneline --graph
* 94576fb (HEAD -> master) rename README to README.md
* a2cd20e Web frontpage
* fb7cb97 Add README
```

## 实验二 · 把几个间隔的 commit 整合成 1 个

根据实验一，合并 94576fb 和 fb7cb97 为 1 个 commit：

``````bash
$ git rebase -i fb7cb97 # (fb7cb97, HEAD]

```
pick fb7cb97 # 手动添加 base tip
s 2a50998 rename README to README.md # 改变顺序并合并到 base tip
pick 4ad2f07 Web frontend
```

```bash
$ git rebase --continue
README # 修改后的 commit message
```

```bash
$ git log --oneline --graph
* 2c84512 (HEAD -> master) Web frontend
* 5f0c43a README
```
``````
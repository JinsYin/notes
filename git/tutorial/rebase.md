# Git rebase

## 比较

| command               | 描述                                                         |
| --------------------- | ------------------------------------------------------------ |
| git rebase --continue | fix conflicts and then run "git rebase --continue"           |
| git rebase --abort    | 会放弃合并，回到 rebase 操作之前的状态，之前的提交的不会丢弃 |
| git rebase --skip     | 将引起冲突的 commits 丢弃掉                                  |
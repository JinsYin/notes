# Git rebase

## 比较

| command               | 描述                                                 |
| --------------------- | ---------------------------------------------------- |
| git rebase --continue | 修复完冲突后运行此命令                               |
| git rebase --abort    | 放弃合并，回到 rebase 之前的状态，不会丢弃之前的提交 |
| git rebase --skip     | 丢弃引起冲突的 commit                                |

## 实验一 ·
# git pull

## `git pull` vs `git rebase` vs `git merge`

`git pull` = `git fetch` + `git merge`
`git pull --rebase` = `git fetch` + `git rebase`（建议使用后者代替前者，避免误操作，比如少打了一个 `--rebase`）

git rebase，顾名思义就是重新定义（re）起点（base）的作用，即重新定义分支的版本库状态。
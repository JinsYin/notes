# git merge

## 用法

```sh
git merge [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
        [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
        [--[no-]allow-unrelated-histories]
        [--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
```

```sh
git merge --abort
```

```sh
git merge --continue
```

## 选项

## 描述

```graph
      A---B---C topic                                       A---B---C topic
     /                           git merge topic           /         \
D---E---F---G master (HEAD)    ==================>    D---E---F---G---H master (HEAD)
```
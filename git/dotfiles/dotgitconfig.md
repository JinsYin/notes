---
---
# .gitconfig

```sh
# Git 别名不区分大小写
$ cat ~/.gitconfig
[alias]
        aa = add -A .
        amend = commit --amend # 修订最近一次提交的 message，并提交暂存区的内容
        alias = !"fn() { git aliases | awk -v pattern=$1 '$1==pattern'; }; fn" # or: git config --global alias.$1
        aliases = !git config --get-regexp "^alias\\." | cut -c 7- | sed 's| | = |'
        b = branch -a -v
        br = branch
        brd = branch -d
        brdd = branch -D
        brdr = branch -d -r
        cat = cat-file -p
        cat-head = !git cat-file -p $(git hh)
        cat-type = cat-file -t
        cat-size = cat-file -s
        cat-exit = cat-file -e
        ce = config -e --global
        cel = config -e --local
        cg = config --global
        # 显示 commit 相对于 parent 的更新（`git show COMMIT` 相似但不支持 merge commit）
        # git ch | git ch 9b965a1 | git ch 9b965a1 README.md | git ch HEAD README.md
        ch = !"fn() { git diff --patch --stat $(git parent \"${1:-HEAD}\") \"${1:-HEAD}\" -- $2; }; fn"
        child = "!bash -c 'git log --format=%H --reverse --ancestry-path ${1:-HEAD}..${2:\"$(git rev-parse --abbrev-ref HEAD)\"} | head -1' -"
        parent = !"fn() { git rev-parse \"${1:-HEAD}~1\" | head -1; }; fn"
        ci = commit
        cl = clone
        clb = clone --single-branch --branch # git clb <branch> <repo>
        clhead = clone --depth=1 # git clhead <repo>
        co = checkout
        cob = checkout -b
        count = shortlog -sn
        date = !"fn() { date +'%Y:%m:%d %H:%M:%S'; }; fn"
        d = diff --patch --stat
        dc = diff --cached --patch --stat
        dt = difftool
        dtc = difftool --cached
        dis = restore         # 丢弃（discard）工作区的修改；git dis = git discard
        discard = checkout -- # 丢弃（discard）工作区的修改; git dis = git discard
        e = !vim
        edit = !vim
        f = fetch
        find = !git ls-files | grep -i # 查找工作区和暂存区的文件
        gr = grep -Ii --line-number
        head = rev-parse --abbrev-ref HEAD
        hh = log --pretty=format:'%Cred%h%Creset' -n 1 # head hash
        hash = !"fn() { git rev-parse \"${1:-HEAD}\"; }; fn" // 获取 Git 对象、分支的完整哈希；git hash HEAD~1 | git hash master | git hash a858be （返回完整的 commit/tree/blob hash）
        id = !"fn() { git log --pretty=format:'%Cred%h%Creset' -n 1 \"${1:-HEAD}\" | xargs echo; }; fn" # short hash
        k = !gitk --all --branches
        ke = !gitk --all $(git log -g --pretty=%h)
        ignore = !vim $(git cwd)/.gitignore
        last = lg -n1 HEAD
        lg = log --abbrev-commit --color --date=format:'%Y-%m-%d' --decorate --graph --pretty=format:'%C(green)%ad%Creset %Cred%h%Creset -%C(yellow)%d%Creset %s %C(blue)[%cn]%Creset'
        la = lg --all
        lstat = lg --stat
        ls = ls-files # ls -c, ls -m, ls -d ...
        lsfile = ls-files
        lstree = ls-tree
        lf = ls-file
        lt = ls-tree
        ltr = ls-tree -r
        mg = merge
        mod = submodule
        modprobe = !git submodule add git://github.com/$1 $2/$(basename $1)
        modupdate = submodule update --init --recursive
        modpull = !git submodule foreach git pull --tags origin master
        pk = cherry-pick
        pka = cherry-pick --abort
        pkc = cherry-pick --continue
        rd = rm -r
        rb = rebase
        git rbc // 不变
        rbc = rebase --continue
        rbabort = rebase --abort # 防止敲错（a 和 s 靠的太近）
        rbskip = rebase --skip # 防止敲错（a 和 s 靠的太近）
        rbquit = rebase --quit
        rbedit = rebase --edit-todo
        rbpatch = am --show-current-patch # 查看 GitRebase 因冲突而停止时所应用的 commit/patch
        rbours = checkout --ours     # rebase 合并遇到冲突而停止时，应用最近一次提交成功的内容来解决冲突
        rbtheirs = checkout --theirs # rebase 合并遇到冲突而停止时，应用补丁（当前正在应用的 commit）的内容来解决冲突
        rbchanged = diff HEAD --
        rbfixed = diff --cached HEAD --
        rl = reflog --abbrev-commit --color --date=format:'%Y-%m-%d' --pretty=format:'%C(green)%ad%Creset %Cred%h%Creset -%C(yellow)%d%Creset %C(cyan)%gd%Creset %C(auto)%gs%C(reset) %C(blue)[%cn]%Creset'
        root = rev-parse --show-toplevel # Git root directory
        rr = remote # Remote Repositories
        rrv = rr -v
        rmc = rm --cached
        s = status
        st = status
        ss = status --short
        sh = stash
        sl = stash list --date=format:'%Y-%m-%d' --pretty=format:'%Cgreen%ad %C(red)%h%C(reset) - %C(yellow)(%gD)%C(reset): %s %C(blue)[%cn]%C(reset)'
        shapply = stash apply
        shdrop = stash drop
        shpop = stash pop
        shpatch = stash show -p # git shpatch "stash@{0}" / git shpatch "stash@{1}"；储藏前和储藏后的差异（储藏后发生了修改不会影响补丁的内容）
        shsave = stash save -u
        shunapply = !git stash show -p | git apply -R
        snap = !git stash save "snapshot: $(date +'%Y:%m:%d-%H:%M:%S')" && git stash apply 'stash@{0}'
        tar = !"fn() { top=$(git topname); date=$(date +'%Y%m%d'); name=$top-$date.tar; cd $top; tar cvf $name $top; echo '\n'; ls -l $name; }; fn"
        targz = !"fn() { top=$(git topname); date=$(date +'%Y%m%d'); name=$top-$date.tar.gz; cd $top; tar cvzf $name $top; echo '\n'; ls -l $name; }; fn"
        tree = ls-tree
        tr = ls-tree -r # 递归查找 tree 对象；git tr HEAD~1 os/linux | git tr HEAD~1 | grep os/linux
        tree-head = !git ls-tree -r $(git hh)
        unadd = reset HEAD --          # git unstage = git unadd
        unstage = restore --staged     # 将暂存区的所有 <paths> 重置为 HEAD 时的状态
        uncommit = reset --soft HEAD~1 # 撤销最近一次提交（不重置工作区和暂存区）
        undo = reset --mixed HEAD~1    # 撤销最近一次提交并重置暂存区，但不重置工作区，即 git undo = git uncommit + git unstage
        upname = !git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD) # upstream name
        who = log -i -n1 --pretty=format:'Author:%C(blue)[%an]%Creset Email:%C(yellow)<%ae>%Creset'
[color]
        ui = auto
[color "branch"]
        current = green reverse
        local = yellow
        remote = red
# [color "diff"]
#         meta = yellow bold
#         frag = magenta bold
#         old = red bold
#         new = green bold
[color "status"]
        added = green
        changed = yellow
        unmerged = magenta # 未合并的冲突文件
        untracked = red
[diff]
        tool = vimdiff
[difftool]
        prompt = false
[http]
       proxy = http://127.0.0.1:1080 # HTTP 代理
[pager]
        diff = gsed \"s|diff --git|\\n~~~\\n\\ndiff --git|\" | less # brew install gnu-sed
        show = gsed \"s|diff --git|\\n~~~\\n\\ndiff --git|\" | less # brew install gnu-sed
        branch = cat # zsh
```

# .gitconfig

```sh
$ cat ~/.gitconfig
[alias]
        aa = add -A .
        aamend = commit -a --amend
        amend = commit --amend # 修订最近一次提交，并提交暂存区
        aliases = "!git config --get-regexp '^alias\\.' | cut -c 7- | sed 's/ / = /'"
        b = branch
        br = branch
        bra = branch -a
        brav = branch -a -v
        brd = branch -d
        brdr = branch -d -r
        brD = branch -D
        brname = rev-parse --abbrev-ref HEAD
        ce = config --global -e
        cg = config --global
        ci = commit
        cl = clone
        co = checkout
        cob = checkout -b
        cp = cherry-pick
	cpa = cherry-pick --abort
	cpc = cherry-pick --continue
        date = !"fn() { date +'%Y:%m:%d %H:%M:%S'; }; fn"
        d = diff
        dc = diff --cached
        dt = difftool
        dct = difftool --cached
        discard = checkout -- # 丢弃（discard）工作区的修改
        f = fetch
        find = !git ls-files | grep -i
        g = grep
        gr = g -Ii --line-number
        ghclone = !git clone git://github.com/$1 $(basename $1)
        gpclone = !git clone git@github.com:$1 $(basename $1)
        ghcopy = !git clone git@github.com:$(git config --get user.username)/$1 $1
        head = brname
        HEAD = brname
        last = lg -n1 HEAD
        l = log --abbrev-commit --color --date=format:'%Y-%m-%d' --decorate --graph --pretty=format:'%C(green)%ad%Creset %Cred%h%Creset -%C(yellow)%d%Creset %s %C(blue)[%cn]%Creset'
        lg = l
        la = lg --all
        lstat = lg --stat
        ls = ls-files # ls -c, ls -m, ls -d ...
        mod = submodule
        modprobe = !git submodule add git://github.com/$1 $2/$(basename $1)
        modupdate = submodule update --init --recursive
        modpull = !git submodule foreach git pull --tags origin master
        rb = rebase
        rl = reflog --abbrev-commit --color --date=format:'%Y-%m-%d' --pretty=format:'%C(green)%ad%Creset %Cred%h%Creset -%C(yellow)%d%Creset %C(cyan)%gd%Creset %C(auto)%gs%C(reset) %C(blue)[%cn]%Creset'
        rr = remote # Remote Repositories
        rrv = rr -v
        rmc = rm --cached
        sl = stash list --date=format:'%Y-%m-%d' --pretty=format:'%Cgreen%ad %C(red)%h%C(reset) - %C(yellow)(%gD)%C(reset): %s %C(blue)[%cn]%C(reset)'
        s = status
        st = status
        ss = status --short
        snap = !git stash save "snapshot: $(date +'%Y:%m:%d-%H:%M:%S')" && git stash apply 'stash@{0}'
        tar = !"fn() { top=$(git topname); date=$(date +'%Y%m%d'); name=$top-$date.tar; cd $top; tar cvf $name $top; echo '\n'; ls -l $name; }; fn"
        targz = !"fn() { top=$(git topname); date=$(date +'%Y%m%d'); name=$top-$date.tar.gz; cd $top; tar cvzf $name $top; echo '\n'; ls -l $name; }; fn"
        track = add
        topname = rev-parse --show-toplevel
        uncommit = reset --soft HEAD~1 # 撤销最近一次提交（不重置工作区和暂存区）
        unstage = reset HEAD --        # 撤销暂存，即重置暂存区或暂存区的某个/某些路径
        undo = reset --mixed HEAD~1    # 撤销提交和暂存，即 git uncommit && git unstage
        upname = !git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD) # upstream name
        visual = !gitk
        who = git log -i -n1 --pretty=format:'Author:%C(blue)[%an]%Creset Email:%C(yellow)<%ae>%Creset'
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
        untracked = red
[diff]
        tool = vimdiff
[difftool]
        prompt = false
[http]
       proxy = http://127.0.0.1:1080
```
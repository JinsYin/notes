# Git 存储目录结构

Git 的数据结构存储在当前项目的 `.git` 目录中。

```sh
$ cd myproject && tree .git
.git
├── branches
├── config
├── description
├── HEAD
├── hooks
│   ├── applypatch-msg.sample
│   ├── commit-msg.sample
│   ├── fsmonitor-watchman.sample
│   ├── post-update.sample
│   ├── pre-applypatch.sample
│   ├── pre-commit.sample
│   ├── prepare-commit-msg.sample
│   ├── pre-push.sample
│   ├── pre-rebase.sample
│   ├── pre-receive.sample
│   └── update.sample
├── info
│   └── exclude
├── objects
│   ├── info
│   └── pack
└── refs
    ├── heads # 对应分支
    └── tags  # 里程碑版本
```

* HEAD

```sh
$ cat .git/HEAD
ref: refs/heads/master

$ git checkout -b test

$ cat .git/HEAD
ref: refs/heads/test
```

* .git/config

```sh
$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true

$ git config --local user.name 'Jins Yin'

$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
[user]
    name = Jins Yin
```

* refs

```sh
$ cat .git/refs/heads/master
f01e8e8d194770a2e4134815be41ae1214b6a41c

# 查看对象类型
$ git cat-file -t f01e8e
commit
```
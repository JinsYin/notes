---
---
# .git 目录结构

Git 的数据结构存储在当前项目的 `.git` 目录中。

```sh
├── COMMIT_EDITMSG
├── FETCH_HEAD
├── HEAD
├── MERGE_MSG.save
├── ORIG_HEAD
├── branches
├── config
├── description
├── gitk.cache
├── gitweb
│   ├── access.log
│   ├── error.log
│   ├── gitweb_config.perl
│   ├── tmp
│   ├── webrick
│   │   └── wrapper.sh
│   └── webrick.rb
├── hooks
│   ├── applypatch-msg.sample
│   ├── commit-msg.sample
│   ├── post-update.sample
│   ├── pre-applypatch.sample
│   ├── pre-commit.sample
│   ├── pre-push.sample
│   ├── pre-rebase.sample
│   ├── prepare-commit-msg.sample
│   └── update.sample
├── index
├── info
│   ├── exclude
│   └── refs
├── logs
│   ├── HEAD
│   └── refs
│       ├── heads
│       │   ├── master
│       │   ├── master-backup
│       │   └── tes
│       ├── remotes
│       │   ├── origin
│       │   │   ├── HEAD
│       │   │   └── master
│       │   └── wrf
│       └── stash
├── objects
│   ├── xx
│   │   ├── zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz # 完整的对象 ID 是 xxzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
│   │   └── ......................................
│   ├── ..
│   │   ├── ......................................
│   │   └── ......................................
│   ├── info
│   │   └── packs
│   └── pack
│       ├── pack-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.idx
│       ├── pack-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.pack
│       ├── .................................................
│       └── ..................................................
├── packed-refs
└── refs
    ├── heads  # 本地分支
    │   ├── master
    │   ├── master-backup
    │   └── tes
    ├── remotes # 远程追踪分支
    │   ├── origin
    │   │   ├── HEAD
    │   │   └── master
    │   └── wrf
    ├── stash
    └── tags
```

## .git/HEAD

```sh
$ cat .git/HEAD
ref: refs/heads/master

$ git checkout -b test

$ cat .git/HEAD
ref: refs/heads/test
```

## .git/config

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

## .git/refs/

```sh
$ cat .git/refs/heads/master
b174f8a55227aa3c882ac4a77936005d45c9dd39

# 查看对象类型
$ git cat-file -t b174f8
commit

$ ls -l .git/objects/b1/74f8a55227aa3c882ac4a77936005d45c9dd39
-r--r--r--  1 in  staff  203 Sep 11 16:07 .git/objects/b1/74f8a55227aa3c882ac4a77936005d45c9dd39
```

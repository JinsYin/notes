# pstree

显示进程树

## 安装

* macOS

```sh
$ brew install pstree
```

* CentOS

```sh
$ yum install psmisc
```

## 语法

```sh
pstree [-a, --arguments] [-c, --compact] [-h, --high‐light-all, -Hpid, --highlight-pid pid] [-g] --show-pgids] [-l, --long] [-n, --numeric-sort] [-p, --show-pids] [-s, --show-parents] [-u, --uid-changes] [-Z, --security-context] [-A, --ascii, -G, --vt100, -U, --unicode] [pid, user]

pstree -V, --version
```

## 选项

| 选项 | 描述                                               |
| ---- | -------------------------------------------------- |
| `-a` | 显示命令行参数                                     |
| `-s` | 显示进程的父进程；Linux 默认只显示指定进程的子进程 |
| `-p` | 显示进程的 PID                                     |
| `-g` | 显示进程组 ID（即 GPID）                           |

## 示例

* ubuntu desktop 14.04

```sh
$ pstree -asp $$
init,1
  └─lightdm,1616
      └─lightdm,2052 --session-child 12 19
          └─init,206159 --user
              └─gnome-terminal,468355
                  └─bash,478917
                      └─pstree,1031493 -a -s -p 478917
```

* CentOS

```sh
$ pstree -asp $$
systemd,1 --system --deserialize 17
  └─sshd,1594 -D
      └─sshd,3529
          └─bash,3843
              └─pstree,27956 -a -s -p 3843
```

* macOS

```sh
# macOS 的 -p 显示父进程和各个进程的 PID
$ pstree -p $$
-+= 00001 root /sbin/launchd
 \-+= 70324 in /Applications/Utilities/Terminal.app/Contents/MacOS/Terminal
   \-+= 71795 root login -pf in
     \-+= 71796 in -bash
       \-+= 74010 in pstree -p 71796
         \--- 74011 root ps -axwwo user,pid,ppid,pgid,command
```

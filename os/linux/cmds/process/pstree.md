# pstree - 显示进程树

## 安装

* macOS

```sh
$ brew install pstree
```

## 示例

```sh
# macOS
$ pstree -p $$
-+= 00001 root /sbin/launchd
 \-+= 70324 in /Applications/Utilities/Terminal.app/Contents/MacOS/Terminal
   \-+= 71795 root login -pf in
     \-+= 71796 in -bash
       \-+= 74010 in pstree -p 71796
         \--- 74011 root ps -axwwo user,pid,ppid,pgid,command
```
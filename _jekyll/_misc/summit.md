<!--

## 何时 commit

* 如果只有小改动可以不提交，如果要做合并等操作可以先 stash：`git stash save -u "..."`

## 文件模式

Ubuntu 共享访问 macOS 的文件时，Ubuntu 访问到的文件和目录其模式都是 755，而且无法在 Ubuntu 上改变（不影响 macOS 的文件模式），在 Ubuntu 创建文件和目录会导致文件模式更加混乱。

解决办法：

1. 在 macOS 或 Ubuntu 上创建内容（文件或目录）
2. 在 macOS 上统一修改文件和目录的模式
   1. macOS 文件（除目录外）默认模式：644（`find . -type f -exec chmod 644 {} \;`）
   2. macOS 目录默认模式：755（`find . -type d -exec chmod 755 {} \;`）
3. 在 macOS 上提交

## 避免空文件和空目录

```sh
$ find . -empty -type d
$ find . -empty -type f
```

## 删除 .DS_Store 文件

```sh
$ find . -type f -name ".DS_Store" -exec rm {} \;
```

-->

# Git 命令

![Git flow](./images/git-guide.png)

- Workspace：工作区
- Index / Stage：暂存区
- Repository：仓库区（或本地仓库）
- Remote：远程仓库

## Ubuntu 安装 Git
```bash
$ sudo apt-get install git
```

## 初始化一个空的本地仓库
```bash
# 也可以简写成: git init learn-git
$ mkdir learn-git && cd learn-git
$ git init
$ ls -ah
```

## 设置个人账户信息
```bash
# --global 表示所有本地仓库都使用这个用户名和邮箱，也可以针对某个仓库使用不同的用户名和邮箱
$ git config --global user.name "JinsYin"
$ git config --global user.email "jinsyin@gmail.com"
```

## 把工作区文件提交到版本库
```bash
$ echo "Git is a version control system." > README.md
$ git add README.md
$ git commit -m "Create README.md"
```

```bash
# Git 添加文件到仓库需要 add，commit 两步，可以多次 add 不同的文件或目录，commit 可以一次提交很多文件
$ git add file1.txt
$ git add file2.txt file3.txt
$ git add dir1
$ git add dir2 dir3
$ git commit -m "Add three files and one dirctory."
```

```bash
# 也可以不 add，直接 commit 到本地仓库
$ git commit -a -m "msg" # 等价于 git add --all && git commit -m "msg"
```

## 关于 git add
```bash
$ git add -A # 添加所有改动，包括新增、修改和删除；等价于 git add --all。
$ git add *  # 添加所有新增和修改，但不包括删除
$ git add .  # 添加所有新增和修改，但不包括删除
$ git add -u # 添加所有修改和删除，但不包括新增
```

## add 到暂存区后如何撤销？
```bash
$ git reset file1.txt # 撤销某个文件
$ git reset # 撤销所有暂存区的所有文件
```

## commit 到本地仓库后如何撤销
```bash
# 情况1：file1.txt 发生了修改但还没有添加到暂存区，可以直接从本地仓库中撤销
$ git status
$ git checkout -- file1.txt
$ git status
```
```bash
# 情况2：file1.txt 发生了修改并且添加到了暂存区，先从暂存区撤销，再从本地仓库撤销，但不能直接从本地仓库撤销
$ git status
$ git reset file1.txt
$ git checkout -- file1.txt
$ git status
```

## 对比*工作区和暂存区*以及*暂存区和本地仓库*的状态
```bash
# 查看有哪些文件被添加、删除、修改（但不能查看具体修改了什么内容）
$ git status
```

## 对比文本在*工作区*和*暂存区*的变化
```bash
$ git diff # 对比所有文件
$ git diff README.md # 对比某个文件
```

## 查看 commit 日志
```bash
# 第一列为 commit id
$ git log
$ git log --pretty=oneline # 一行显示
```

## 版本回退
```bash
# HEAD 表示当前版本， HEAD^ 表示上一个版本， HEAD^^ 表示上上一个版本， HEAD~100 表示上 100 个版本
$ git reset --hard HEAD^
```

---

> 参考文章 http://www.liaoxuefeng.com/
> 图片来源 http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html


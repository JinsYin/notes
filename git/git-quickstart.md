# Git 命令

![Git Guide](./images/git-guide.png)

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

## 对比*工作区和暂存区*以及*暂存区和本地仓库*的状态
```bash
# 查看有哪些文件被添加、删除、修改（但不能查看具体修改了什么内容）
$ git status
```

## 对比文本在*工作区*和*暂存区*的变化
```bash
$ git diff README.md
```





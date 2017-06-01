# Git 命令

![Git flow](./images/git-guide.png)
> [图片来源](http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html)

- Workspace：工作区
- Index / Stage：暂存区
- Repository：仓库区（或本地仓库）
- Remote：远程仓库

## Ubuntu 安装 Git
```bash
$ sudo apt-get install git
```

---

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

## 把工作区文件提交到本地仓库（当前分支）
![Git add-commit](./images/git-add-commit.jpg)
> [图片来源]( http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013745374151782eb658c5a5ca454eaa451661275886c6000)

暂存区就像是购物车，看到喜欢的商品可以先加入购物车（git add），在没付款前其实你是不确定购物车里的东西都想买，如果不想要了你可以直接删除购物车里的商品（git reset），确定好后再一次性下单（git commit）; 当然，你也可能看到某个喜欢的商品就直接下单了（git commit -a），而不是先加入购物车。

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

## 对比文本在*暂存区*和*本地仓库*的变化
```bash
$ git diff --cached # 对比暂存区所有文件
$ git diff --cached README.md # 对比某个文件
```

## 对比文本在*工作区*和*本地仓库*的变化
```bash
$ HEAD: 版本库里面最新版本
$ git diff HEAD -- README.md
```

## 查看 commit 日志
```bash
# 第一列为 commit id
$ git log
$ git log --pretty=oneline # 一行显示
```

```
# 查看最新的3条 commit 日志
$ git log -3
```

## 版本回退
版本回退是针对`本地仓库`而言的，并不涉及工作区和暂存区的修改。
```bash
# HEAD 表示当前版本， HEAD^ 表示上一个版本， HEAD^^ 表示上上一个版本， HEAD~100 表示上 100 个版本
# 也可以按 commit id 来回退
$ git reset --hard HEAD^
```

## 查看 commit 日志和版本回退日志
```bash
# 如果版本回退之后又想回到未来，可以用该命令获取回退前的 commit id
$ git reflog
```

---

## 自定义 Git

### .gitigonre 忽略特殊文件
> .gitignore 模板 [github/gitignore](https://github.com/github/gitignore)  
> .gitignore 自动生成网站 [gitignore.io](https://www.gitignore.io)

### 配置别名
```bash
$ git config --global alias.st status
$ git config --global alias.co checkout
$ git config --global alias.ci commit
$ git config --global alias.br branch
```

```
# 命令 git reset HEAD file 可以把暂存区的修改撤销掉（unstage），重新放回工作区
$ git config --global alias.unstage 'reset HEAD'
$ git unstage test.py
```

```bash
# 跟踪 commit、合并日志
$ git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
$ git lg -5
```

```bash
# 查看本地仓库配置
$ cat .git/config
```

```bash
# 查看当前用户配置（--global），注： system 是整台电脑，global 是当前用户
$ cat ~/.gitconfig
```

## 搭建 Git 服务器
[Docker Gitlab image](https://hub.docker.com/r/gitlab/gitlab-ce/)

---

## 参考文章 
> [廖雪峰的Git教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)


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
$ ls -alh
```

## 设置个人账户信息
```bash
# --global 表示所有本地仓库都使用这个用户名和邮箱，也可以针对某个仓库使用不同的用户名和邮箱
$ git config --global user.name "JinsYin"
$ git config --global user.email "jinsyin@gmail.com"
```

## 把工作区文件提交到本地仓库（当前分支）
HEAD 指向当前分支的最新版本  
![ *-commit](./images/git-add-commit.jpg)
> [图片来源]( http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013745374151782eb658c5a5ca454eaa451661275886c6000)

暂存区就像是购物车，看到喜欢的商品可以先加入购物车（git add），在没付款前其实你是不确定购物车里的东西都想买，如果不想要了你可以直接删除购物车里的商品（git reset），确定好后再一次性下单（git commit）; 当然，你也可能看到某个喜欢的商品就直接下单了（git commit -a），而不是先加入购物车。

```bash
$ echo "Git is a version control system." > README.md
$ git add README.md
$ git commit -m "Create README.md"
```

```bash
# Git 添加文件到仓库需要 add，commit 两步，可以多次 add 不同的文件或目录，commit 可以一次提交很多文件
$ git add f1.md
$ git add f2.md f3.md
$ git add dir1
$ git add dir2 dir3
$ git commit -m "Add three files and one dirctory."
```

```bash
# 也可以不 add，直接 commit 到本地仓库
$ git commit -a -m "msg" # 等价于 git add * && git commit -m "msg" （并不会添加隐藏文件）
```

## 关于 git add
```bash
$ git add -A # 添加所有改动，包括所有新增、修改和删除；等价于 git add --all
$ git add .  # 添加所有新增和修改，但不包括删除 （会添加隐藏文件）
$ git add *  # 添加所有新增和修改，但不包括删除 （不会添加隐藏文件，不建议使用）
$ git add -u # 添加所有修改和删除，但不包括新增
```

## 撤销（unstage）暂存区的修改？
撤销暂存区的修改之后，暂存区默认会回到最近一次 commit 的状态
```bash
$ git reset HEAD f1.md # 可以简写成 git reset f1.md 
$ git reset # 撤销所有暂存区的所有文件追踪
```

## add 到暂存区后如何删除？
删除暂存区中文件相当于从购物车中删除添加的商品

```bash
# 同时删除工作区和暂存区中的 f1.md
$ git rm -f f1.md # 等价于 rm -f f1.md && git rm --cached f1.md
```

```bash
# 仅删除暂存区中的 f1.md，而工作区中的 f1.md 会继续保留
# 如果删除前工作区中的 f1.md 还作了修改，则需要先丢弃工作区的修改 git checkout -- f1.md
$ git rm --cached f1.md
```
  
如果删错了可以再丢弃工作区的修改（git checkout -- f1.md）。

## 丢弃（discard）工作区的修改
工作区的文件发生修改后，要么`添加`（git add f1.md）到暂存区，要么`丢弃`（git checkout -- f1.md）工作区的修改。  

情况1：f1.md 作了修改但还没有添加到暂存区，撤销修改会回到和本地仓库一模一样的状态（前提是至少 commit 过一次）  
情况2：f1.md 作了第一次修改后添加到了暂存区，之后又作了第二次修改，撤销修改会添加到暂存区时的状态。如果想回到本地仓库一样的状态可以先丢弃暂存区的修改（git rm --cached f1.md），然后再撤销。  
  
总之，撤销工作区的修改会回到最近近一次　`git commit`　或　`git add`　时的状态

```bash
$ git status
$ git checkout -- f1.md
$ git status
```

## 查看`工作区`以及`暂存区`的状态
```bash
# 查看有哪些文件被添加、删除、修改（但不能查看具体修改了什么内容）
$ git status
```

## 查看文本在`工作区`和`暂存区`的 difference
```bash
$ git diff # 对比所有文件
$ git diff README.md # 对比某个文件
```

## 查看文本在`暂存区`和`本地仓库`的 difference
```bash
$ git diff --cached # 对比暂存区所有文件
$ git diff --cached README.md # 对比某个文件
```

## 查看文本在`工作区`和`本地仓库`的 difference
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
HEAD 指向的是当前分支的最新版本，HEAD^ 指向的是当前分支的上一个版本，HEAD~10 指向的是当前分支的上 100 个版本。
```bash
# 也可以按 commit id 来回退版本
$ git reset --hard HEAD^
```

## 查看 commit 日志和版本回退日志
如果版本回退之后又想回到未来，可以用该命令获取回退前的 commit id。
```bash
$ git reflog
```

## 远程仓库


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


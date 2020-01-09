# Hugo 快速入门

## 安装 Hugo

* macOS

```sh
$ brew install hugo

# 验证
$ hugo version
Hugo Static Site Generator v0.55.6/extended darwin/amd64 BuildDate: unknown
```

## 新建站点

```sh
$ hugo new site weplay.me
Congratulations! Your new Hugo site is created in /Users/in/git/weplay.me.
...
```

```sh
# 目录结构
$ cd weplay.me && tree
.
├── archetypes      # 内容模板；新建文章时使用的模板
│   └── default.md
├── config.toml     # 配置文件（博客地址、构建配置、标题、导航栏等）
├── content         # 博客目录
├── data
├── layouts         # 存放布局内容
├── static          # 存放静态资源
└── themes          # 主题目录
```

## 安装主题

```sh
# 利用 Git 来管理项目
$ cd weplay.me && git init

# or: git clone https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
$ git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
```

```sh
# 配置选用的主题
$ echo 'theme = "ananke"' >> config.toml
```

## 创建文章

```sh
$ cd weplay.me

# 新建的文章位于 content/ 目录下，默认是 draft 页面
$ hugo new post/hello-world.md
/Users/in/git/weplay.me/content/post/hello-world.md created
```

```md
$ cat content/post/hello-world.md
---
title: "Hello World"
date: 2019-07-08T19:54:25+08:00
draft: true # 完成文章后，设置为 false，或者删除这行
---

我的博客
```

## 本地运行

```sh
# -D: draft，即发布文章属性为 `draft: true` 的文章
$ hugo server
```

浏览器访问该站点：<http://127.0.0.1:1313>。

## 构建静态页面

```sh
# 构建静态页面，位于 public/ 目录
$ hugo

                   | EN
+------------------+-----+
  Pages            |  19
  Paginator pages  |   0
  Non-page files   |   1
  Static files     | 184
  Processed images |   0
  Aliases          |   6
  Sitemaps         |   1
  Cleaned          |   0

```

## 发布

```sh
# 推送到 Github Pages
$ git remote add origin https://github.com/jinsyin/jinsyin.github.io.git
$ git add --all
$ git commit -m "weplay.me"
$ git push origin master:master
```

## 参考

* [Hugo Quick Start](https://gohugo.io/getting-started/quick-start/)

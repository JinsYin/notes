# 快速入门


## 安装

* macOS

```sh
$ brew install hugo

$ hugo version
Hugo Static Site Generator v0.55.6/extended darwin/amd64 BuildDate: unknown
```

## 创建网站

搭建 Github Pages 网站（`username.github.io`）：

```sh
$ hugo new site jinsyin.github.io

# 建议使用 git 来管理
$ cd jinsyin.github.io && git init
```

### 目录结构

```sh
$ cd jinsyin.github.io && tree
.
├── archetypes      # 存放原型
│   └── default.md
├── config.toml     # 配置文件（博客地址、构建配置、标题、导航栏等）
├── content         # 博客目录
├── data
├── layouts         # 存放布局内容
├── static          # 存放静态资源
└── themes          # 主题目录
```

### 创建博客

```sh
$ cd jinsyin.github.io

$ hugo new post/hello-world.md
/Users/in/git/jinsyin.github.io/content/post/hello-world.md created
```

```toml
$ cat content/post/hello-world.md
---
title: "Hello World"
date: 2019-07-08T19:54:25+08:00
draft: true # false 才会真正发布
---
# Hello, World

文章内容
```

两个 `---` 包含的是 TOML 配置信息，叫作扉页（front matter），默认为以上 3 项，也可以自定义。

```toml

```

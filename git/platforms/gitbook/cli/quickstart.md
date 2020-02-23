# 快速入门

## 本地安装

* 安装要求

    1. Node.js 版本在 v4.0.0 及以上
    2. Windows, Linux, Unix, or Mac OS X

* 安装 nodejs 和 npm

```sh
# Ubuntu
$ curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
$ sudo apt-get install -y nodejs

$ node --version
v8.11.1

$ npm --version
5.6.0
```

* 安装 GitBook

```sh
$ npm install gitbook-cli -g
```

`gitbook-cli` 工具用于在同一系统上安装和使用多个版本的 GitBook。它会自动安装所需版本的 GitBook 来构建一本书。

* 创建一本书

```sh
# 在当前目录下初始化 GitBook 项目
$ gitbook init # other: gitbook init ./directory

# 本地预览
$ gitbook serve # other: gitbook serve ./directory

# 构建静态站点，生成的静态站点可直接托管搭载 Github Pages 服务上
$ gitbook build # other: gitbook build ./directory --output=./outputFolder
```

## 项目结构

```sh
$ gitbook init
$ tree .
.
├── README.md
└── SUMMARY.md
```

`README.md` 和 `SUMMARY.md` 是 GitBook 项目必须包含的两个文件。其中，`README.md` 相当于一本书的简介，而 `SUMMAY` 则用于描述书的目录结构。

## 参考

* [Setup and Installation of GitBook](https://github.com/GitbookIO/gitbook/blob/master/docs/setup.md)
* [Installing Node.js via package manager](https://nodejs.org/en/download/package-manager)
* [gitbook 入门教程之使用 gitbook.com 在线开发电子书](https://www.cnblogs.com/snowdreams1006/p/10657647.html)

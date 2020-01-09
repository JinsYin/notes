# Hugo 主题

[themes.gohugo.io](https://themes.gohugo.io) 提供了大量 Hugo 主题。

## 主题

* [slate](https://themes.gohugo.io/theme/slate)
* [Appyness](https://themes.gohugo.io/theme/hugo-appyness/)
* [material-design](https://themes.gohugo.io//theme/material-design/)
* [kross](https://themes.gohugo.io//theme/kross-hugo-portfolio-template/)
* [cleanwhite](https://themes.gohugo.io/theme/hugo-theme-cleanwhite/)
* [type](https://themes.gohugo.io//theme/type/)
* [Changelog](https://themes.gohugo.io/theme/hugo-changelog-theme/)

* <https://blog.cofess.com/>
* <http://www.andus.top/>
* <https://zhwangart.github.io/>
* <https://themes.gohugo.io//theme/slick/post/>
* <https://github.com/MeiK2333/github-style>

## 下载

* 使用 `git clone` 克隆到 themes 目录，优点是可以根据需求进行调整并同时提交到 git 仓库

```sh
$ git clone https://github.com/olOwOlo/hugo-theme-even themes/even
```

* 使用 `git submodule` 关联主题，优点是便于 travis 等 CI 自动部署（如果想要修改可以 fork 一份）

## 定制主题

```sh
$ hugo new theme <themename>
```

```sh
$ tree
.
├── archetypes
│   └── default.md
├── config.toml
├── content
├── data
├── layouts
├── resources
│   └── _gen # NEW!
│       ├── assets
│       └── images
├── static
└── themes
    └── yxq # NEW!
        ├── LICENSE
        ├── archetypes
        │   └── default.md
        ├── layouts
        │   ├── 404.html
        │   ├── _default
        │   │   ├── baseof.html
        │   │   ├── list.html
        │   │   └── single.html
        │   ├── index.html
        │   └── partials
        │       ├── footer.html
        │       ├── head.html
        │       └── header.html
        ├── static
        │   ├── css
        │   └── js
        └── theme.toml
```

## 参考

* [Hugo Themes](https://themes.gohugo.io/)

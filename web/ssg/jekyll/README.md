# Jekyll

模板引擎：`Liquid`

每篇文章的头部，必须有一个 yaml 文件头，以设置一些元数据。

## 文件类型

Jekyll 文件（`site.each_site_file`）分为以下几类：

* 集合文档（`site.collections[name].documents`）
  * 包括集合中的 markdown/html 文件（亦称之为集合文档 `collection.docs`）和集合静态文件（`collection.files`）
  * 除默认集合 `posts`、`drafts` 以外，集合必须在 `_config.yml` 中事先定义
  * 集合目录名称以 `_` 开头
* 页面（`site.pages`）
  * 除集合外，文件头部信息带有 Front Matter 的文件的集合
  * 页面目录可以是根目录，也可以自定义，但目录名称不能以 `_`、`.` 等特殊字符开头
* 静态文件（`site.static_files`）
  * 文件头部信息没有 Front Matter 的文件的集合
  * 目录名称不能以 `_`、`.` 等特殊字符开头

### 集合文档（Jekyll:Document）

| 文档属性     | 描述                    |
| ------------ | ----------------------- |
| `path`       |                         |
| `site`       | `Jekyll::Site` 类的实例 |
| `extname`    |                         |
| `collection` |                         |
| `type`       |                         |
| `content`    |                         |
| `output`     |                         |

### 页面（Jekyll::Page）

| 页面属性   | 是否可以用于 Liquid 模板 | 描述              |
| ---------- | ------------------------ | ----------------- |
| `content`  | Yes                      | 文件原始内容      |
| `dir`      | Yes                      |                   |
| `name`     | Yes                      |                   |
| `path`     | Yes                      |                   |
| `url`      | Yes                      |                   |
| `site`     | No                       |                   |
| `pager`    | No                       |                   |
| `ext`      | No                       |                   |
| `basename` | No                       |                   |
| `data`     | No                       | front matter 数据 |
| `output`   | No                       | 文件渲染后的内容  |

注：所有属性都可以用于 permalink 设置

### 静态文件（Jekyll::StaticFile）

| 静态文件属性    | 描述 |
| --------------- | ---- |
| `relative_path` |      |
| `extname`       |      |
| `name`          |      |
| `data`          |      |

例如，如果要将 Jekyll::StaticFile 转换为 Jekyll:Page，必须增加缺省的属性（至少需要用的的属性必须增加）

## categories & tags

当为 **集合**（其他文档不行）指定 `categories` 和 `tags` 时，如果值只有一项，可以采用单数形式（即 `category: value` 和 `tag: value`，而不是常见的 `categories: []` 和 `tag: []` 形式），减少了通过 `first` 等 filters 获取第一个元素，并且都可以通过 `site.categories` 和 `site.tags` 获取到相应的文档。

> categories 和 tags 仅对 “posts” 集合有效，换句话说，只有对 “posts” 集合中的文档指定 categories 和 tags，采用通过 site.categories 和 site.tags 获取的相应的文档，而其他文档仅仅是增加了一个 Front Matter
> 分页也仅对 “posts” 集合有效

两者都区分大小写，也就是说 `foo` 不同于 `Foo`。

## 参考

* [Jekyll cheatsheet](https://devhints.io/jekyll)
* [Jekyll for GitHub pages cheatsheet](https://devhints.io/jekyll-github)
* [github.com/barryclark/jekyll-now](https://github.com/barryclark/jekyll-now)
* [Compress HTML in Jekyll](http://jch.penibelst.de/)

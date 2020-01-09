# Front Matter

Front Matter 是 YAML 的片段，位于文件顶部两条 `---` 之间，用于设置页面（`page`）的变量。

```html
---
title: Home
---
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>{{ page.title }}</title>
  </head>
  <body>
    <h1>{{ "Hello World!" | downcase }}</h1>
  </body>
</html>
```

## 默认值

```yml
defaults:
  -
    scope:
      path: "" # 空字符串代表所有文件
    values:
      layout: "default"
```

```yml
defaults:
  - scope:
      path: "" # 指定 scope/values 的键值对时必须指定 path 值，如果是所有文件可以指定为 `""`
      type: "pages" # path 范围下的文档类型（可选），可以是集合名称（posts、drafts 及自定义集合）、pages；如果不写，表示该路径下的所有文档类型
    values:
      layout: "default" # Front Matter 值
```

## 意义

在文件的开头指定 Front Matter （至少两条 `---`），Jekyll 在构建时会：

* 将 Markdown 文件转换成 HTML 文件
  * 并不是直接改变文件后缀，而是 `x.md` -> x/index.html；如果是 `README.md`/`index.md` -> `index.html`
  * 可以指定 `permalink` 来改变构建后的路径
  * 即使 Markdown 没有使用布局，Jekyll 依然会转换成有个一些 HTML 标签的 HTML 页面，而不是仅仅是纯文本
* 将 SCSS 文件转换成 CSS 文件；直接改变文件后缀，文件路径、名称不变

如果没有指定 Front Matter，将原样拷贝到 `_site` 目录。

## 参考

* [Jekyll - Front Matter](https://jekyllrb.com/docs/front-matter/)

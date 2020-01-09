# Liquid 模板引擎

## 数据模型

```html
<!-- HTML Title -->
{{ page.title }}

<!-- 列出所有文章 -->
<ul>
    {% for post in site.posts %}
    <li>{{ post.date | date_to_string }} <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
</ul>
```

## 对象

URL（`/docs/x/y/z`）:

| 对象                     | 值            |
| ------------------------ | ------------- |
| `{{ first_level_url }}`  | `/docs/x/`    |
| `{{ second_level_url }}` | `/docs/x/y/`  |
| `{{ url }}`              | `/docs/x/y/z` |

### page 对象

```md
---
title: hello
---
# HELLO
```

```json
{"title"=>"hello", "content"=>"# HELLO\n{{ page }}\n", "dir"=>"/docs/utilities/color/", "name"=>"color.md", "path"=>"docs/utilities/color.md", "url"=>"/docs/utilities/color/"}
```

| `page` 对象的参数 | 内置参数？ | 描述                             |
| ----------------- | ---------- | -------------------------------- |
| `url`             | Yes        |                                  |
| `path`            | Yes        |                                  |
| `dir`             | Yes        |                                  |
| `name`            | Yes        |                                  |
| `content`         | Yes        |                                  |
| `title`           | No         | Front Matter 中定义的 title 属性 |

### site 对象

| 内置属性            | 描述 |
| ------------------- | ---- |
| `site.pages`        |      |
| `site.html_pages`   |      |
| `site.lang`         |      |
| `site.plugins`      |      |
| `site.plugins.xxx`  |      |
| `site.time`         |      |
| `site.collections`  |      |
| `site.defaults`     |      |
| `site.markdown`     |      |
| `site.sass`         |      |
| `site.branch`       |      |
| `site.exclude`      |      |
| `site.permalink`    |      |
| `site.static_files` |      |
| `site.time`         |      |
| `site.categories`   |      |
| `site.tag`          |      |

### content 对象

## 数组

Liquid 对数组的支持极不友好。

声明一个数组：

```liquid
{% assign array = "" | split: "" %}
```

使用 Jekyll 定义的 `push` 过滤器向数组中添加元素。

```jekyll
{% assign array = array | push: tag %}
```

## Map

Liquid 没有提供 Map 的支持，导致很难做一些统计词频的工作。

## 参考

* [Liquid](https://shopify.github.io/liquid/)

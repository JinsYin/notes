# highlight 语法高亮

Rouge 是 Jekyll 的默认语法高亮器，而 Rouge 是为兼容 Pygments 而设计的，不过支持的语言并不多。

## 语法高亮样式表

目的：对默认的语法高亮样式表不满意，想自定义语法高亮的样式表。

* [Pygments CSS Themes](https://jwarby.github.io/jekyll-pygments-themes/languages/ruby.html)
* [jekyll-pygments-themes](https://github.com/jwarby/jekyll-pygments-themes)

## 使用 highlight.js

highlight.js 完全兼容 Rouge 和 Pygments，不需要做任何修改，仅仅添加一段 css 和 js 即可。

```html
 <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/styles/default.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/highlight.min.js"></script>
<script type="text/javascript">hljs.initHighlightingOnLoad();</script>
```

## 使用 prismjs

* <https://prismjs.com/>

## 参考

* [Code snippet highlightingPermalink](https://jekyllrb.com/docs/liquid/tags/#code-snippet-highlighting)
* [Rouge - List of supported languages and lexers](https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers)
* [Rouge](https://github.com/rouge-ruby/rouge)
* [Jekyll 中用 Highlight.js](http://ju.outofmemory.cn/entry/149452)
* [Jekyll 代码高亮的几种选择](https://blog.csdn.net/qiujuer/article/details/50419279)
* [使用 prismjs 实现 Jekyll 代码语法高亮并显示行号](https://blog.csdn.net/u013961139/article/details/78853544)

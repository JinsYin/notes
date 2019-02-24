# 数学公式支持

$$E = mc^{2}$$

## 网页 JS 支持

* [MathJax](https://github.com/mathjax/mathjax)

## GitHub 支持

## VS code 支持

利用 [mdmath](https://github.com/goessner/mdmath) 插件可以在 VS Code 中排版和渲染 TeX 数学公式。

支持的分隔符：

* `'dollars'` (default)
  * inline: `$...$`
  * display: `$$...$$`
  * display + equation number: `$$...$$ (1)`
* `'brackets'`
  * inline: `\(...\)`
  * display: `\[...\]`
  * display + equation number: `\[...\] (1)`
* `'gitlab'`
  * inline: ``$`...`$``
  * display: `` ```math ... ``` ``
  * display + equation number: `` ```math ... ``` (1)``
* `'kramdown'`
  * inline: ``$$...$$``
  * display: `$$...$$`
  * display + equation number: `$$...$$ (1)`

## 参考

* [如何在 markdown 中插入数学公式](http://mashangxue123.com/markdown/902675789.html)
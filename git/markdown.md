# Markdown 笔记

## 标题（Headers）
```
# This is an <h1> tag
## This is an <h2> tag
###### This is an <h6> tag
```

# This is an \<h1\> tag
## This is an \<h2\> tag
###### This is an \<h6\> tag

---

## 强调（Emphasis）
```
*This text will be bold*
**This text will be bold**
```

*This text will be bold*  
**This text will be bold**

---

## 无序列表
```
* Item 1
* Item 2
  * Item 2a
  * Item 2b
```

* Item 1
* Item 2
  * Item 2a
  * Item 2b
  
---

## 有序列表
1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b
   
---

## 图片

```
Format: ![Alt Text](url)
![Avatar](https://avatars2.githubusercontent.com/u/12714609?v=3&s=40)
```

![Avatar](https://avatars2.githubusercontent.com/u/12714609?v=3&s=40)

---

## 超链接（Links）
```
http://github.com - automatic!
[GitHub](http://github.com)
```

http://github.com - automatic!  
[GitHub](http://github.com)

---

## 引用（Blockquotes）
```
As Kanye West said:
> We're living the future so
> the present is our past.
```

As Kanye West said:
> We're living the future so
> the present is our past.

---

## 内联代码（Inline code）
```
I think you should use an
`<addr>` element here instead.
```

I think you should use an
`<addr>` element here instead.

---

## 语法高亮
`````
```js
function getName() {
  return 0;
}
```
`````

```js
function getName() {
  return 0;
}
```

---

## 对比修改
`````
```diff
- google
+ google.com
```
`````

```diff
- google
+ google.com
```

---

## 任务列表（Task Lists）
```
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item
```

- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item

---

## 表格
`````
name | age | school
---- | --- | ----
jins | 24  | shsmu
peter| 20  | tsinghua
`````

name | age | school
---- | --- | ----
jins | 24  | shsmu
peter| 20  | tsinghua

---

## 引入问题（Issue references）
```
#1  
mojombo#1  
mojombo/github-flavored-markdown#1
```

#1  
mojombo#1  
mojombo/github-flavored-markdown#1

---

## 删除线（Strikethrough）
```
~~del~~
```

~~del~~

---


## 分割线
```
---
```

---

## Emoji
使用方法：　`:EMOJICODE:`， emoji code：　[emoji-cheat-sheet.com](https://www.webpagefx.com/tools/emoji-cheat-sheet/)
```
:+1:
:smile:
:clap:
:v:
:hankey:
```

:+1:
:smile:
:clap:
:v:
:hankey:

---

## 换行
编辑纯文本时， markdown 键入 Enter 默认是不会自动换行，需要使用两个英文半角空格 + Enter。
```
# a 后面没有空格，b 后面有一个空格，Peter 后面有两个空格）
a
b 
Peter  
Jins
```

a
b
Peter  
Jins

---

## Pandoc

pandoc 可以使文件在`markdown`、`html`、`pdf`、`doc`、`docx`等格式之间相互转换。

安装 pandoc
```bash
$ sudo apt-get install pandoc
```

如果 apt-get 安装的 pandoc 功能不齐全，可以如官网上一样先安装 cable,再安装 pandoc
```bash
$ sudo apt-get install cabal-install
$ cabal update
$ cabal install pandoc
```

为了支持 pdf，需要安装 LaTeX
```bash
$ sudo apt-get install texlive-latex-base
$ sudo apt-get install texlive
```

从 markdown 转为 html
```bash
$ pandoc test1.md -f markdown -t html -s -o test1.html
```

创建 LaTeX 文档
```bash
$ pandoc test1.md -f markdown -t latex -s -o test1.tex
$ pandoc test1.md -s -o test1.pdf
```

## 参考文章
> https://guides.github.com/features/mastering-markdown/

# Markdown 语法

---

## 标题（Header）

语法：

```markdown
# This is an <h1> tag
## This is an <h2> tag
###### This is an <h6> tag
```

渲染：

# This is an \<h1\> tag
## This is an \<h2\> tag
###### This is an \<h6\> tag

---

## 强调（Emphasis）

语法：

```markdown
*This text will be italic*
**This text will be bold**
```

渲染：

*This text will be italic*
**This text will be bold**

---

## 无序列表（Unordered List）

语法：

```markdown
* Item 1
* Item 2
  * Item 2a
  * Item 2b
```

渲染：

* Item 1
* Item 2
  * Item 2a
  * Item 2b

---

## 有序列表（Ordered List）

语法（序号全是 `1` 即可，二级菜单前是 `3` 个空格）：

```markdown
1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b
```

渲染：

1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b

---

## 图片（Image）

```markdown
![Avatar](https://avatars2.githubusercontent.com/u/12714609?v=3&s=40)
```

![Avatar](https://avatars2.githubusercontent.com/u/12714609?v=3&s=40)

---

## 超链接（Link）

语法：

```markdown
<http://github.com> - [GitHub](http://github.com)
```

渲染：

<http://github.com> - [GitHub](http://github.com)

---

## 引用（Blockquote）

```markdown
As Kanye West said:
> We're living the future so
> the present is our past.
```

As Kanye West said:
> We're living the future so
> the present is our past.

---

## 内联代码（Inline code）

语法：

```markdown
I think you should use an
`<addr>` element here instead.
```

渲染：

I think you should use an
`<addr>` element here instead.

---

## 语法高亮（Syntax highlighting）

语法：

``````markdown
```js
function getName() {
  return 0;
}
```
``````

渲染：

```js
function getName() {
  return 0;
}
```

---

## 对比修改

语法：

``````markdown
```diff
- google
+ google.com
```
``````

渲染：

```diff
- google
+ google.com
```

---

## 任务列表（Task List）

语法：

```markdown
* [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
* [x] list syntax required (any unordered or ordered list supported)
* [x] this is a complete item
* [ ] this is an incomplete item
```

渲染：

* [x] @mentions, #refs, [links](http://google.com), **formatting**, and <del>tags</del> supported
* [x] list syntax required (any unordered or ordered list supported)
* [x] this is a complete item
* [ ] this is an incomplete item

---

## 表格（Table）

语法：

```markdown
| name  | age | school   |
| ----- | --- | -------- |
| alice | 24  | shsmu    |
| peter | 20  | tsinghua |
```

渲染：

| name  | age | school   |
| ----- | --- | -------- |
| alice | 24  | shsmu    |
| peter | 20  | tsinghua |

ASCII 表格：<https://ozh.github.io/ascii-tables/>

---

## 引入问题（Issue reference）

语法：

```markdown
#1
mojombo#1
mojombo/github-flavored-markdown#1
```

---

## 删除线（Strikethrough）

语法：

```markdown
~~del~~
```

渲染：

~~del~~

---

## 分割线

语法：

```markdown
---
```

---

## Emoji

使用方法： `:EMOJICODE:`， emoji code： [emoji-cheat-sheet.com](https://www.webpagefx.com/tools/emoji-cheat-sheet/)

```markdown
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

## 注释

使用 `<!-- -->` 来进行注释，注释后文本内容将不会显示。

语法：

```markdown
<!-- 注释内容 -->
```

---

## 换行

编辑纯文本时， markdown 键入 Enter 默认是不会自动换行，需要使用两个英文半角空格 + Enter。

语法：

```markdown
<!-- a 后面没有空格，b 后面有一个空格，Peter 后面有两个空格） -->
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
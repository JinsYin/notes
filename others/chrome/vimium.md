# Vimium 使用指南

Vimium 是 Chrome、Chromium 的一个插件，可以像 vim 一样操作浏览器，从而脱离鼠标。


## 快捷键

* 当前页操作

```
?   查看帮助；相当于 shift + /
h   向左滚动（同 “Left”）
j   向下滚动（同 “Up”）
k   向上滚动（同 “Down”）
l   向右滚动（同 “Right”）
gg  滚动到当前页的顶部（同 “Home”）
G   滚动到当前页的底部（同 “End”）；相当于 shift + g
d   向下滚动半页（同 “Pg Dn”）
u   向上滚动半页（同 “Pg Up”）
f   在当前 Tab 打开一个链接
F   当新的 Tab 打开一个链接，相当于 shift + f
r   刷新当前页面
gs  查看源码
i   进入插入模式，其他命令将被忽视，按 Esc 取消
yy  复制当前页面的 URL
yf  复制当前页面中的一个链接
p   在当前 tab 打开复制的 URL
P   在新的 tab 打开复制的 URL
```

* 新页面操作

```
o   在当前页面打开 URL、书签、历史记录
O   在新的页面打开 URL、书签、历史记录；相当于 shift + o
b   在当前页面打开书签（bookmark）
B   在新的页面打开书签（bookmark）；相当于 shift + b
```

* 查找

```
/   进入查找模式（回车 -> 搜索，ESC -> 取消）
n   进入查询模式后，循环向下匹配
N   进入查询模式后，循环向上匹配；相当于 shift + n
```

* 前进、回退

```
H   回退；相当于 shift + h
L   前进；相当于 shift + h
```

* Tab 操作

```
g0  切换到第一个 tab
g$  切换到最后一个 tab
J   向左切换 tab；相当于 shift + j
K   向右切换 tab；相当于 shift + k
^   进入上一个访问的 tab
t   打开一个新的 tab；相当于 Ctrl + t
yt  复制当前 tab
x   关闭当前 tab；相当于 Ctrl + w
X   恢复关闭的 tab；相当于 shift + x，相当于 Ctrl + Shift + t
T   在已打开的 tab 中搜索 tab，用于切换到相应的 tab
<a-p>   Alt + p，pin/unpin 当前 tab
```

* 高级浏览命令

```
[[  进入上一页（部分网站支持，如百度）
]]  进入下一页（部分网站支持，如百度）
<<  左移当前 tab
>>  右移当前 tab
gi  光标聚焦到第一个文本输入框（在搜索的时候非常有用）
gu  跳转到父页面，如 github.com/a/b --> github.com/a
gU  跳转到跟页面，如 github.com/a/b --> github.com
ge  编辑当前 URL，并在当前 tab 中打开
gE  编辑当前 URL，并在新的 tab 中打开
v   进入可视化模式，并结合 h、j、k、l 往不同的方向选中；使用 p/P 粘贴并搜索，使用 y 复制，使用 Esc 取消
V   进入可视化行模式；相当于 shift + v
```


## 参考

* [Vimium - The Hacker's Browser](https://github.com/philc/vimium/)

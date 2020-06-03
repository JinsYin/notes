# 清除浮动

```html
<div class="clearfix">
  <img
    style="float: right;"
    src="path/to/floated-element.png"
    width="500"
    height="500"
  >
  <p>Your content here…</p>
</div>
```

方法一：

```css
.clearfix {
    overflow: auto;
    zoom: 1; /* IE6 */
}
```

方法二：

```css
.clearfix::after {
  content: "";
  display: block;
  clear: both;
}
```

> <https://stackoverflow.com/questions/211383/what-methods-of-clearfix-can-i-use>

# jekyll-redirect-from

## 安装

## 使用

`/contribute/` -> `/community/`

```html
<!-- community.html -->
---
redirect_from:
  - /contribute/
---
```

此外，通过 `site.pages` 可以看到一个 `redirect.html` 和 `redirects.json`。

`redirects.json`：

```json
{"/contribute/":"/community/"}
```

## 参考

* [https://github.com/jekyll/jekyll-redirect-from](https://github.com/jekyll/jekyll-redirect-from)

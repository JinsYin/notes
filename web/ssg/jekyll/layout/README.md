# 布局

Jekyll 支持使用 Markdown 和 HTML 来创建页面，如果使用 Markdown 必须在文件顶部添加 Front Matter（可以为空，即两条 `---`），否则将不会被构建成静态页面，如果是 HTML 则可有可无。当同一目录同时存在名称相同的 Markdown 和 HTML 时（如 `index.md` 和 `index.html`），优先采用 HTML 。

所有页面（page）默认布局的优先级顺序：

* `page.html`
* `default.html`

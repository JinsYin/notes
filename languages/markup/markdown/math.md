# 数学公式支持

$$E = mc^{2}$$

## 网页 JS 支持

* [MathJax](https://github.com/mathjax/mathjax)

## GitHub 支持

* Chrome 支持

利用 [MathJax Plugin for Github](https://github.com/orsharir/github-mathjax) Chrome 插件可以在 GitHub 中排版和渲染 LaTex 数学公式。遗憾的是，在 Linux 下的 [Chrome Web Store](https://chrome.google.com/webstore/detail/mathjax-plugin-for-github/ioemnmodlmafdkllaclgeombjnmnbima) 安装会失败，需要手动安装。

1. `git clone https://github.com/orsharir/github-mathjax.git`
2. 进入 `chrome://extensions` 插件管理页，打开 **Developer Mode**
3. 点击 `Load unpacked` 按钮，选择克隆的仓库完成安装
4. 在 Github 中打开包含 LaTeX 数学公式的代码仓库加以验证
5. 参考：<https://github.com/orsharir/github-mathjax/issues/24#issuecomment-438140315>
6. 该插件不支持 **\`\`\`math ... \`\`\`** 形式来书写数学公式，所以建议使用 **\$\$ ... \$\$**

* Firefox 支持

按照 [github-mathjax-firefox](https://github.com/traversaro/github-mathjax-firefox) 项目中的提示，在 firefox 浏览器中下载 xpi 插件安装即可。

## VS code 支持

利用 [mdmath](https://github.com/goessner/mdmath) 插件可以在 VS Code 中排版和渲染 TeX 数学公式。

### 支持的分隔符

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

### 修改默认的用户设置

```json
{ "mdmath.delimiters": "gitlab" }
```

## 参考

* [如何在 markdown 中插入数学公式](http://mashangxue123.com/markdown/902675789.html)

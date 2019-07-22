# Github Pages

利用 Github Pages 提供的网站功能，每个 Github 账号和组织可以创建 **一个** 网站，以及 **无数个** 项目网站。

## 个人或组织站点（限一个）

**1**. 创建一个名为 `username.github.io` 的代码仓库（`username` 必须是自己的用户名或组织名）

**2**. 克隆代码仓库

```bash
$ git clone https://github.com/username/username.github.io
```

**3**. Hello World

```bash
$ cd username.github.io
$ echo "Hello, world" > index.html
```

**4**. Push 到 Github

```bash
$ git add --all
$ git commit -m "试一试 Github Pages"
$ git push -u origin master
```

**5**. 浏览器访问 <https://username.github.io>

## 项目站点（无数个）

### 设置网站源

主分支作为源：

0. 检查 commit：<https://github.com/USERNAME/REPO/commits/master>
1. 在项目根目录创建 `index.html` 或 `index.md` 或 `README.md` 文件（优先级从左往右递减）并添加一些内容
2. 到项目页面中点击 `Settings` 选项并滚动到 `GitHub Pages` 区域，选择 `master branch` 作为源
3. 浏览器访问 <http://username.github.io/my-project>
4. 如果网站不能访问说明构建出错，需要回到 `Settings > GitHub Pages` 查看具体的错误提示；意味着可以利用 Github Pages 功能来检查项目的某些问题

子目录作为源：

1. 在项目子目录 **/docs** 下创建 `index.html` 或 `index.md` 文件并添加一些内容
2. 到项目页面中点击 `Settings` 选项并滚动到 `GitHub Pages` 区域，选择 `master branch /docs folder` 作为源
3. 浏览器访问 <http://username.github.io/my-project>
4. 如果网站不能访问说明构建出错，需要回到 `Settings > GitHub Pages` 查看具体的错误提示；意味着可以利用 Github Pages 功能来检查项目的某些问题

### 设置网站主题（限 Jekyll 静态网站生成器）

注意：由于 Github 的主题是针对 Jekyll 框架的，所以只有 `index.md` 和 `README.md` 才会自动应用主题，而 `index.html` 并不会（`pages.github.com` 的介绍有误导）

1. 到项目页面中点击 `Settings` 选项并滚动到 `GitHub Pages` 区域，在 `Theme chooser` 下点击 `Choose a theme` 按钮
2. 选择 Github 内置的主题后，点击 `Select theme` 按钮保存

设置好主题后，Github 会在项目下添加一个 `_config.yml` 文件用于配置

### 定制域名

1. 前提是设置好了网站源，否则不能出现 `Custom domain` 子项

## 参考

* [Github Pages](https://pages.github.com/)
* [GitHub Pages Basics](https://help.github.com/en/categories/github-pages-basics)
* [Using a custom domain with GitHub Pages](https://help.github.com/en/articles/using-a-custom-domain-with-github-pages)
* [Adding a Jekyll theme to your GitHub Pages site with the Jekyll Theme Chooser](https://help.github.com/en/articles/adding-a-jekyll-theme-to-your-github-pages-site-with-the-jekyll-theme-chooser)
* [GitHub pages cheatsheet](https://devhints.io/gh-pages)
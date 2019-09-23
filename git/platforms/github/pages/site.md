# Github Pages 创建站点

## 面向个人或组织

**1**. 创建一个名为 `username.github.io` 的代码仓库（`username` 必须是自己的用户名或组织名）

**2**. 克隆代码仓库

```sh
$ git clone https://github.com/username/username.github.io.git
```

**3**. Hello World

```sh
$ cd username.github.io
$ echo "Hello, world" > index.html
```

**4**. Push 到 Github

```sh
$ git add --all
$ git commit -m "试一试 Github Pages"
$ git push -u origin master
```

**5**. 浏览器访问 <https://username.github.io>

## 面向项目页面

主分支作为源：

1. 检查 commit：<https://github.com/USERNAME/REPO/commits/master>
2. 在项目根目录创建 `index.html` 或 `index.md` 或 `README.md` 文件（优先级从左往右递减）并添加一些内容
3. 到项目页面中点击 `Settings` 选项并滚动到 `GitHub Pages` 区域，选择 `master branch` 作为源
4. 浏览器访问 <http://username.github.io/my-project>
5. 如果网站不能访问说明构建出错，需要回到 `Settings > GitHub Pages` 查看具体的错误提示；意味着可以利用 Github Pages 功能来检查项目的某些问题

子目录作为源：

1. 在项目子目录 **/docs** 下创建 `index.html` 或 `index.md` 文件并添加一些内容
2. 到项目页面中点击 `Settings` 选项并滚动到 `GitHub Pages` 区域，选择 `master branch /docs folder` 作为源
3. 浏览器访问 <http://username.github.io/my-project>
4. 如果网站不能访问说明构建出错，需要回到 `Settings > GitHub Pages` 查看具体的错误提示；意味着可以利用 Github Pages 功能来检查项目的某些问题

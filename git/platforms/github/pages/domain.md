# Github Pages 自定义域名

## 目的

* 使用自定义域名来服务站点，而非默认的 `username.github.io`

## 无自定义域名时

假设所有项目都为 GitHub Pages 设置了 `source`：

`<username>.github.io` -> `github.com/<username>/<username>.github.io`
`<username>.github.io/project` -> `github.com/<username>/project`

## 流程

1. 前提是设置好了网站源，否则不能出现 `Custom domain` 子项
2. 确保原站点可访问
3. 添加自定义域名到 Github Pages 站点：「Settings」 -> 「Options」 -> 「GitHub Pages」 -> 「Custome domain」
4. 开启 HTTPS（自 2018 年 5 月 1 日起，Github Pages 的自定义域名支持 HTTPS 请求）
5. 在域名提供商网站设置自定义域名
    * 子域名（如：www.example.com），必须是 `CNAME` 记录

## 域名策略

| 域名策略                                           | DNS 记录 |
| -------------------------------------------------- | -------- |
| `www.weplay.me` -> `jinsyin.github.io`             | CNAME    |
| `project.weplay.me` -> `jinsyin.github.io/project` |          |

## 不支持的自定义域名

* 使用多个顶级域名，如 `example.com` 和 `weplay.me` 一同使用
* 使用多个 `www` 子域名，如 `www.example.com` 和 `www.weplay.me` 一同使用
* 同时使用顶级域名和自定义子域名，如 `weplay.me` 和 `blog.weplay.me` 一同使用

## 子域名

## 顶级域名

设置自定义域名：

只需要对 `jinsyin.github.io` 项目设置自定义域名为 `weplay.me` 即可，其他项目无需再设置该域名，并且也不能再设置为 `weplay.me`（提示被占用）。

解析方式（选择 CNAME 或 A 记录）：

```txt
// CNAME
weplay.me -> jinsyin.github.io

// A 记录（任选一个）：weplay.me -> <IP>
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

设置域名解析后：

* 访问 `weplay.me`，等同先前的 `jinsyin.github.io`
* 访问 `weplay.me/project`，等同先前的 `jinsyin.github.io/project`（假设 `project` 仓库为 GitHub Pages 设置了 `source` 但没有设置自定义域名） —— 即 `project` 项目使用跟 `jinsyin.github.io` 项目相同的域名
* 访问 `jinsyin.github.io`，将显式重定向到 `weplay.me`
* 访问 `jinsyin.github.io/project`，将显式重定向到 `weplay.me/project`

测试 CNAME 的解析结果：

```sh
# Linux
$ dig weplay.me +noall +answer
weplay.me.		226	IN	A	185.199.110.153
weplay.me.		226	IN	A	185.199.111.153
weplay.me.		226	IN	A	185.199.109.153
weplay.me.		226	IN	A	185.199.108.153
```

## 场景

如果只有一个域名：

1. `example.com` -> `github.com/jinsyin/jinsyin.github.io`

## 参考

* [About custom domains and GitHub Pages](https://help.github.com/en/articles/about-custom-domains-and-github-pages)
* [Managing a custom domain for your GitHub Pages site](https://help.github.com/en/articles/managing-a-custom-domain-for-your-github-pages-site)
* [Custom domains on GitHub Pages gain support for HTTPS](https://github.blog/2018-05-01-github-pages-custom-domains-https/)
* [我们来“劫持”个GitHub自定义域名玩吧！](https://www.freebuf.com/articles/web/171952.html)

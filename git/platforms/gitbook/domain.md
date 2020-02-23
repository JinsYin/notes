# GitBook 自定义域名

## 支持域名

GitBook 并不支持所有类型的域名，其中就包括顶级域名。

| 类型     | 示例                              | 支持？ |
| -------- | --------------------------------- | ------ |
| 子域名   | `www.weplay.me`、`book.weplay.me` | Yes    |
| 顶级域名 | `weplay.me`                       | No     |

## 定制流程

### 旧版

1. 在 GitBook Book 的设置页面添加自定义域名，如 `k8s.weplay.me`
2. 前往 `weplay.me` 域名所指定的 DNS 解析商设置 CNAME 记录：`k8s.weplay.me` -> `www.gitbooks.io`
3. GitBook 默认支持 HTTPS，稍等片刻后直接访问 `https://k8s.weplay.me`
4. 自定义完成后，原先的 Book 主页 `<user_or_org>.gitbooks.io/<book>` 依然可以访问

### 新版

1. 在 GitBook Space 的设置页面添加自定义域名，如 `k8s.weplay.me`
2. 前往 `weplay.me` 域名所指定的 DNS 解析商设置 CNAME 记录：`k8s.weplay.me` -> `hosting.gitbook.com`
3. 过一段时间后，访问 `https://k8s.weplay.me`

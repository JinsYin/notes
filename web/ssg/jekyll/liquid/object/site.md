# site 对象

## `site.pages`

页面（`page`）包括：

* `robots.tt`
* `sitemap.xml` - `jekyll-sitemap`
* 所有 HTML 页面

不包括：

* 集合文档

---

* `robots.txt`

```txt
Sitemap: /sitemap.xml
```

* `sitemap.xml`

```xml
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
  <url>
    <loc>/apps/all-contributors/</loc>
    <lastmod>2019-10-20T12:31:23+08:00</lastmod>
  </url>
  ...
</urlset>
```

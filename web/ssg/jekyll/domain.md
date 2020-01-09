# 定制域名

1. <https://github.com/JinsYin/jekyll_demo/settings>
2. 【GitHub Pages】 -> 【Custom domain】，填写域名并保存
3. 到域名提供商官网创建一个 CNAME 记录，指向 <jinsyin.github.io>
4. 将_config.yml文件中的baseurl改成根目录"/"

> 定制后将无法通过 <jinsyin.github.io/jekyll_demo> 访问到

## 参考

* [Custom domain redirects for GitHub Pages sites](https://help.github.com/en/articles/custom-domain-redirects-for-github-pages-sites)

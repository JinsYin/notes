# Wappalyzer

Wappalyzer 是一个跨平台的实用程序和浏览器插件，可以检测网站所使用的技术，包括内容管理系统（CMS）、电子商务平台、Web 框架（如：Express）、服务器软件（如：Nginx）、分析工具等。

## 安装

* [Wappalyzer for Chrome](https://chrome.google.com/webstore/detail/wappalyzer/gppongmhjkpfnbhagpmjfkannfbllamg)
* [Wappalyzer for Firefox](https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/)
* Node.js 方式：`npm i -g wappalyzer`（类似工具：`stacks-cli`）

## 示例

```sh
$ export wap=wappalyzer
$ wappalyzer https://baidu.com
{"urls":{"https://baidu.com/":{"status":200}},"applications":[{"name":"jQuery","confidence":"100","version":"1.10.2","icon":"jQuery.svg","website":"https://jquery.com","categories":[{"59":"JavaScript Libraries"}]}],"meta":{"language":null}}
```

# 网络协议

## 协议三要素

```bash
# 示例
$ curl -i baidu.com

HTTP/1.1 200 OK
Date: Fri, 25 Jan 2019 02:34:14 GMT
Server: Apache
Last-Modified: Tue, 12 Jan 2010 13:48:00 GMT
ETag: "51-47cf7e6ee8400"
Accept-Ranges: bytes
Content-Length: 81
Cache-Control: max-age=86400
Expires: Sat, 26 Jan 2019 02:34:14 GMT
Connection: Keep-Alive
Content-Type: text/html

<html>
<meta http-equiv="refresh" content="0;url=http://www.baidu.com/">
</html>
```

| 要素 | 解释                       | 示例说明                                                              |
| ---- | -------------------------- | --------------------------------------------------------------------- |
| 语法 | 内容要符合一定的规则和格式 | 从上到下依次是：HTTP Version、Status，HTTP Response Header，HTTP Body |
| 语义 | 内容要代表某种意义         | 比如：状态码 `200` 表示返回成功，状态码 `404` 表示网页不存在          |
| 顺序 | 先做什么，后做什么         | 先发送 HTTP 请求，然后才获得 HTTP 响应                                |
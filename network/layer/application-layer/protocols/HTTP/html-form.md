# HTTP 协议与 HTML 表单的对应关系

## From method vs HTTP method

* GET

```html
<form action="checkUser.html?opt=xxx" method="POST">
    <input type="text" name="username" value="yyy"/>
    <input type="text" name="age" value="zzz"/>
    <input type="submit" value="submit"/>
</form>
```

```txt
POST /hello/checkUser.html?opt=xxx HTTP/1.1
Referer: http://localhost:8000/hello/index.html
Accept: */*
Accept-Language: zh-cn
Content-Type: application/x-www-form-urlencoded
Accept-Encoding: gzip, deflate
Host: localhost:8000
Content-Length: 20
Connection: Keep-Alive
Cache-Control: no-cache
Cookie: JSESSIONID=BBBA54D519F7A320A54211F0107F5EA6
```

## HTTP content-type vs Form enctype

* multipart/form-data

* application/x-www-form-urlencoded

## 参考

* [HTTP协议与HTML表单（再谈GET与POST的区别）](https://blog.csdn.net/darxin/article/details/4944225)

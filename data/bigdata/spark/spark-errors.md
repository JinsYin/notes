# Spark 错误整理

## 错误一

* 问题

本地使用 spark-shell 以及本地运行 Spark 程序出现以下错误：

```
java.net.BindException: Cannot assign requested address: Service 'sparkDriver' failed after 16 retries!
```

* 分析、解决

原因是修改本机 IP 之后， `/etc/hosts` 中本机 IP 与主机名之间的对应关系并没有修改，直接修改即可。

> http://blog.csdn.net/chengyuqiang/article/details/69665878
> http://blog.csdn.net/bob601450868/article/category/6768441
>>>>>>> origin/master

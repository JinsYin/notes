# Resolver

`/etc/resolv.conf` 是 resolver 类库使用的配置文件，被用于 DNS 域名解析。如果想通过域名来访问 Internet 上的其它主机，需要利用该类库将域名转换成对应的 IP 地址，然后才能进行访问。

## 配置选项

* nameserver

用于指定 DNS 服务器，可以配置多个 nameserver 来指定多个 DNS。

```txt
nameserver 8.8.8.8 # 谷歌
nameserver 202.96.209.133 # 电信
nameserver 202.96.209.5 # 电信
nameserver 114.114.114.114 # 三大运营商
```

* domain

用于指定本地域名（实际上也能指定远程域名）。如果查询的名称没有包含 `小数点`，会自动将设置的本地域名作为它的根域名。

```bash
# 不带小数点的域名不能直接 ping 通
$ ping news
ping: unknown host news
```

```bash
# 设置本地域名
$ vi /etc/resolv.conf
domain sogou.com
```

```bash
# 实际上 ping 的是 news.sogou.com
$ ping news
PING news.sogou.com (220.181.124.50) 56(84) bytes of data.
64 bytes from 220.181.124.50: icmp_seq=1 ttl=51 time=38.3 ms
64 bytes from 220.181.124.50: icmp_seq=2 ttl=51 time=41.9 ms
64 bytes from 220.181.124.50: icmp_seq=3 ttl=51 time=49.9 ms
```

* search

用于指定域名的搜索列表。如果需要使用多种没有小数点的域名，可以通过 `search` 来指定多种组合，而不是通过 `domain` 来设置。因为 `domain` 指定的是本地域名，所以会优先搜索 `domain`，如果搜索失败才会尝试搜索 `search` 的组合。另外，搜索列表限制 6 个域名，共 256 个字符。

```txt
domain server.local
search sogou.com baidu.com
```

* sortlist

用于返回的域名进行排序。

```txt
sortlist 130.155.160.0/255.255.240.0 130.155.0.0
```

## 参考

* [resolv.conf - resolver configuration file](http://www.man7.org/linux/man-pages/man5/resolver.5.html)
* [DNS 域名解析設定 /etc/resolv.conf 檔案](http://blog.csdn.net/chenliujiang1989/article/details/8773466)
# Apline Linux

Alpine Linux 使用了 musl，可能和其他 Linux 发行版使用的 glibc 实现会有所不同。在容器化中最可能遇到的是 [DNS 问题](https://github.com/gliderlabs/docker-alpine/issues/8)，即 musl 实现的 DNS 服务不会使用 resolv.conf 文件中的 `search` 和 `domain` 两个配置，也不支持多个 `nameserver`，这对于一些通过 DNS 来进行服务发现的框架可能会遇到问题。


## 下载及部署

* ISO

> https://www.alpinelinux.org/downloads/

* Docker

```bash
$ docker run -it --name alpine alpine:3.5 sh
```


## 参考

> http://www.infoq.com/cn/news/2016/01/Alpine-Linux-5M-Docker
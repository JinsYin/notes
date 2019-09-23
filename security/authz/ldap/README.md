# LDAP 协议

轻量级目录访问协议（Lightweight Directory Access Protocol，缩写：`LDAP`）是一种开放的行业标准 `应用层` 协议，用于通过 IP 协议访问和维护分布式 `目录服务（Directory service）`。

## 协议概述

客户端通过连接 LDAP 服务器（称为 Direcotry System Agent，即 DSA）在 TCP 和 UDP 的 `389` 端口上启动一个 LDAP 会话（默认），或者在 `636` 端口上启用 LDAPS（LDAP over SSL）。

1. 客户端连接 LDAP 服务器（亦为 Direcotry System Agent，缩写：DSA），建立 `LDAP 会话`（TCP&UDP 端口：`389`；默认） 或 `LDAPS 会话`（TCP&UDP 端口：`636`）
2. 客户端向服务器端发送操作请求信息（所有信息使用 BER 编码）。除了某些特例，客户端在发送下一个请求之前，不需要等待响应，服务器可以按任何顺序发送响应



## 属性概述

## 历史背景

鉴于原先的 `目录访问协议`（Directory Access Protocol，即 `DAP`）对于简单的互联网客户端使用太复杂，IETF 设计并指定 LDAP 做为使用 X.500 目录的更好的途径。LDAP 在 TCP/IP 之上定义了一个相对简单的升级和搜索目录的协议。

## 应用场景

哪些信息适合存储在目录中：

* 企业员工信息，如姓名，邮箱，联系方式等
* 公用证书和安全秘钥
* 公司物理设备信息，如服务器 IP、主机名、存放位置、厂商和购买时间等

LDAP 最常见的用法是作为存储用户名和密码的中央仓库，允许许多不同的应用程序和服务连接到 LDAP 服务器以验证用户身份。

LDAP 的一个常见用途是 `单点登录`，用户可以在多个服务中使用同一个密码，通常用于公司内部网站的登录（只需要在公司计算机上登录一次，便可以自动在公司内部网络上登录）。

## URI schema

```plain
ldap://host:port/DN?attributes?scope?filter?extensions
```

## 参考

* [RFC 4511](https://tools.ietf.org/html/rfc4511)
* [搞懂 OpenLDAP](https://segmentfault.com/a/1190000014683418)

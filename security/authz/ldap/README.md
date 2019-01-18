# LDAP

轻量级目录访问协议（Lightweight Directory Access Protocol，缩写：`LDAP`）是一种开放的行业标准 `应用层` 协议，用于通过 IP 协议访问和维护分布式 `目录服务（Directory service）`。

## 协议概述

客户端通过连接 LDAP 服务器（称为 Direcotry System Agent，即 DSA）在 TCP 和 UDP 的 `389` 端口上启动一个 LDAP 会话（默认），或者在 `636` 端口上启用 LDAPS（LDAP over SSL）。

1. 客户端连接 LDAP 服务器（亦为 Direcotry System Agent，缩写：DSA），建立 `LDAP 会话`（TCP&UDP 端口：`389`；默认） 或 `LDAPS 会话`（TCP&UDP 端口：`636`）
2. 客户端向服务器端发送操作请求信息（所有信息使用 BER 编码）。除了某些特例，客户端在发送下一个请求之前，不需要等待响应，服务器可以按任何顺序发送响应

## 目录结构

DN能 取这样的值：“ou=people,dc=wikipedia,dc=org”

```plain
         dc=org
           |
      dc=wikipedia
      /          \
ou=people     ou=groups
```

LDAP 目录与普通数据库的主要不同之处在于数据的组织方式，它是一种有层次的、树形结构。

* 条目（Entry）由一组属性（Attribute）组成
* 属性具有名称（属性类型和属性描述），以及一个或多个属性值。属性在模式（Schema）中定义
* 每个条目都有一个唯一的标识符：Distinguished Name（DN），它既不是属性也不是条目的一部分

DN（Distinguished Name）：

* 由 Relative Distinguished Name（`RDN`；根据条目中的某些属性构造）组成，后接父条目的 DN
* 将 DN 看作是完整文件路径，RDN 看做其父文件夹中的相对文件名（若 `/foo/bar/x.txt` 是 DN，则 `x.txt` 就是 RDN）

示例：

```plain
dn: cn=John Doe,dc=example,dc=com
cn: John Doe
givenName: John
sn: Doe
telephoneNumber: +1 888 555 6789
telephoneNumber: +1 888 555 1232
mail: john@example.com
manager: cn=Barbara Doe,dc=example,dc=com
objectClass: inetOrgPerson
objectClass: organizationalPerson
objectClass: person
objectClass: top
```

解释：

* `dn` - 条目的唯一标识；它既不是属性也不是条目的一部分
* `cn=John Doe` - 条目的 RDN（Relative Distinguished Name）
* `dc=example,dc=com` - 父条目的 DN
* 其他行显示条目的属性

## 目录服务

目录服务允许在整个网络中共享有关 `用户`、`系统`、`网络`、`服务` 和 `应用` 的信息。例如，目录服务可以提供组织有序的记录集，通常具有分层结构，比如公司电子邮件目录。

## 属性概述

属性（`Attribute`）类似于程序设计中的变量，可以被赋值。在 OpenLDAP 中声明了许多常用的 Attribute，用户也可以自定义 Attribute 。

| 属性名称 | 全称               | 描述                                     | 属性值样例        |
| -------- | ------------------ | ---------------------------------------- | ----------------- |
| `c`      | Country            | 国家                                     |                   |
| `cn`     | Common Name        | 指一个对象的名字；如果是人，需要使用全名 | cn=John Doe       |
| `dc`     | Domain Component   | 域名（Domain）的一部分（Component）      | dc=example,dc=com |
| `dn`     | Distinguished Name | 专有名称；条目的唯一标识符               |                   |
| `l`      | Location           | 指一个地名或一个城市名                   |                   |
| `mail`   | E-mail Address     | 邮箱账号                                 | john@example.com  |
| `o`      | Organization Name  | 组织                                     |                   |
| `ou`     | Organization Unit  | 组织单元                                 |                   |
| `sn`     | SurName            | 指一个人的姓                             | sn=Doe            |
| `uid`    | User Id            | 通常指一个用户的登录名                   |                   |
| `gid`    | User Group         | 通常指一个用户的所属组                   |                   |

* [OpenLDAP 概念与工作原理介绍](https://www.linuxidc.com/Linux/2016-08/134225.htm)

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
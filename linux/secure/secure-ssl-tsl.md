# SSL/TSL

SSL/TSL 协议位于 TCP/IP 协议与应用层协议（例如：HTTP、FTP、TELNET 等）之间，为数据通讯提供安全支持。

## 明文传播面临三大风险

1. **窃听风险**（eavesdropping）：第三方可以获知通信内容。
2. **篡改风险**（tampering）：第三方可以修改通信内容。
3. **冒充风险**（pretending）：第三方可以冒充他人身份参与通信。

## SSL/TLS 协议三大功能

1. **内容加密**
2. **身份认证**
3. **数据完整性**

* **历史**

```
1994年，网景公司设计了 SSL 协议 1.0 版，但并未发布。
1995年，网景公司发布 SSL 2.0 版，很快发现有严重漏洞。
1996年，SSL 3.0 版问世，得到大规模应用。
1999年，互联网标准化组织 ISOC 接替网景公司，发布了 SSL 的升级版 TLS 1.0 版。
2006年和2008年，TLS 进行了两次升级，分别为 TLS 1.1 版和 TLS 1.2 版。
2011年，TLS 1.2 的修订版。
```

目前，应用最广泛的是 TLS 1.0，接下来是 SSL 3.0。但是，主流浏览器都已经实现了 TLS 1.2 的支持。

TLS 1.0 通常被标示为 SSL 3.1，TLS 1.1 为 SSL 3.2，TLS 1.2 为 SSL 3.3。

* **优点**
  1. 内容加密
  2. 身份认证
  3. 数据完整性

## SSL

SSL（Secure Socket Layer，安全套接字层）

## TLS

TLS （Transport Layer Security，传输层安全协议）

* 加密算法

```
公钥加密系统：RSA、Diffie-Hellman、DSA及Fortezza；
对称密钥系统：RC2、RC4、IDEA、DES、Triple DES及AES；
单向散列函数：MD5及SHA。
```

## 主流数字证书格式

一般来说，主流的 Web 服务软件，通常都基于 OpenSSL 和 Java 两种基础密码库。

- Tomcat、Weblogic、JBoss 等 Web 服务软件，一般使用 JDK 工具包中的 `Keytool` 工具提供的密码库，生成 Java Keystore（JKS）格式的证书文件。
- Apache、Nginx 等 Web 服务软件，一般使用 `OpenSSL` 工具提供的密码库，生成 PEM、KEY、CRT 等格式的证书文件。
- IBM 的 Web 服务产品，如 Websphere、IBM Http Server（IHS）等，一般使用 IBM 产品自带的 `iKeyman` 工具，生成 KDB 格式的证书文件。
- 微软 Windows Server 中的 Internet Information Services（IIS）服务，使用 Windows 自带的证书库生成 PFX 格式的证书文件。

### 如何判断证书文件是文本格式还是二进制格式？

您可以使用以下方法简单区分带有后缀扩展名的证书文件：

- *.DER 或 *.CER 文件： 这样的证书文件是二进制格式，只含有证书信息，不包含私钥。
- *.CRT 文件： 这样的证书文件可以是二进制格式，也可以是文本格式，一般均为文本格式，功能与 *.DER 及 *.CER 证书文件相同。
- *.PEM 文件： 这样的证书文件一般是文本格式，可以存放证书或私钥，或者两者都包含。 *.PEM 文件如果只包含私钥，一般用 *.KEY 文件代替。
- *.PFX 或 *.P12 文件： 这样的证书文件是二进制格式，同时包含证书和私钥，且一般有密码保护。

对于文本格式的证书文件：

- 如果存在——BEGIN CERTIFICATE——，则说明这是一个证书文件。
- 如果存在—–BEGIN RSA PRIVATE KEY—–，则说明这是一个私钥文件。

另外，证书格式之间是可以互相转换的

## 参考

* [图解 SSL/TLS 协议](http://www.ruanyifeng.com/blog/2014/09/illustration-ssl.html)


* [SSL/TLS 协议运行机制的概述](http://www.ruanyifeng.com/blog/2014/02/ssl_tls.html)
* [主流数字证书都有哪些格式](https://help.aliyun.com/knowledge_detail/42214.html)
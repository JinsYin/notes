# OpenSSL

OpenSSL 是一个 SSL 密码库，Apache 使用它加密  HTTPS，OpenSSH 使用它加密 SSH，它囊括了主要的密码算法、常用的密钥、证书封装管理功能和 SSL 协议。

OpenSSL 签发证书的过程：先签发根证书，再通过该根证书签发子证书。

## 安装

* Ubuntu

```bash
$ openssl version
OpenSSL 1.0.1f 6 Jan 2014

$ # 如果没有安装
$ apt-get install openssl
```

* CentOS

```bash
$ openssl version
OpenSSL 1.0.1e-fips 11 Feb 2013

$ # 如果没有安装
$ yum install openssl
```

## 配置

Ubuntu 中 OpenSSL 的配置文件位于 `/etc/ssl/openssl.cnf`。

CentOS 中 OpenSSL 的配置文件位于 `/etc/pki/tls/openssl.cnf`。

参数解释：

* **certs**：存放已颁发的证书。
* **newcerts**： 存放 CA 指令生成的新证书。
* **private**：存放私钥。
* **crl**：存放已吊销的证书。
* **index.txt**：OpenSSL 定义的已签发证书的文本数据库文件，这个文件通常在初始化的时候是空的。
* **serial**：证书签发时使用的序列号参考文件，该文件的序列号是以 16 进制格式进行存放的，该文件必须提供并且包含一个有效的序列号。

## 文件后缀

* **.key**：私有密钥。
* **.csr**：证书签名请求文件，包含公钥信息，Certificate Signing Request 的缩写。
* **.crt**：证书文件，Certificate 的缩写。
* **.crl**：证书吊销列表，Certificate Revocation List 的缩写。
* **.pem**：用于导入导出证书时候的证书的格式，有证书开头，结尾的格式。

## 系统根证书路径

* **Ubuntu**

Ubuntu 的根证书目录是 `/usr/local/share/ca-certificates/`。添加完证书之后需要更新，更新完成后会将证书内容追加到 `/etc/ssl/certs/ca-certificates` 文件中。

```bash
# 添加 CA 根证书
$ cp Test_CA.crt /usr/local/share/ca-certificates

# 更新
$ update-ca-certificates

# 更新完成后，会在 /etc/ssh/certs/ 目录下为该证书创建一个软连接
$ ll /etc/ssl/certs/Test_CA.pem
/etc/ssl/certs/Test_CA.pem -> /usr/local/share/ca-certificates/Test_CA.crt

# 将根证书目录 /usr/share/ca-certificates 下新增的证书添加到 /etc/ca-certificates.conf 中
$ sudo dpkg-reconfigure ca-certificates
```

* **CentOS**

CentOS 的根证书目录是 `/etc/pki/ca-trust/source/anchors/`

```bash
# 安装 ca-certificates 包
$ yum install ca-certificates

# 开启动态 CA 配置功能
$ update-ca-trust force-enable

# 添加 CA 根证书
$ cp ca.crt /etc/pki/ca-trust/source/anchors/

# 证书生效
$ update-ca-trust extract
```

## 申请证书的步骤

### 制作 CSR 文件

申请 SSL 数字证书之前，必须先生成 `证书私钥` 和 `证书签名请求（CSR）` 文件。CSR 是公钥证书原始文件，包含了申请人的服务器信息和单位信息，需要提交到 CA 认证中心。而私钥则保存在申请人的服务器上，不得对外泄露，当然也不用提交给 CA，应该妥善保管和备份私钥。

一个完整的数字证书由一个私钥和一个对应的公钥（证书）组成。另外，在生成 CSR 文件时会同时生成私钥文件。

证书续费对 CSR 的要求：为了证书密钥安全，SSL 证书续费时，一定要重新生成 CSR 和私钥。

* 生成 CSR 文件时，需要输入以下信息（中文使用 UTF-8 编码）：

| 字段                        | 说明                                 | 示例                                 |
| --------------------------- | ------------------------------------ | ------------------------------------ |
| Organization Name（**O**）  | 申请单位法定名称（中英文）           | Hangzhou Alibaba Technology Co.,Ltd. |
| Organization Unit（**OU**） | 申请单位所在部门（中英文）           | IT Dept                              |
| Country Code（**C**）       | ISO 国家代码（两位字符）             | CN                                   |
| State or Province（**ST**） | 申请单位所在省份、直辖市等（中英文） | Shanghai                             |
| Locality（**L**）           | 申请单位所在城市（中英文）           | Hangzhou                             |
| Common Name（**CN**）       | 申请 SSL 证书的具体网站域名          | www.taobao.com 或 *.taobao.com     |
| Email Address               | 邮箱（选填）                         |                                      |
| A challenge password        | 私钥保护密码（选填）                 |                                      |
| An optional company name    | 公司名称（选填）                     |                                      |

* 使用 openssl 工具一键私钥和 CSR 文件：

```bash
# 生成 CSR 文件（mydomain.csr）的同时生成私钥文件（myprivate.key）
$ openssl req -new -nodes -sha256 -newkey rsa:2048 -keyout myprivate.key -out mydomain.csr
```

参数解释：

>**-new**：生成一个新的 CSR 文件。
>
>**-nodes**：不对私钥文件加密，默认是需要加密的。
>
>**-sha256**：指定摘要算法（证书签名算法）。
>
>**-newkey**：指定私钥加密算法和私钥长度。
>
>**-keyout**：指定私钥的输出路径和名称。
>
>**-out**：指定 CSR 文件的输出路径和名称。

* 使用 openssl 工具单独生成私钥和 CSR 文件

```bash
# 生成 2048 位的 RSA 私钥，私钥文件名为： www.mydomain.com.key
# 指定 -des3 参数后会提示需要为 www.mydoamin.com.key 设定密码保护，请设置密码并牢记
$ openssl genrsa -des3 -out www.mydomain.com.key 2048

# 生成 CSR 文件（如果为上面的私钥文件设置了密码，需要键入私钥密码）
$ openssl req -new -key www.mydomain.com.key -out www.mydomain.com.csr

# 如果提示“Unable to load config info from /usr/local/ssl/openssl.cnf”，则加上一个指定openssl.cnf 路径的参数：
$ openssl req -new -config openssl.cnf -key www.mydomain.com.key -out www.mydomain.com.csr
```

1. CA 认证

CSR 提交给 CA，CA 一般有 2 种认证方式：

```plain
1、域名认证，一般通过对管理员邮箱认证的方式，这种方式认证速度快，但是签发的证书中没有企业的名称；
2、企业文档认证，需要提供企业的营业执照。一般需要3-5个工作日。 也有需要同时认证以上2种方式的证书，叫EV证书，这种证书可以使IE7以上的浏览器地址栏变成绿色，所以认证也最严格。
```

1. 证书的安装

```plain
在收到CA的证书后，可以将证书部署上服务器，一般APACHE文件直接将KEY+CER复制到文件上，然后修改HTTPD.CONF文件；TOMCAT等，需要将CA签发的证书CER文件导入JKS文件后，复制上服务器，然后修改SERVER.XML；IIS需要处理挂起的请求，将CER文件导入。
```

### 生成 CA 根证书（自签名证书）

步骤：生成CA私钥（.key）-->生成CA证书请求（.csr）-->自签名得到根证书（.crt）（CA 给自已颁发的证书）。

```bash
# Generate CA private key
$ openssl genrsa -out ca.key 2048

# Generate CSR
$ openssl req -new -key ca.key -out ca.csr

# Generate Self Signed Certificate（CA 根证书）
$ openssl x509 -req -days 3650 -in ca.csr -signkey ca.key -out ca.crt
```

## ~~生成自签名 SSL 证书~~

1. 生成专用秘钥和公用证书

```bash
$ openssl req -x509 -newkey rsa:2048 -nodes -keyout key.pem  -days 365 -out certificate.pem
```

参数解释：

* -newkey：
* -nodes：
* -keyout：
* -x509：生成 x509 格式证书
* -days：证书的有效期（天）
* -out：

>【注】：`openssl req -x509` 与 `openssl x509 -req` 命令是等价的。

2. 检查已创建的证书

```bash
$ openssl x509 -text -noout -in certificate.pem
```

3. 将密钥和证书组合在 PKCS#12（P12） 捆绑软件中

```bash
$ openssl pkcs12 -inkey key.pem -in certificate.pem -export -out certificate.p12
```

4. 验证您的 P12 文件

```bash
$ openssl pkcs12 -in certificate.p12 -noout -info
```

### 签发证书

```bash
$ openssl ca -cert cacert.pem -keyfile cakey.pem -in nginx.csr -out nginx.crt
```

## 参考

* [OpenSSL 生成根证书 CA 及签发子证书](https://my.oschina.net/itblog/blog/651434)
* [如何制作 CSR 文件](http://www.cnblogs.com/lhj588/p/6069890.html)
* [主流数字证书都有哪些格式](https://help.aliyun.com/knowledge_detail/42214.html)
* [CSR 在线生成工具](http://www.evtrust.com/tools/generator-csr/generator-csr.html)
* [SSL 证书请求文件 (CSR) 生成指南](https://www.wosign.com/Support/CSRgen/Apache_CSR.htm)
* [证书请求文件 (CSR) 生成指南](https://www.wosign.com/Support/csr_generation.htm)
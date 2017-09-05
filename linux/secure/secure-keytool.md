# Java Keytool

Keytool 是一个 Java 数据证书的管理工具，Keytool 将密钥（key）和证书（certificates）存储在一个称为 keystore 的文件中。在 keystore 里，包含两种数据：密钥实体（Key entity）-密钥（secret key）或者是私钥和配对公钥（采用非对称加密）可信任的证书实体（trusted certificate entries）-只包含公钥

## 使用 keytool 工具生成 CSR 文件

1. 先生成证书文件 keystore, 证书文件中包含密钥，导出密钥方式请参考 [主流数字证书都有哪些格式？](http://help.aliyun.com/knowledge_detail.htm?knowledgeId=13086385)

```bash
$ keytool -genkey -alias mycert -keyalg RSA -keysize 2048 -keystore ./mydomain.jks
```

输入完成后，确认输入内容是否正确：[no]: Y （输入 Y），而后提示输入密钥密码，可以与证书密码一致，如果一致则直接按回车，回车后会在当前目录下生成 mydomain.jks 文件。

参数解释：

- **-alias**：证书别名
- **-keyalg**：密钥算法
- **-keysize**：密钥长度
- **-keystore**：证书文档保存



2. 通过证书文件生成 CSR

```bash
$ keytool -certreq -sigalg SHA256withRSA -alias mycert -keystore ./mydomain.jks -file ./mydomain.csr
```

执行完成后，会在当前目录下生成 mydomain.csr 文件。

参数解释：

- **-sigalg**：指定摘要算法
- **-alias**：指定别名（需要前面的别名一致）
- **-keystore**：证书文件
- **-file**：输出的 CSR 文件路径和名称


# 创建 CA 证书和密钥

## 安装 cfssl

```bash
$ sudo -i # root

$ wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 -O /usr/local/sbin/cfssl
$ wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 -O /usr/local/sbin/cfssljson
$ wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64 -O /usr/local/sbin/cfssl-certinfo

$ chmod +x /usr/local/sbin/cfssl
$ chmod +x /usr/local/sbin/cfssljson
$ chmod +x /usr/local/sbin/cfssl-certinfo
```

> CentOS 中 root 用户的 $PATH 默认不含 /usr/local/bin 而是 /usr/local/sbin，可以运行 echo $PATH 命令来查看。


## 创建 CA （Certificate Authority）

* 初始化一个 CA

保存默认配置以供未来维护时使用。

```bash
$ mkdir /cfssl && cd /cfssl
$ cfssl print-defaults config > default-ca-config.json
$ cfssl print-defaults csr > default-ca-csr.json
```

* 添加 CA 配置文件

```bash
$ cat /cfssl/ca-config.json
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ],
        "expiry": "8760h"
      }
    }
  }
}
```

配置解释：

  - ca-config.json：可以定义多个 profile，分别指定不同的过期时间、使用场景等参数；后续在签名证书时使用某个 profile；
  - signing：表示该证书可用于签名其它证书；生成的 ca.pem 证书中 CA=TRUE；
  - server auth：表示 client 可以用该 CA 对 server 提供的证书进行验证；
  - client auth：表示 server 可以用该 CA 对 client 提供的证书进行验证。

* 添加 CA 证书签名请求

```bash
$ cat /cfssl/ca-csr.json
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "k8s",
      "OU": "System"
    }
  ]
}
```

配置解释：

  - "CN"：Common Name，kube-apiserver 从证书中提取该字段作为请求的用户名 (User Name)；浏览器使用该字段验证网站是否合法；
  - "O"：Organization，kube-apiserver 从证书中提取该字段作为请求用户所属的组 (Group)。

* 生成 CA 证书和私钥

```bash
$ cfssl gencert -initca /cfssl/ca-csr.json | cfssljson -bare ca
$ 
$ ls /cfssl/ca*
ca-config.json  ca.csr  ca-csr.json  ca-key.pem  ca.pem
```


## 分发证书

将生成的 CA 证书、秘钥文件、配置文件拷贝到 `所有节点` 的 `/etc/kubernetes/ssl` 目录下。

```bash
$ sudo mkdir -p /etc/kubernetes/ssl
$
$ sudo cp /cfssl/ca* /etc/kubernetes/ssl
```


## 校验证书

以校验 kubernetes 证书（后续部署 master 节点时生成的）为例

* 使用 openssl 命令

```bash
$ openssl x509  -noout -text -in  kubernetes.pem
```

* 使用 cfssl-certinfo 命令

```bash
$ cfssl-certinfo -cert kubernetes.pem
```


## 参考

  * [创建 CA 证书和秘钥](https://github.com/opsnull/follow-me-install-kubernetes-cluster/blob/master/02-%E5%88%9B%E5%BB%BACA%E8%AF%81%E4%B9%A6%E5%92%8C%E7%A7%98%E9%92%A5.md)
  * [Generate self-signed certificates](https://coreos.com/os/docs/latest/generate-self-signed-certificates.html)
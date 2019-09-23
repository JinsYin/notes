# ssh

## 安装

* 服务端

```sh
$ apt-get install openssh-server
$ service sshd start
```

* 客户端

```sh
# Ubuntu 已默认安装
apt-get install ssh
```

## 创建密钥对和免密钥登录

```sh
$ ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa # rsa 算法用于加解密，dsa 算法用于签名与验证，-f 指定输出文件
$ ssh-copy-id root@ipAdrress # 相当于把本机的公钥 id_rsa.pub 追加到 ipAdress 的 authroized_keys 文件中
```

## 允许 `root` 用户登录

Ubuntu Server 默认不允许使用 `root` 用户 SSH 登录。

* 修改/设置密码

```sh
$ passwd root
```

* 修改配置并重启服务

```sh
$ sed -i 's|PermitRootLogin without-password| PermitRootLogin yes|g' /etc/ssh/sshd_config
$ service ssh restart
```

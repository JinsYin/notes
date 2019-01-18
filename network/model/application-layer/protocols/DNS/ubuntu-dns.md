# Ubuntu 添加 DNS 服务器

## 添加 DNS

```bash
$ cat /etc/resovconf/resolv.conf.d/head
nameserver 8.8.8.8 # 谷歌
nameserver 202.96.209.133 # 电信
nameserver 202.96.209.5 # 电信
nameserver 114.114.114.114 # 三大运营商
```

## 重新加载

```bash
$ sudo resolvconf -u
```

## 检查

```bash
$ cat /etc/resolv.conf
```
# Ubuntu 添加 DNS 服务器

## 添加DNS
```bash
$ sudo vi /etc/resovconf/resolv.conf.d/head
nameserver 8.8.8.8
nameserver 202.96.209.133
nameserver 202.96.209.5
```

## 重新加载
```bash
$ sudo resolvconf -u
```
    
 ## 检查
 ```bash
 $ cat /etc/resolv.conf
 ```

# CentOS SSH

## SSH debug

```bash
$ ssh -vv root@192.168.1.191
$
$ ssh -vvv root@192.168.1.191
```

## 允许 root 用户登录

不同于 Ubuntu，CentOS 安装时没有添加其他非 root 用户，其实也可以直接使用 root 用户登录。

```bash
$ # 取消注释
$ sed -i "s|#PermitRootLogin yes|PermitRootLogin yes|g" /etc/ssh/sshd_config
$
$ # 检查
$ cat /etc/ssh/sshd_config | grep "PermitRootLogin"
$
$ # 重启 sshd
$ systemctl restart sshd.service
```


## 禁用 GSSAPI

CentOS 默认安装后 SSH 登录会非常慢，甚至无法登录，可以通过禁用 GSSAPI 的方式来登录。

* client 端禁用

```bash
$ ssh -o GSSAPIAuthentication=no -vv root@192.168.1.191
```

* server 端禁用

```bash
$ # 禁用
$ sed -i "s|GSSAPIAuthentication yes|GSSAPIAuthentication no|g" /etc/ssh/sshd_config
$
$ # 检查
$ cat /etc/ssh/sshd_config | grep "GSSAPIAuthentication"
$
$ # 重启 sshd
$ systemctl restart sshd.service
```


## 禁用 DNS 解析

解决 DNS 解析缓慢的问题。

```bash
$ # 取消注释
$ sed -i "s|#UseDNS yes|UseDNS no|g" /etc/ssh/sshd_config
$
$ # 检查
$ cat /etc/ssh/sshd_config | grep "UseDNS"
$
$ # 重启 sshd
$ systemctl restart sshd.service
```




## 参考
> http://blog.csdn.net/wenwenxiong/article/details/48685723

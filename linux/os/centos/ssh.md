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

## 允许/限制 SSH 登录的 IP 地址

`/etc/hosts.allow` 许可大于 `/etc/hosts.deny`，可以限制或者允许某个或者某段 IP 地址远程 SSH 登录服务器。

```bash
$ vi /etc/hosts.allow
sshd:223.227.223.*:allow # 允许 223.227.223.* 网段 IP 登录
sshd:192.168.0.*:allow   # 允许 192.168.0.*  网段 IP 登录 
sshd:all:deny            # 禁止其他的所有 IP 登录

$ systemctl restart sshd
```

## 允许/限制 SSH 登录的用户名

```bash
$ /etc/ssh/sshd_config
AllowUsers jins test@192.168.1.1 # 允许 jins 用户和从 192.168.1.1 登录的 test 用户通过 SSH 登录服务器
DenyUsers zhangsan lisi          # 禁止 zhangsan 和 lisi 通过 SSH 登录服务器

$ systemctl restart sshd
```

## Permission denied

SSH 远程时出现："Permission denied (publickey,gssapi-keyex,gssapi-with-mic)"，目前只能手动将公钥添加到目标服务器的 `~/.ssh/authorized_keys` 中。

## 参考

> http://blog.csdn.net/wenwenxiong/article/details/48685723

# VPS 安全

## 禁止 Ping

* 临时

```sh
$ echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all

# 或
$ sysctl -w net.ipv4.icmp_echo_ignore_all=1
```

* 永久

```sh
$ echo "net.ipv4.icmp_echo_ignore_all=1" >> /etc/sysctl.conf
$ sysctl -p # 生效
```

## 用户管理

* 删除系统内置且不常用的用户和用户组

```sh
userdel adm
userdel lp
userdel sync
userdel shutdown
userdel halt
userdel news
userdel uucp
userdel operator
userdel games
userdel gopher
userdel ftp
groupdel adm
groupdel lp
groupdel news
groupdel uucp
groupdel games
groupdel dip
groupdel pppusers
```

* 创建一个新用户用于登录

```sh
$ useradd jinsyin && passwd jinsyin
```

```sh
# 限制 su 命令
$ vi /etc/pam.d/su
#auth       sufficient pam_rootok.so
auth sufficient pam_rootok.so debug
auth required pam_wheel.so group=isd

# 仅运行新创建的用户使用 su 命令
$ usermod -G10 jinsyin
```

## SSH 安全

* 修改端口

```sh
$ sed -i 's|Port .*|Port 199304|g' /etc/ssh/sshd_config
```

* 禁用 root 用户

```sh
$ sed -i 's|PermitRootLogin .*|PermitRootLogin no|g' /etc/ssh/sshd_config

# 允许新创建的用户登录
$ echo 'AllowUsers jinsyin' >> /etc/ssh/sshd_config
```

* 其他设置

```sh
# 禁止X11转发
$ sed -i 's|X11Forwarding .*|X11Forwarding no|g' /etc/ssh/sshd_config

# 禁止空密码登录
$ sed -i 's|PermitEmptyPasswords .*|PermitEmptyPasswords no|g' /etc/ssh/sshd_config
```

* 重启 SSH

```sh
# Ubuntu
$ sudo service sshd restart

# CentOS
$ yum restart sshd
```

## DDos 防御

DDOS deflate 并不能完全防御 DDOS 攻击，但能抵御一点是一点。

```sh
$ curl -L http://www.inetbase.com/scripts/ddos/install.sh -o ddos.sh
$ chmod +x ddos.sh && ./ddos.sh
```

## 防火墙

## 参考

* [为你的 VPS 进行一些安全设置吧](https://www.cnblogs.com/wangluochong/p/6323085.html)

# Ubuntu 部署 OpenLDAP

## 安装

```bash
$ sudo apt-get install -y slapd ldap-utils
```

```bash
# 安装完成后，会自动生成一个系统账号
$ cat /etc/passwd | grep openldap
openldap:x:124:132:OpenLDAP Server Account,,,:/var/lib/ldap:/bin/false
```

```bash
# 生成管理员密码
$ slappasswd -s 123456
{SSHA}WtDZF1GdIJHPIuKUVyPu/ULCVRx/La0d
```
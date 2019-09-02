# ldapadd 添加

## 语法、参数

```syntax
ldapadd  [-V[V]]  [-d debuglevel]  [-n]  [-v]  [-c]  [-f file]  [-S file] [-M[M]] [-x] [-D binddn] [-W] [-w passwd] [-y passwdfile]
       [-H ldapuri] [-h ldaphost] [-p ldapport] [-P {2|3}] [-e [!]ext[=extparam]] [-E [!]ext[=extparam]] [-o opt[=optparam]] [-O security-
       properties] [-I] [-Q] [-N] [-U authcid] [-R realm] [-X authzid] [-Y mech] [-Z[Z]]
```

| 常用参数    | 描述                                 |
| ----------- | ------------------------------------ |
| -x          | 简单认证                             |
| -Y EXTERNAL | 用 sasl 的 external 认证方法         |
| -b basedn   | 查询的基准路径，可以是根、树杈、叶子 |
| -D binddn   | 管理员 DN                            |
| -w passwd   | 管理员密码                           |
| -h host     | LDAP 服务器                          |
| -p port     | LDAP 端口                            |
| -H URI      | LDAP URI；本地地址可以是 "ldap:///"  |
| -f file     | ldif 文件路径                        |

## 导入

```sh
$ ldapadd -x -D "cn=admin,dc=eway,dc=link" -w "admin" -f ldap.ldif
```
# 管理

## 基本需求

* 一个用户可能属于一个或多个组（所以用户和组最好分开管理）
* 查询组时，可以看到它有哪些成员
* 查询用户时，可以看到它属于哪些组
* 删除用户后，其所属的组应该相应地删除该成员
* 删除组时，直接子成员（子条目）会被删除，但间接子成员应该被保留

以上需求看起来简单，但实际操作起来特别繁琐，而且几乎不可能同时实现。

## 转换

```bash
# 利用pl脚本将/etc/passwd 和/etc/shadow生成LDAP能读懂的文件格式
# ./migrate_base.pl > /tmp/base.ldif
# ./migrate_passwd.pl  /etc/passwd > /tmp/passwd.ldif
# ./migrate_group.pl  /etc/group > /tmp/group.ldif
```

```bash
ldapadd -x -D "cn=admin,dc=example,dc=com" -W -f /tmp/base.ldif
```
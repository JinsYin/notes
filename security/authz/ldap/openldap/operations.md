# OpenLDAP 操作

## 客户端工具（以 `ldap` 开头）

* ldapsearch（查询操作）

允许查询目录并取得条目，其查询性能比关系数据库好。

```bash
$ ldapserach -x -H ldap://localhost

$
```

* ldapupdate（更新操作）

目录树条目支持条目的添加、删除、修改等操作。

```bash
$
```

* 同步操作

OpenLDAP 是一种典型的分布式结构，提供复制同步，可将主服务器上的数据通过推或拉的机制实现在从服务器上更新，完成数据的同步，从而避免OpenLDAP 服务器出现单点故障，影响用户验证。

* 认证和管理操作

允许客户端在目录中识别自己，并且能够控制一个会话的性质。

## 服务端工具（以 `slap` 开头）

* slapcat
* slaptest
* slapindex
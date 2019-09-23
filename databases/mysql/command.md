# MySQL 命令

## 用户管理

```mysql
/* 创建新用户 */
create user 'testuser'@'localhost' identified by 'password'
```

## 权限管理

```mysql
grant 权限1,权限2,…权限n on 数据库名称.表名称 to 用户名[@用户地址 identified by ‘连接口令’];
```

解释：

1. 权限:select,insert,update,delete,create,drop,index,alter,grant,references,reload,shutdown,process,file。all表示所有。
2. 当数据库名称.表名称被*.*代替，表示赋予用户操作服务器上所有数据库所有表的权限。
3. []部分可选
4. 用户地址可以是localhost，也可以是ip地址、机器名字、域名。也可以用’%'表示从任何地址连接。

## 数据库管理

```mysql
/* 创建数据库 */
create database testdb

/* 删除数据库 */
drop database testdb
```

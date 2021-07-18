# PostgreSQL 用户管理

安装 PostgreSQL 后，默认会自带一个管理员用户，用户名和密码均为 `postgres`。

## 用户查询

```sql
-- 查询当前用户
=# SELECT * FROM current_user;
-- OR
=# SELECT current_user;
```

```sql
-- 查询所有用户
=# \du

 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 jins      | Superuser, Create role, Create DB                          | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```

## 用户创建

```sql
=# CREATE USER guest WITH PASSWORD '******';
```


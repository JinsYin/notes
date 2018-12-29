# 认证与授权

## 权限（Permissions）

ALL ALTER AUTHORIZE CREATE DROP MODIFY SELECT

* CREATE - keyspace, table, function, role, index
* ALTER - keyspace, table, function, role
* DROP - keyspace, table, function, role, index
* SELECT - keyspace, table
* MODIFY - INSERT, UPDATE, DELETE, TRUNCATE - keyspace, table
* AUTHORIZE - GRANT PERMISSION, REVOKE PERMISSION - keyspace, table, function, and role
* DESCRIBE - LIST ROLES
* EXECUTE - SELECT, INSERT, UPDATE - functions

## 资源（Resources）

* KEYSPACE keyspace_name
* ALL KEYSPACES
* TABLE keyspace_name.table_name

## 授权

```sql
// 授予权限
GRANT [permission] ON [resource|role|function] TO <user>

// 取消权限
REVOKE [permission] PERMISSION ON [resource|role|function] FROM <user>
```
# RBAC（Role Based Access Control）

权限被授予角色，就像之前授予用户一样，关键的区别在于角色也可以互相授予。在这种情况下，我们可以将它们视为组，而不是个体

角色（role）：对某个/某些资源的权限操作（比如，增删改查）

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

## 示例

```sql
// 创建角色以及其权限
CREATE ROLE guest;
GRANT SELECT ON mykeyspace.mytable TO guest;

// 删除角色
DROP ROLE IF EXISTS guest;

// 授权
CREATE ROLE pam WITH PASSWORD = 'password' AND LOGIN = true;
GRANT supervisor TO pam;

LIST ALL PERMISSIONS OF pam;
```

## 参考

* [Role Based Access Control In Cassandra](https://www.datastax.com/dev/blog/role-based-access-control-in-cassandra)

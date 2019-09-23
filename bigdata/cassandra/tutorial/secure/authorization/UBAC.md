# UBAC（User Based Access Control）

Cassandra 默认允许所有用户无密码直接登录，如果想要设置访问权限，需要先修改配置，再添加用户并设置权限。

## 修改配置

```yaml
#authenticator: AllowAllAuthenticator
authenticator: PasswordAuthenticator

#authorizer: AllowAllAuthorizer
authorizer: CassandraAuthorizer
```

重启 Cassandra 服务，令配置生效。

## 设置账号

设置访问权限后，Cassandra 内置了一个带 `SUPERUSER` 权限的 `cassandra@cassandra` 用户，可以登录集群。

```sql
$ cqlsh 127.0.0.1 9042 -u cassandra -p cassandra
cqlsh>
cqlsh> // 创建一个具有 SUPERUSER 权限的用户
cqlsh> CREATE USER administrator WITH PASSWORD 'Admin123' SUPERUSER;
cqlsh>
cqlsh> // 创建一个具有 NOSUPERUSER 权限的用户
cqlsh> CREATE USER lixiaoming WITH PASSWORD 'Lixiaoming123' NOSUPERUSER;
```

```sql
# 添加完自定义的 SUPERUSER 权限用户后，最好删除默认的 cassandra 用户
$ cqlsh 127.0.0.1 9042 -u administrator -p Admin123
cqlsh>
cqlsh> // 删除默认用户
cqlsh> DROP USER cassandra;
cqlsh>
cqlsh> // 查询新增用户（仅 SUPERUSER 权限用户可以查询）
cqlsh> SELECT * FROM system_auth.roles;

 role          | can_login | is_superuser | member_of | salted_hash
---------------+-----------+--------------+-----------+--------------------------------------------------------------
    lixiaoming |      True |        False |      null | $2a$10$IY/TwsdSvYgoe8u.NhhyBe475hhf.QrddsS.59NcVRs8VCYDUHaPK
 administrator |      True |         True |      null | $2a$10$1ZpDZ4PpjaAQHp806hNMZ.8DRbWdufgbq1FUwXyDe2ChYSsMv2eHK

cqlsh> LIST USERS;
 name          | super
---------------+-------
 administrator |  True
    lixiaoming | False
```

## 客户端配置

如果觉得每次输入账号密码比较麻烦，可以将其添加到本地配置文件中。

```ini
$ vi ~/.cassandra/cqlshrc
[authentication]
username = lixiaoming
password = Lixiaoming123
```

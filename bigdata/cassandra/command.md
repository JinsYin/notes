# Cassandra 命令

## CQL vs SQL

Cassandra 使用类 SQL 命令 `cql` 来操作数据库。

| SQL      | Cassandra |
| -------- | --------- |
| database | keyspace  |
| table    | table     |

> 注：为了使 cql 语法在 Markdown 中高亮，指定语言时使用 sql 代替 cql

## 状态

* 版本

```sh
$ cassandra -v
3.11.2
```

* 集群状态

```sh
$ nodetool status
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load       Tokens       Owns (effective)  Host ID                               Rack
UN  127.0.0.1  258.36 KiB  256          100.0%            550bee1d-3cdb-4e67-b086-f5bdb1c8e010  rack1
```

* 客户端连接

```sh
# 详
$ cqlsh -u <username> -p <password> -k <keyspace> x.x.x.x 9042

# 简
$ cqlsh x.x.x.x 9042
```

## 注释

```sql
/* Multi-line comment */
-- Single-line comment
// Single-line comment
```

## SCHEMA

貌似跟 KEYSPACE 没啥区别

```sql
/* 创建 SCHEMA */
CREATE SCHEMA schema1 WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 2};

/* 使用 SCHEMA */
USE schema1
```

## KEYSPACE

Cassandra 支持两种存储策略： `SimpleStrategy` 和 `NetworkTopologyStrategy`。`replication_factor` 用于设置副本数，副本数必须小于等于 Cassandra 节点数。`DURABLE_WRITES` 默认值是 true。

* 创建

```sql
/* SimpleStrategy 存储策略 */
CREATE KEYSPACE myspace WITH replication={'class': 'SimpleStrategy', 'replication_factor': 2};

/* NetworkTopologyStrategy 存储策略 */
CREATE KEYSPACE myspace WITH replication={'class': 'NetworkTopologyStrategy', 'dc1': 2, 'dc2': 3}；
```

* 修改

```sql
ALTER KEYSPACE myspace WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1': 3} AND DURABLE_WRITES = false;
```

* 查看

```sql
/* 查看用户信息 */
DESC cluster;
DESCRIBE cluster;

/* 查看所有 keyspace */
DESC keyspaces;

/* 查看某个 keyspace 的结构，以及其下的表结构 */
DESC keyspace myspace;
```

* 使用

```sql
USE myspace;
```

## TABLE

* 创建

```sql
CREATE TABLE myspace.mytable(id uuid PRIMARY KEY, name text, age int);
```

* 查看

```sql
/* 所有表 */
DESC tables;

/* 表结构 */
DESC table myspace.mytable;
```

* 插入

```sql
INSERT INTO myspace.mytable(id, name, age) VALUES (now(), 'Jane', 21);
INSERT INTO myspace.mytable(id, age, name) VALUES (now(), 24, 'Jins');
```

* 查询

```sql
SELECT * FROM myspace.mytable;

SELECT * FROM myspace.mytable WHERE name='Jins';

/* SELECT * FROM myspace.mytable ORDER BY age desc; */

SELECT * FROM myspace.mytable LIMIT 2;
```

* 删除、清空表

```sql
/* 删除表 */
DROP table myspace.mytable;

/* 清空表 */
TRUNCATE table myspace.mytable;
```

* 删除行、列

`WHERE` 子句不能省略。

```sql
/* 删除某列 */
DELETE age FROM myspace.mytable WHERE name = 'Jins';

/* 删除某行 */
DELETE age FROM myspace.mytable WHERE name in ('Jins', 'Jane');
```

## INDEX

* 创建

```sql
CREATE INDEX ON mytable(age);

CREATE INDEX mytable_name ON mytable(age);
```

## 参考

* [CQL reference](http://docs.datastax.com/en/cql/latest/cql/cql_reference/cqlReferenceTOC.html)
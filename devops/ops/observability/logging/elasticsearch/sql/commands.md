# SQL 命令

## SHOW FUNCTIONS

语法：

```sql
SHOW FUNCTIONS [ LIKE pattern? ]?
```

示例：

```sql
sql> SHOW FUNCTIONS;
      name      |     type
----------------+---------------
AVG             |AGGREGATE
COUNT           |AGGREGATE
MAX             |AGGREGATE
MIN             |AGGREGATE
...
```

```sql
sql> SELECT COUNT(*) FROM ".kibana";
   COUNT(1)
---------------
17
```

## SHOW COLOMNS

语法：

```sql
SHOW COLUMNS [ FROM | IN ]? [ table identifier | [ LIKE pattern ] ]
```

示例：

```sql
sql> SHOW COLUMNS IN ".kibana";
                        column                        |     type      |    mapping
------------------------------------------------------+---------------+---------------
canvas-workpad                                        |STRUCT         |OBJECT
canvas-workpad.@created                               |TIMESTAMP      |DATE
canvas-workpad.@timestamp                             |TIMESTAMP      |DATE
canvas-workpad.id                                     |VARCHAR        |TEXT
canvas-workpad.name                                   |VARCHAR        |TEXT
canvas-workpad.name.keyword                           |VARCHAR        |KEYWORD
```

## SHOW TABLES

语法：

```sql
SHOW TABLES [ table identifier | [ LIKE pattern ] ]?
```

示例：

```sql
sql> /* 列出当前用户可用的表格及其类型 */
sql> SHOW TABLES;
         name          |     type
-----------------------+---------------
.kibana                |ALIAS
.kibana_1              |BASE TABLE
kibana_sample_data_logs|BASE TABLE
```

```sql
sql> /* 匹配多个索引 */
sql> SHOW TABLES ".kibana*"; /* SHOW TABLES LIKE '.kibana%'; */
     name      |     type
---------------+---------------
.kibana        |ALIAS
.kibana_1      |BASE TABLE
```

## DESCRIBE TABLE

语法：

```sql
DESCRIBE [table identifier | [LIKE pattern]]

DESC [table identifier|[LIKE pattern]]
```

示例：

```sh
sql> DESCRIBE ".kibana";
                        column                        |     type      |    mapping
------------------------------------------------------+---------------+---------------
canvas-workpad                                        |STRUCT         |OBJECT
canvas-workpad.@created                               |TIMESTAMP      |DATE
canvas-workpad.@timestamp                             |TIMESTAMP      |DATE
canvas-workpad.id                                     |VARCHAR        |TEXT
canvas-workpad.name                                   |VARCHAR        |TEXT
...
```

## SELECT

语法：

```sql
SELECT select_expr [, ...]
[ FROM table_name ]
[ WHERE condition ]
[ GROUP BY grouping_element [, ...] ]
[ HAVING condition]
[ ORDER BY expression [ ASC | DESC ] [, ...] ]
[ LIMIT [ count ] ]
```

示例：

```sql
$ SELECT type from ".kibana" LIMIT 5;
     type
---------------
space
visualization
visualization
visualization
visualization
```

## EXIT

```sql
sql> QUIT;
Bye!
```

## 参考

* [SQL Commands](https://www.elastic.co/guide/en/elasticsearch/reference/current/sql-commands.html)

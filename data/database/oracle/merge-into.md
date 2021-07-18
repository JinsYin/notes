# MERGE INTO

## 示例

多表：

```sql
MERGE INTO T2
USING T1
ON (T1.NAME=T2.NAME)
WHEN NOT MATCHED THEN
INSERT
VALUES (T1.NAME,T1.MONEY);
```

单表：

```sql
merge into SUN_TEST a
    using (select 'Alice' AS NAME,'20' AS AGE from dual) b
        on (a.NAME=b.NAME)
when matched then
    update set a.age=b.age
when not matched then
    insert (NAME,AGE) VALUES(b.name,b.age)　
```

## 参考

* [merge into 语句用法](https://zhuanlan.zhihu.com/p/47884584)
* [oracle 中使用 merge into](https://www.cnblogs.com/manongxiao/p/12241833.html)
* [mybatis 使用 merge into](https://www.cnblogs.com/Springmoon-venn/p/8519592.html)

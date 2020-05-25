# $group Stage

## 定义

按指定的 `_id` 表达式对输入文档进行分组，并针对每个不同的分组输出一个文档。

```js
{
  $group:
    {
      _id: <expression>, // 按表达式分组
      <field1>: { <accumulator1> : <expression1> },
      ...
    }
 }
```

| 字段    | 描述                                                                              |
| ------- | --------------------------------------------------------------------------------- |
| `_id`   | 必需；如果指定 _id 的值为 null 或其他常量值，则所有输入文档作为一个整体计算累计值 |
| `field` | 可选；使用 Accumulator Operator 计算                                              |

## Accumulator Operator

<https://docs.mongodb.com/manual/reference/operator/aggregation/group/#accumulator-operator>

## 示例

数据集：

```js
db.sales.insertMany([
  { "_id" : 1, "item" : "abc", "price" : NumberDecimal("10"), "quantity" : NumberInt("2"), "date" : ISODate("2014-03-01T08:00:00Z") },
  { "_id" : 2, "item" : "jkl", "price" : NumberDecimal("20"), "quantity" : NumberInt("1"), "date" : ISODate("2014-03-01T09:00:00Z") },
  { "_id" : 3, "item" : "xyz", "price" : NumberDecimal("5"), "quantity" : NumberInt( "10"), "date" : ISODate("2014-03-15T09:00:00Z") },
  { "_id" : 4, "item" : "xyz", "price" : NumberDecimal("5"), "quantity" :  NumberInt("20") , "date" : ISODate("2014-04-04T11:21:39.736Z") },
  { "_id" : 5, "item" : "abc", "price" : NumberDecimal("10"), "quantity" : NumberInt("10") , "date" : ISODate("2014-04-04T21:23:13.331Z") },
  { "_id" : 6, "item" : "def", "price" : NumberDecimal("7.5"), "quantity": NumberInt("5" ) , "date" : ISODate("2015-06-04T05:08:13Z") },
  { "_id" : 7, "item" : "def", "price" : NumberDecimal("7.5"), "quantity": NumberInt("10") , "date" : ISODate("2015-09-10T08:43:00Z") },
  { "_id" : 8, "item" : "abc", "price" : NumberDecimal("10"), "quantity" : NumberInt("5" ) , "date" : ISODate("2016-02-06T20:20:13Z") },
])
```

聚合：

```js
db.sales.aggregate( [
  {
    $group: {
       _id: null,
       count: { $sum: 1 }
    }
  }
] )
```

结果：

```sh
{ "_id" : null, "count" : 8 }
```

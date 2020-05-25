# $count Stage

## 定义

```js
{ $count: <string> }  // <string> 是聚合后输出字段的名称，其值为合计结果。
```

## 示例

示例文档：

```json
{ "_id" : 1, "subject" : "History", "score" : 88 }
{ "_id" : 2, "subject" : "History", "score" : 92 }
{ "_id" : 3, "subject" : "History", "score" : 97 }
{ "_id" : 4, "subject" : "History", "score" : 71 }
{ "_id" : 5, "subject" : "History", "score" : 79 }
{ "_id" : 6, "subject" : "History", "score" : 83 }
```

聚合操作：

```js
db.scores.aggregate(
  [
    {
      $match: {
        score: {
          $gt: 80
        }
      }
    },
    {
      $count: "passing_scores"
    }
  ]
)
```

返回结果：

```json
{ "passing_scores" : 4 }
```

## 参考

* [$count (aggregation)](https://docs.mongodb.com/manual/reference/operator/aggregation/count/#pipe._S_count)

# Aggregate Pipeline

Pipeline 由 Stage 组成，每个 Stage 在文档通过 Pipeline 时对其进行转换。

所有 Stage：

## 定义

```js
db.collection.aggregate(pipeline, options)
```

| 参数     | 类型     | 描述             |
| -------- | -------- | ---------------- |
| pipeline | array    | 数组元素是 Stage |
| options  | document |                  |

## Pipeline Stages

## Stage

### db.collection.aggregate() Stages

```js
db.collection.aggregate( [ { <stage> }, ... ] )
```

| Stage                     | 描述                              |
| ------------------------- | --------------------------------- |
| [$addFields][addFields]   | 添加新字段到文档                  |
| [$bucket][bucket]         | 将输入文档分类多个组，称为 Bucket |
| [$bucketAuto][bucketAuto] |                                   |
| [$collStats][collStats]   |                                   |
| [$count][count]           | 返回该 Stage 的文档总数           |
| [$limit][limit]           | 返回该 Stage 的文档总数           |

除 `$out`，`$merge` 和 `$geoNear` 以外的所有 Stage 都可以在管道中多次出现。

[addFields]: https://docs.mongodb.com/manual/reference/operator/aggregation/addFields/#pipe._S_addFields
[bucket]: https://docs.mongodb.com/manual/reference/operator/aggregation/bucket/#pipe._S_bucket
[bucketAuto]: https://docs.mongodb.com/manual/reference/operator/aggregation/bucketAuto/#pipe._S_bucketAuto
[collStats]: https://docs.mongodb.com/manual/reference/operator/aggregation/bucketAuto/#pipe._S_bucketAuto
[count]: https://docs.mongodb.com/manual/reference/operator/aggregation/count/#pipe._S_count
[limi]: https://docs.mongodb.com/manual/reference/operator/aggregation/limit/#pipe._S_limit

### db.aggregate() Stages

从 3.6 版本开始提供。

```mongodb
db.aggregate( [ { <stage> }, ... ] )
```

## 参考

* [db.collection.aggregate()](https://docs.mongodb.com/manual/reference/method/db.collection.aggregate/#db.collection.aggregate)

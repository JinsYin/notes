# Aggregation Pipeline 的限制

Aggregation Pipeline 对值类型和结果大小存在一些限制。

## 结果大小限制（Result Size Restrictions）

[aggregate](https://docs.mongodb.com/v4.0/reference/command/aggregate/#dbcmd.aggregate) 命令返回一个 cursor 或者存储结果到集合，其中的每个文档均受 BSON 文档大小限制（16MB），如果任何单个文档超出 BSON 文档大小限制，该命令会产生错误。该限制仅限于最后返回的文档，在管道处理过程中文档超出此大小将不受影响。

## 内存限制

Pipeline Stages 的内存大小限制为 100MB，如果某个 Stage 超出此限制，MongoDB 将产生错误。

如果要处理大型数据集，可以在 `aggregate()` 方法中设置 [allowDiskUse][allowdiskuse] 选项，该选项运行大多数 Stage 将数据写入临时文件。

[allowdiskuse]: https://docs.mongodb.com/v4.0/reference/method/db.collection.aggregate/#method-aggregate-allowdiskuse

以下 Stage 不能设置 `allowDiskUse`，必须在内存限制内：

* `$graphLookup` Stage
* 用在 `$group` Stage 的 `$addToSet` 累加表达式
* 用在 `$group` Stage 的 `$push` 累加表达式

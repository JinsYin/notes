# Map-Reduce

## 并发和锁机制

Map-Reduce 操作由多个任务组成，包括：

* 从输入集合中读取数据
* 执行 `map` 函数
* 执行 `reduce` 函数
* 处理的中间结果写入临时集合
* 最终结果写入输出集合

上述操作期间，Map-Reduce 将采取以下锁：

* 读阶段需要一个 read 锁。每 100 份文档产生一次
* 插入到临时集合时单个写入需要一个 write 锁
* 如果输出集合不存在，则输出集合的创建需要一个 write 锁
* 如果输出集合存在，则输出操作（如 merge、replace、reduce）需要一个 write 锁。该 write 锁是全局的，将阻塞 mongod 实例上的所有操作。

## 示例

数据集：

```js
db.orders.insertMany([
   { _id: 1, cust_id: "Ant O. Knee", ord_date: new Date("2020-03-01"), price: 25, items: [ { sku: "oranges", qty: 5, price: 2.5 }, { sku: "apples", qty: 5, price: 2.5 } ], status: "A" },
   { _id: 2, cust_id: "Ant O. Knee", ord_date: new Date("2020-03-08"), price: 70, items: [ { sku: "oranges", qty: 8, price: 2.5 }, { sku: "chocolates", qty: 5, price: 10 } ], status: "A" },
   { _id: 3, cust_id: "Busby Bee", ord_date: new Date("2020-03-08"), price: 50, items: [ { sku: "oranges", qty: 10, price: 2.5 }, { sku: "pears", qty: 10, price: 2.5 } ], status: "A" },
   { _id: 4, cust_id: "Busby Bee", ord_date: new Date("2020-03-18"), price: 25, items: [ { sku: "oranges", qty: 10, price: 2.5 } ], status: "A" },
   { _id: 5, cust_id: "Busby Bee", ord_date: new Date("2020-03-19"), price: 50, items: [ { sku: "chocolates", qty: 5, price: 10 } ], status: "A"},
   { _id: 6, cust_id: "Cam Elot", ord_date: new Date("2020-03-19"), price: 35, items: [ { sku: "carrots", qty: 10, price: 1.0 }, { sku: "apples", qty: 10, price: 2.5 } ], status: "A" },
   { _id: 7, cust_id: "Cam Elot", ord_date: new Date("2020-03-20"), price: 25, items: [ { sku: "oranges", qty: 10, price: 2.5 } ], status: "A" },
   { _id: 8, cust_id: "Don Quis", ord_date: new Date("2020-03-20"), price: 75, items: [ { sku: "chocolates", qty: 5, price: 10 }, { sku: "apples", qty: 10, price: 2.5 } ], status: "A" },
   { _id: 9, cust_id: "Don Quis", ord_date: new Date("2020-03-20"), price: 55, items: [ { sku: "carrots", qty: 5, price: 1.0 }, { sku: "apples", qty: 10, price: 2.5 }, { sku: "oranges", qty: 10, price: 2.5 } ], status: "A" },
   { _id: 10, cust_id: "Don Quis", ord_date: new Date("2020-03-23"), price: 25, items: [ { sku: "oranges", qty: 10, price: 2.5 } ], status: "A" }
])
```

需求：计算每个消费者的总价

逻辑：按 cust_id 分组，然后计算每个 cust_id 的价格总和。

1. 定义 map 函数

```js
var mapFunction1 = function() {
   emit(this.cust_id, this.price);  // this 代表当前正在处理的文档
};
```

2. 定义 reduce 函数

```js
// valuesPrices 是一个数组，其元素是 map 函数输出并按 keyCustId 分组的 price 值
var reduceFunction1 = function(keyCustId, valuesPrices) {
   return Array.sum(valuesPrices);
};
```

3. 执行 map-reduce

```js
// 针对 orders 集合的所有文档
db.orders.mapReduce(
   mapFunction1,
   reduceFunction1,
   { out: "map_reduce_example" } // 输出结果到名为 map_reduce_example 集合，若该集合存在，将替换旧的内容
)
```

4. 查询 map_reduce_example 集合验证结果

```js
db.map_reduce_example.find().sort( { _id: 1 } )
```

输出：

```js
{ "_id" : "Ant O. Knee", "value" : 95 }
{ "_id" : "Busby Bee", "value" : 125 }
{ "_id" : "Cam Elot", "value" : 60 }
{ "_id" : "Don Quis", "value" : 155 }
```

### 替代方案

使用 Pipeline 重写 map-reduce 操作，而无需定义自定义函数：

```js
db.orders.aggregate([
   { $group: { _id: "$cust_id", value: { $sum: "$price" } } },
   { $out: "agg_alternative_1" }
])
```

1. `$group` stage 按 cust_id 分组，并对每个组的 price 求和，将得到以下文档（这些文档将传递到下一个 stage）：

```js
{ "_id" : "Don Quis", "value" : 155 }
{ "_id" : "Ant O. Knee", "value" : 95 }
{ "_id" : "Cam Elot", "value" : 60 }
{ "_id" : "Busby Bee", "value" : 125 }
```

2. `$out` stage 将输出结果写入 agg_alternative_1 集合（`$merge` 可代替 `$out`）

3. 查询 agg_alternative_1 集合进行验证

```js
db.agg_alternative_1.find().sort( { _id: 1 } )
```

```js
{ "_id" : "Ant O. Knee", "value" : 95 }
{ "_id" : "Busby Bee", "value" : 125 }
{ "_id" : "Cam Elot", "value" : 60 }
{ "_id" : "Don Quis", "value" : 155 }
```

## 参考

* [db.collection.mapReduce()](https://docs.mongodb.com/manual/reference/method/db.collection.mapReduce/#db.collection.mapReduce)

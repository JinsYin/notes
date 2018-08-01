# MongoDB 命令

## 数据库（db）命令：

```bash
$ show dbs; # 查看有哪些数据库
$ use myDB; # 切换/创建数据库
$ db.help(); # 数据库命令
$ db.dropDatabase(); # 删除当前数据库
$ db.getName(); # 查看当前使用的数据库， db.mycoll.getDB() # 返回的是当前数据库对象
$ db.stats(); # 查看当前当前数据库的状态
$ db.version(); # 查看当前数据库的版本
$ db.getMongo(); # 查看当前连接的数据库地址信息
```

## 集合（collection）命令

```bash
$ show collections(); / db.getCollectionNames(); / show tables(); # 查看当前数据库有哪些集合
$ db.createCollection("mycoll"); # 创建空集合
$ db.createCollection(name, { size : ..., capped : ..., max : ... } )
$ db.mycoll.help(); # 集合命令
$ db.printCollectionStats(); # 查看当前 db 中所有集合索引状态
$ db.mycoll.totalSize(); # 查询集合总大小
$ db.mycoll.dataSize();  # 查询数据大小
```

## 用户命令

```bash
$ show users; # 查看当前所有用户
```

## 集合查询

```bash
$ db.mycoll.find(); # 查询所有记录 .pretty() .forEach(printjson)
$ db.mycoll.find({"age": 22});  # 查询所有 age 等于 22 的记录
$ db.mycoll.find({age: {$gte: 23, $lte: 26}});  # 查询所有 age >= 23 且 age <= 26的记录
$ db.mycoll.find(/mongo/); # 查询 name 中包含 mongo 的数据, 相当于：select * from mytable where name like '%mongo%';
$ db.mycoll.find({}, {name: 1, age: 1}); # 查询指定的 name 列和 age 列， 相当于：select name,age from mytable;
$ db.mycoll.find().sort({age: 1}); # 年龄升序
$ db.mycoll.find().skip(10); # 查询 10 条以后的数据
$ db.mycoll.find().skip(20).limit(10); # 查询[20, 30)之间的数据，limit == pagesize，skip == (pagenum - 1) * pagesize
$ db.mycoll.find({$or: [{age: 22}, {age: 25}]}); # 与查询
$ db.mycoll.findOne(); # 查询第一条记录
$ db.mycoll.find().count() / db.mycoll.count(); # 查询记录的条数
$ db.mycoll.find({gender: {$exists: true}}); # 查询某个字段是否存在
```

## 索引

```bash
$ db.mycoll.createIndex({name: 1}); # 创建索引， {backgroud:true} 后台执行
$ db.mycoll.getIndexes(); # 查询所有索引
$ db.mycoll.totalIndexSize(); # 查询总索引记录大小
$ db.mycoll.reIndex(); # 返回所有索引
$ db.users.dropIndexes();  # 删除所有索引
$ db.mycoll.dropIndex({"indexKey": 1}); # 删除制定索引
```

## 增、删、改

```bash
$ db.mycoll.insert({name: 'yin', age: 24, gender: true}); # 插入一条记录, 如果集合不存在自动创建
$ db.mycoll.insertMany([{name: 'abc', age: 1}, {name: 'efd', age: 26}]); # 插入多条记录
$ db.mycoll.update({age: 24}, {$set: {name: 'jins'}}, false, true); # 更新，第一个 boolean 值表示是否 upsert, 第二个表示是否更新 multi 个,
$ db.mycoll.updateOne({name: 'yin', {$set: {name: 'jins'}, $inc: {age: 1}}}, false); # 更新第一个，boolean 值表示是否 upsert
$ db.mycoll.updateMany({age: 24, {$set: {name: 'jins'}}, false})
$ db.mycoll.deleteOne({age: 24}); # 删除第一条记录
$ db.mycoll.deleteMany({age: 24}); # 删除多条记录， 等价于 db.mycoll.remove({name: 'yin'});
```

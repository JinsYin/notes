# 迭代器

Scala Iterator（迭代器）不是一个集合，它是一种用于访问集合的方法。

迭代器的两个基本操作是 `next()` 和 `hasNext()`。`next()` 返回迭代器的下一个元素，并且更新迭代器的状态；`hasNext()` 检测集合中是否还有元素。

```scala
val it = Iterator("Google", "Baidu")

while(it.hasNext) {
    println(it.next)
}
```

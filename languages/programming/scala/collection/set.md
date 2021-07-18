# Set

Scala Set（集合）没有重复的对象，所有的元素都是唯一的。

Scala 默认使用的是不可变集合，引用的 `scala.collection.immutable.Set` 包；如果要使用可变集合，需要引用 `scala.collection.mutable.Set` 包。

## 不可变集合

```scala
val set = Set(1, 2, 3)

println(set.getClass.getName)
println(set.exists(_ % 2 == 0)) // true
println(set.drop(1)) // Set(2, 3)
```

集合的三个基本操作：

> * head： 集合第一个元素
>
> * tail： 除第一个元素外的子集合
>
> * isEmpty： 集合为空时返回 true

```scala
val site = Set("Google", "Apple", "Amazon")
val nums: Set[Int] = Set()

println(site.head) // "Google"
println(site.tail) // Set("Apple", "Amazon")
println(site.isEmpty) // false
println(nums.isEmpty) // true
```

* 连接集合

可以使用 `++` 运算符或 `++()` 方法来连接两个集合。

```scala
val usIns = Set("Google", "Apple", "Amazon")
val cnIns = Set("Baidu", "Tecent", "Alibaba")

// 使用 ++ 运算符
println(usIns ++ cnIns)

// 使用 ++() 方法
println(usIns.++(cnIns))
```

* 最大、最小值

```
val nums = SEt(1, 3, 5, 7)

println(nums.min) // 1
println(nums.max) // 7
```

* 交集

可以使用 `&` 方法或 `intersect` 方法来查看两个集合的交集元素

```scala
val num1 = Set(5, 6, 9, 20, 30, 45)
val num2 = Set(50, 60, 9, 20, 35, 55)

println(num1.&(num2)) // Set(20, 9)
println(num1.intersect(num2)) // Set(20, 9)
```


## 可变集合

```scala
import scala.collection.mutable.Set

val set = Set(1, 2, 3)
println(set.getClass.getName) // scala.collection.mutable.HashSet

set.add(4)
set.remove(1)
set += 5
set -= 2

println(set) // Set(5, 3, 4)

val another = set.toSet // 默认是不可变集合
println(another.getClass.getName) // scala.collection.immutable.Set
```

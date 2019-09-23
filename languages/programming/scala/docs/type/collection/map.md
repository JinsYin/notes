# Map（映射）

Map（映射）是一种可迭代的键值对（key/value）结构，也叫哈希表（Hash tables）。

Map 有两种类型，可变 Map 和不可变 Map。默认使用的是不可变 Map，引用 `scala.collection.immutable.Map` 包。如果需要使用可变 Map，需要引入 `scala.collection.mutable.Map` 包。

## 不可变 Map

```scala
// 空哈希表
val A: Map[Char, Int] = Map()

val colors = Map("red" -> "#FF0000", "azure" -> "#FOFFFF")

// 使用 + 好添加 key/value 对
A += ('I' -> 1)
A += ('J' -> 5)
A('K') = 6
```

* 基本操作

| 方法    | 含义                |
| ------- | ------------------- |
| keys    | 返回 Map 所有的键   |
| values  | 返回 Map 所有的值   |
| isEmpty | Map 为空是返回 true |

```scala
val colors = Map("red" -> "#FF0000", "azure" -> "#F0FFFF", "peru" -> "#CD853F")
val nums: Map[Int, Int] = Map()

println(colors.keys) // Set(red, azure, peru)
println(colors.values) // MapLike(#FF0000, #F0FFFF, #CD853F)
println(colors.isEmpty) // false
println(nums.isEmpty) // true
```

* Map 合并

可以使用 `++` 运算符或 `++()` 方法来连接两个 Map，Map 合并时会移除重复的 key。如果 key 相同而 value 不同，合并的时候后一个 Map 的 value 会覆盖前一个 Map 的值。

```scala
val m1 = Map("a" -> "A", "b" -> "B")
val m2 = Map("a" -> "a", "c" -> "C")

println(m1 ++ m2) // Map(a -> a, b -> B, c -> C)
println(m2 ++ m1) // Map(a -> A, b -> B, c -> C)
```

* 是否存在指定的 key

使用 `contains` 方法来查看 Map 中是否存在指定的 key。

```scala
val m = Map("a" -> "A", "b" -> "B", "c" -> "C")

println(m.contains("a")) // true
println(m.contains("A")) // false
```

## 可变 Map

# Option

Scala Option（选项）类型用来表示一个值是可选的（有值或无值）。`Option` 有两个直接子类：`Some` 和 `None`。

Option[T] 是一个类型为 T 的可选值的容器： 如果值存在， Option[T] 就是一个 Some[T] ，如果不存在， Option[T] 就是对象 None 。

```scala
val m = Map("a" -> "AAA", "b" -> "BBB", "c" -> "CCC")

val v1: Option[String] = m.get("a")
val v2: Option[String] = m.get("A")

println(v1) // Some[AAA]
println(v2) // None
```

## get() 和 getOrElse()

`get()` 方法获取 Some[T] 中的元素 T；`getOrElse()` 方法来获取 Some[T] 中的元素 T 或者使用默认值。其中 None 没有 `get()` 方法。

只有 Some[T] 才有 `get()` 方法

```scala
val a: Option[Int] = Some(5)
val b: Option[Int] = None

println(a.get) // t
println(b.get) // 报错

println(a.getOrElse) // 5
println(b.getOrElse) // warning 提示：弃用

println(a.getOrElse(10)) // 10
println(b.getOrElse(20)) // 20
```

## isEmpty()

```scala
val a: Option[Int] = Some(5)
val b: Option[Int] = None

println(a.isEmpty) // false
println(b.isEmpty) // true
```

# Scala 集合之 List

Scala List 类似于数组，它们的所有元素的类型都相同，不同的是：List 是不可变的，引用的是 `scala.collection.immutable.List` 包；其次 List 是链表结构。

相反，ListBuffer 是可变的，引用的是 `scala.collection.mutable.ListBuffer` 包。

## 实现原理

## List

```scala
// 字符串列表
val site: List[String] = List("Google", "Apple", "Amazon")

// 整数列表
val nums: List[Int] = List(1, 3, 5)

// 二维列表
val dim: List[List[Int]] = List(
    List(1, 0, 0),
    List(0, 1, 0),
    List(0, 0, 1),
)
```

构造列表的两个基本单位是 `Nil` 和 `::`，`Nil` 也可以表示为一个空列表。

```scala
// 字符串列表
val site: List[String] = "Google" :: ("Apple" :: ("Amazon" :: Nil))

// 整数列表
val nums = 1 :: (2 :: (3 :: Nil))

// 空列表
val empty = Nil

// 二维列表
val dim = (1 :: (0 :: (0 :: Nil))) ::
          (0 :: (1 :: (0 :: Nil))) ::
          (0 :: (0 :: (1 :: Nil))) :: Nil
```

对比发现，`::` 左右两边要么是一个元素，要么是一个列表。


* 基本操作

> * head： 返回列表一个元素
>
> * tail： 返回除第一个元素外的子列表
>
> * isEmpty： 列表为空是返回 true

```scala
val site = "Google" :: ("Apple" :: ("Amazon" :: Nil))
val nums = Nil

println(site.head) // Google
println(site.tail) // List("Apple", "Amazon")
println(site.isEmpty) // false
println(site.isEmpty) // true
```

* 连接列表

可以使用 `:::` 运算符、 `:::()` 方法或 `List.concat()` 方法来连接两个或多个列表。

```scala
val usIns = "Google" :: ("Apple" :: ("Amazon" :: Nil))
val cnIns = "Baidu" :: ("Tecent" :: ("Alibaba" :: Nil))

// 使用 ::: 运算符
println(usIns ::: cnIns) // List(Google, Apple, Amazon, Baidu, Tecent, Alibaba)

// 使用 :::() 方法
println(usIns.:::(cnIns)) // List(Baidu, Tecent, Alibaba, Google, Apple, Amazon)

// 使用 List.concat() 方法
println(List.concat(usIns, cnIns)) // List(Google, Apple, Amazon, Baidu, Tecent, Alibaba)
```

* List.fill()

使用 List.fill() 来创建重复数量的元素列表

```scala
val site = List.fill(3)("Google") // 函数柯里化
println(site) // List(Google, Google, Goole)
```

* List.reverse()

反转列表顺序

```scala
val site = "Google" :: ("Apple" :: ("Amazon" :: Nil))
println(site.reverse) // List("Amazon", "Apple", "Google")
```

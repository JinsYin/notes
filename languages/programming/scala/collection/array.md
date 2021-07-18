# 数组

## 声明/定义

* Java

```java
String[] javaArr = new String[3];

// 声明 + 定义

String[] javaArr = {"a", "b", "c"}
```

* Scala

```scala
var scalaArr: Array[String] = new Array[String](3)

// 或

var scalaArr = new Array[String](3)

// 声明 + 定义

var scalaArr = Array("a", "b", "c")
```

## 访问元素

* Java

Java 使用特殊操作符 `arrayName[N]` 来访问数组元素，其中 N 为数组下标。

```java
String first = javaArr[0]
```

* Scala

Scala 使用 `函数调用` 的方式来访问数组元素，而不是使用特殊操作符。Scala 允许在类中定义一个特殊函数 `apply`，当对象被当作函数处理时，apply 函数就会被调用，所以 `scalaArr(0) == scalaArr.apply(0)`。

```scala
var first = scalaArr(0)
```

## 方法

* 数组长度

可以用 `size()` 和 `length()` 方法求数组长度。

```scala
val arr = Array(1, 3)

println(arr.size)   // 2
println(arr.length) // 2
```

## 区间数组

使用 `range()` 方法来生成一个区间范围内的 `Array`。range() 方法最后一个参数为步长，默认为 1。

```scala
import Array._

var arr1 = range(10, 20, 2) // Array(10, 12, 14, 16, 18)
var arr2 = range(10, 20) 	// Array(10, 11, 12, 13, 14, 15, 16, 17, 18, 19)
```

## 区间（Range）

Scala 中，默认 `Range` 是不可变的，区间范围 `[a, b)`。

```scala
var arr1 = Range(1, 5) 		// Range(1, 2, 3, 4)
var arr2 = Range(1, 5, 2) 	// Range(1, 3)
```

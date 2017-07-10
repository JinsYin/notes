# Scala 数组

## 声明/定义

* Java

```java
String[] z = new String[3];

// 声明 + 定义

String[] z = {"a", "b", "c"}
```


* Scala

```scala
var z: Array[String] = new Array[String](3)

// 或

var z = new Array[String](3)

// 声明 + 定义

var z = Array("a", "b", "c")
```

## 方法

* 数组长度

可以用 `size()` 和 `length()` 方法求数组长度。

```scala
val arr = Array(1, 3)

println(arr.size) 	// 2
println(arr.length) // 2
```



## 区间数组

使用 `range()` 方法来生成一个区间范围内的 `Array`。range() 方法最后一个参数为步长，默认为 1。

```scala
import Array._

var arr1 = range(10, 20, 2) // Array(10, 12, 14, 16, 18)
var arr2 = range(10, 20) 	// Array(10, 11, 12, 13, 14, 15, 16, 17, 18, 19)
```

## 区间 Range

Scala 中，默认 `Range` 是不可变的，区间范围 `[a, b)`。

```scala
var arr1 = Range(1, 5) 		// Range(1, 2, 3, 4)
var arr2 = Range(1, 5, 2) 	// Range(1, 3)
```
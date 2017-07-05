# Scala 数组

## 声明

* Java

```java
String[] z = new String[3];
```

* Scala

```scala
var z: Array[String] = new Array[String](3)

// 或

var z = new Array[String](3)

// 声明 + 定义

var z = Array("a", "b", "c")
```

## 区间数组

使用 range() 方法来生成一个区间范围内的数组。range() 方法最后一个参数为步长，默认为 1

```scala
import Array._

var arr1 = range(10, 20, 2) // 10 12 14 16 18
var arr2 = range(10, 20) 	// 10 11 12 13 14 15 16 17 18 19
```
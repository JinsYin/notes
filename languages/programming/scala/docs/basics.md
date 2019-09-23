# Scala 基础

## 表达式（expression）

表达式为可以被计算的语句。

```scala
1 + 1
```

## 常量（value）、变量（variable）

* 常量

常量不能被修改。

```scala
$ scala
scala> val x = 1 + 1
x: Int = 2
scala>
scala> x = 3
<console>:12: error: reassignment to val
scala>
```

* 变量

变量类似于常量，不同的是变量可以被修改。

```scala
$ scala
scala> var x = 1 + 1
x: Int = 2
scala>
scala> x = 3
x: Int = 3
scala>
```

常量类型可以自动推断，也可以自己声明。

```scala
val x = 1 + 1
val x: Int = 1 + 1
```

```scala
var y = 2 + 2
var y: Int = 2 + 2
```

## 代码块（block）

代码块使用 `{}` 来组合各种语句。

```scala
// 下面这个块的最后一个表达式的结果是整个块的结果
println({
  val x = 1 + 1
  x + 1
})
```

## 函数（function）

函数是接收参数的表达式

* 匿名函数

```scala
// 左边是参数列表，右边是表达式
(x: Int) => x + 1
```

* 命名函数

```scala
// 接收多个参数
val add = (x: Int, y: Int) => x + y
println(add(1, 2)) // 3
```

* 无参函数

```scala
val getTheAnswer = () => 42
println(getTheAnswer()) // 42
```

## 方法（method）

方法（method）快起来很像函数（function），但和函数又有一些关键区别。

* 方法使用 `def` 关键字来定义，其后分别是方法名、参数列表、返回类型、等号和方法主体。如果不写等号和方法主体，那该方法会被隐式声明为抽象 `abstract` 的。

```scala
def add(x: Int, y: Int): Int = x + y
println(add(1, 2)) // 3
```

* 方法可以接收多个参数列表

```scala
def addThenMultiply(x: Int, y: Int)(multiplier: Int): Int = (x + y) * multiplier
println(addThenMultiply(1, 2)(3)) // 9
```

* 方法可以没有参数列表

```scala
def name: String = System.getProperty("name")
println("Hello, " + name + "!")
```

* 方法可以有多行表达式

```scala
// 方法体的最后一个表达式是方法的返回值
def getSquareString(input: Double): String = {
  val square = input * input
  square.toString
}
```

## 类（class）

* 使用 class 关键字创建类

```scala
class Greeter(prefix: String, suffix: String) {
  // 构造方法
  def greet(name: String): Unit = println(prefix + name + suffix)
}
```

* 使用 new 关键字创建类的实例

```scala
val greeter = new Greeter("Hello, ", "!")
greeter.greet("Scala developer") // Hello, Scala developer
```

## Case 类

Scala 有一个特定的类类型叫作 `case` 类。默认情况，case 类是不可变（immutable），并且是按值比较（compared by value）的。另外，case 类必须有参数列表。[更多](http://docs.scala-lang.org/tutorials/tour/case-classes.html)

```scala
case class Point(x: Int, y: Int)
```

* 可以不用 `new` 关键字实例化 case 类

```scala
val point = Point(1, 2)
val anotherPoint = Point(1, 2)
val yetAnotherPoint = Point(2, 2)
```

* 按值比较

```scala
if (point == anotherPoint) {
  println(point + " == " + anotherPoint)
} else {
  println(point + " != " + anotherPoint)
}
// Point(1,2) == Point(1,2)

if (point == yetAnotherPoint) {
  println(point + " == " + yetAnotherPoint)
} else {
  println(point + " != " + yetAnotherPoint)
}
// Point(1,2) != Point(2,2).
```

## Object

[更多](http://docs.scala-lang.org/tutorials/tour/singleton-objects.html)

```scala
object IdFactory {
  private var counter = 0

  def create(): Int = {
    counter += 1
    counter
  }
}
```

通过名字来访问 object

```scala
val newId: Int = IdFactory.create()
println(newId) // 1
val newerId: Int = IdFactory.create()
println(newerId) // 2
```

## 特质（trait）

特质是含有特定字段和方法的类型；多个特质之间可以组合。[更多](http://docs.scala-lang.org/tutorials/tour/traits.html)

使用 `trait` 关键字定义特质

```scala
trait Greeter {
  def greet(name: String): Unit
}
```

特质也可以有默认的实现

```scala
trait Greeter {
  def greet(name: String): Unit =
    println("Hello, " + name + "!")
}
```

继承（`extends`）特质并覆写（`override`）默认的实现

```scala
// DefaultGreeter 可以继承多个特质
class DefaultGreeter extends Greeter

class CustomizableGreeter(prefix: String, postfix: String) extends Greeter {
  override def greet(name: String): Unit = {
    println(prefix + name + postfix)
  }
}

val greeter = new DefaultGreeter()
greeter.greet("Scala developer") // Hello, Scala developer!

val customGreeter = new CustomizableGreeter("How are you, ", "?")
customGreeter.greet("Scala developer") // How are you, Scala developer?
```

## Main 方法

和其他编程语言一样，main 方法是程序的入口.JVM 要求 main 方法被命名为 `main`，并且传递一个字符串数组作为参数。

```scala
object Main {
  def main(args: Array[String]): Unit =
    println("Hello, Scala developer!")
}
```

## 参考

> http://docs.scala-lang.org/tutorials/tour/basics.html

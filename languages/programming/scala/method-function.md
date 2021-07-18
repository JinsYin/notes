
## 传名调用（Call-by-Name）

## 传值调用（Call-by-Value）

## 嵌套方法

```scala
def factorial(i: Int): Int = {
    def fact(i: Int, accumulator: Int): Int = {
        if (i <= 1)
            accumulator
        else
            fact(i - 1, i * accumulator)
    }
    fact(i, 1)
}

factorial(2) // 2
factorial(3) // 6
```

## 递归函数

```scala
def factorial(n: BigInt): BigInt = {
    if (n <= 1)
        1
    else
        n * factorial(n - 1)
}

factorial(2) // 2
factorial(3) // 6
```

## 匿名函数

```scala
val inc = (x: Int) => x + 1
```

匿名函数实际上是以下写法的简写：

```scala
def add2 = new Function1[Int,Int] {
    def apply(x:Int):Int = x + 1;
}
```

* 多个参数

```scala
var mul = (x: Int, y: Int) => x * y
```

* 无参数

```scala
var useDir = () => System.getProperty("user.dir")
```

## 高阶函数

高阶函数可以将其他函数作为参数或者作为返回值。

```scala
// 函数 f 和 值 v 作为参数，而函数 f 又调用了参数 v
def apply(f: Int => String, v: Int) = f(v)

// 泛型 A
def layout[A](x: A) = "[" + x.toString() + "]"

println( apply(layout, 10) ) // [10]
```

## 函数柯里化（Currying）

柯里化（Currying）指的是将原来接受两个参数的函数变成新的接受一个参数的函数的过程。新的函数返回一个以原有第二个参数为参数的函数。

```scala
def add(x: Int, y: Int) = x + y // 调用：add(1, 2)

// 变形
def add(x: Int)(y: Int) = x + y // 调用：add(1)(2)
```

add(1)(2) 实际上是依次调用两个普通函数（非柯里化函数）:

```scala
def add(x: Int) = (y: Int) => x + y

val result = add(1) // (y: Int) => 1 + y
val sum = result(2) // 3
```

实例：

```scala
def strcat(s1: String)(s2: String) = {
    s1 + s2
}

strcat("Hello, ")("world!")
```

## 偏应用函数

使用 `_` 代替缺失的参数列表

```scala
val layout = println(_: Int)
```

> <http://www.runoob.com/scala/partially-applied-functions.html>

## 默认参数值

```scala
def add(a: Int = 1, b: Int = 2): Int = {
    return a + b
}

add() // 3
add(2, 3) // 5

// 指定参数名
add(b = 3, a = 7) // 10
```

## 可变参数

* Java

```java
public static void printInfo(String* args) {
    int i = 0;
    for (arg: args) {
      System.out.println("Arg value[" + i + "] = " + arg);
      i = i + 1;
    }
}

printInfo("Java", "Language");
```

* Scala

```scala
def printInfo(args: String*) {
    var i = 0
    for (arg <- args) {
      println("Arg value[" + i + "] = " + arg)
      i = i + 1
    }
}

printInfo("Scala", "Language")
```

## 闭包

闭包是一个函数，返回值依赖于声明在函数外部的一个或多个变量。

```scala
var factor = 3
val multiplier = (i:Int) => i * factor  // factor 不是形式参数，而是自由变量
```

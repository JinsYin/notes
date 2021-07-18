# Scala 方法和函数

## 高阶函数（Higher-order Functions）

高阶函数：传递函数作为参数，或者返回的结果是一个函数。

```scala
def apply(f: Int => String, v: Int) = f(x)
```

```scala
class Decorator(left: String, right: String) {
    def layout[A](x: A) = left + x.toString + right
}

object FunTest extends App {
    def apply(f: Int => String, v: Int) = f(v)
    val decorator = new Decorator("[", "]")
    println(apply(decorator.layout, 7)) // [7]
}
```

## 嵌套方法（Nested Methods）

```scala
// 阶乘
def factorial(x: Int): Int = {
    def fact(x: Int, accumulator: Int): Int = {
        if (x <= 1) accumulator
        else fact(x - 1, x * accumulator)
    }
    fact(x, 1)
}

println("Factorial of 2: " + factorial(2)) // Factorial of 2: 2
println("Factorial of 3: " + factorial(3)) // Factorial of 3: 6
```

## 柯里化（currying）

方法（method）可以定义多个参数列表。当一个

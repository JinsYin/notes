# 模式匹配

一个模式匹配包含了一系列备选项，每个都开始于关键字 case。每个备选项都包含了一个模式及一到多个表达式。箭头符号 => 隔开了模式和表达式。Scala 的模式匹配类似 Java 里的 switch。

* Java

* Scala

```scala
def matchTest(x: Int): String = x match {
    case 1 => "one"
    case 2 => "two"
    case _ => "many"
}
```

## 匹配类型

```scala
def matchTest(x: Any): Any = x match {
    case 1 => "one"
    case "two" => 2
    case y: Int => "scala.Int"
    case _ => "many"
}

println(matchTest("two")) // 2
println(matchTest(1)) // one
println(matchTest(6)) // scala.Int
```

## 样例类

使用 `case` 关键字定义的类称为样例类（case classes），样例类是一种特殊的类，可以被用于模式匹配。此外，样例类可以不用 `new` 关键字实例化。

```scala
object Test {
  def main(args: Array[String]) {
    val aoa = Person("Aoa", 25) // new 可无可无
    val bob = Person("Bob", 32)
       val coc = Person("Coc", 32)

    for (person <- List(aoa, bob, coc)) {
        person match {
        case Person("Aoa", 25) => println("Hi Aoa!")
        case Person("Bob", 32) => println("Hi Bob!")
        case Person(name, age) => println("Age: " + age, name: " + name)
      }
    }
  }

  // 样例类
  case class Person(name: String, age: Int)
}
```

在声明样例类时，下面的过程自动发生了：

* 构造器的每个参数都成为 val，除非显式被声明为 var，但是并不推荐这么做；
* 在伴生对象中提供了 apply 方法，所以可以不使用 new 关键字就可构建对象；
* 提供 unapply 方法使模式匹配可以工作；
* 生成 toString、equals、hashCode 和 copy 方法，除非显示给出这些方法的定义。

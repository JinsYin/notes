# Break & Continue

Scala 并没有 Java 中的 `break` 和 `continue` 操作，而是间接地基于 `scala.util.control.Breaks.break()` 来实现的。`break` 和 `continue` 的区别取决于 `breakable` 的作用范围，如果在循环内就是 `continue`，如果在循环外就是 `break`。

## Break

```scala
import scala.util.control.Breaks._

breakable {
    for (index <- 1 to 10) {
        if (index == 5) break() else print(s"${index} ") // 1 2 3 4
    }
}
```

## Continue

```scala
import scala.util.control.Breaks._

for (index <- 1 to 10) {
    breakable {
        if (index == 5) break() else print(s"${index} ") // 1 2 3 4 6 7 8 9 10
    }
}
```

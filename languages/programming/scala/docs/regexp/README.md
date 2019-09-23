# Scala 正则表达式

Scala 使用 scala.util.matching 包中的 Regex 类来支持正则表达式。

```scala
val pattern = "Scala".r
val string = "Scala is Scalable and cool"

println(pattern findFirstIn string)
```

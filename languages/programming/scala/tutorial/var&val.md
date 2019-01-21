# Var & Val

## 懒机制（lazy load）

如果声明一个常量的时候在前面加上 `lazy` 来实现 `懒加载`，表示在声明的时候不加载，而在调用的时候加载。

```scala
scala> val x = 10
x: Int = 10
scala>
scala> // 惰性变量只能是不可变变量
scala> lazy val y = 20
y: Int = <lazy>
```

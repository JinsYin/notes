# Scala 访问修饰符

默认情况，Scala 的类、伴生对象以及类成员（属性和方法）都是 `public` 的。与 Java 相似的是 `private` 和 `protected`，不同的是 Java 默认不是 `public` 而是 `default`。

```scala
object PublicObject {
     val publicVal
     var publicVar
     def publicMethod = 1
}
```

## public

## private

## protected

Scala 的 `private` 一样可以工作在 Java 中，但 `protectd` 是明显不同的：

> * 第一个不同： protected可以有两种形态： protected 和 protected[foo]，foo 可以是一个类、包或者伴生对象。
>
> * 第二个不同： The second difference is that the non-parameterized protected for is only visible from subclasses not from the same package.

```scala
scala> class Class1 {
     | protected def pMethod = "protected"
     | }
defined class Class1

scala> class Class2 {
// pMethod is not accessible because Class2 is not a subclass of Class1
     | new Class1().pMethod
     | }
<console>:6: error: method pMethod cannot be accessed in Class1
       new Class1().pMethod
                    ^

scala> class Class3 extends Class1 {
// also unlike Java, protected restricts to the same object
     | new Class1().pMethod
     | }
<console>:6: error: method pMethod cannot be accessed in Class1
       new Class1().pMethod
                    ^

scala> class Class3 extends Class1 {
     | pMethod
     | }
defined class Class3
```

## 参考

* [Access modifiers (public, private, protected)](https://daily-scala.blogspot.jp/2009/11/access-modifiers-public-private.html)

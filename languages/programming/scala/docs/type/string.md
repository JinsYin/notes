# 字符串

在 Scala 中，字符串的类型实际上是 java.lang.String，它本身没有 String 类。

在 Scala 中，String 是一个不可变的对象，如果修改字符串就会产生一个新的字符串对象。

## 创建字符串

```scala
var str = "Hello World!"
```

## 格式化字符串

```scala
var floatVar = 12.456
var intVar = 2000
var stringVar = "Hello, world!"

println("浮点型变量为 " +
      "%f, 整型变量为 %d, 字符串为 " +
      "%s", floatVar, intVar, stringVar)
```

## String、StringBuffer 与 StringBuilder 之间区别

* 执行效率： StringBuilder >  StringBuffer  >  String

* String <（StringBuffer，StringBuilder）的原因

    String：字符串常量

    StringBuffer：字符串变量

    StringBuilder：字符串变量

String是"字符串变量"，也就是不可改变的对象。

StringBuffer 和 StringBuilder 是字符串变量，是可改变的对象

* 线程安全方面

  StringBuilder：非线程安全

  StringBuffer：线程安全

# 快速入门

Scala 依赖 JDK 环境，所以在使用 Scala 之前需要先安装 Java JDK 环境。目前我所用的 Java 版本是 `1.8.0`, Scala 版本是 `2.11.8`。

## 运行环境

```sh
$ java -version
java version "1.8.0_211"
Java(TM) SE Runtime Environment (build 1.8.0_211-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.211-b12, mixed mode)
```

* Host 环境

```sh
$ wget https://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz
```

```sh
$ scala -version
Scala compiler version 2.11.8 -- Copyright 2002-2016, LAMP/EPFL
```

* docker 环境

```sh
$ docker run -it --rm dockerce/scala:2.11.8 scala -version
```

## "HelloWorld" 程序

* 交互式环境

```scala
$ scala
scala> object HelloWorld {
    |   def main(args: Array[String]): Unit = {
    |     println("Hello, world!")
    |   }
    | }
defined object HelloWorld
scala> HelloWorld.main(Array())
Hello, world!
scala>:q
$
```

* HelloWorld.scala

```scala
object HelloWorld {
  def main(args: Array[String]): Unit = {
    println("Hello, world!")
  }
}
```

OR

```scala
object HelloWorld extends App {
  println("Hello, world!")
}
```

## 编译、运行

`scalac` 命令用来编译 Scala 源文件，并且生成可以在 JVM 中运行的 Java 字节码（bytecode），类似于 Java 编译器 `javac`。

```sh
$ scalac HelloWorld.scala
$ scala HelloWorld
```

```sh
$ mdkir classes
$ scalac -d classes HelloWorld.scala # 生成 class 文件到指定目录
$ scala -classpath classes HelloWorld # 指定 classpath
```

Scala 编译之后会生成和 Java 一样的 `.class` 文件。

```sh
$ tree
├── classes
│   ├── HelloWorld.class
│   └── HelloWorld$.class
├── HelloWorld.class
├── HelloWorld$.class
└── HelloWorld.scala
```

如果某个 object 继承了特质 `trait App`，那该 object 中的所有语句都将被执行；否则必须添加 `main` 方法作为程序的执行入口。

```scala
object HelloWorld extends App {
  println("Hello, world!")
}
```

## 脚本化

* script.sh

```sh
#!/usr/bin/env scala

object HelloWorld extends App {
  println("Hello, world!")
}

HelloWorld.main(args)
```

* 执行

```sh
$ chmod +x script.sh
$ ./script.sh
```

## 参考

* [](https://docs.scala-lang.org/tutorials/scala-for-java-programmers.html)

# 特质（Trait）

`trait` 被用来在类之间共享方法和字段，类似于 Java 8 的接口。`class` 和 `object` 可以继承 `trait`，但 `trait` 不能被实例化，因此不能有参数。

## 定义

```scala
trait HairColor
```

`trait` 因泛型（generic type）和抽象方法（abstract method）而变得特别有用。继承 trait Interator[A] 要求一个类型 A 和实现 hashNext 和 next 方法。

```scala
trait Iterator[A] {
    def hasNext(): Boolean
    def next(): A
}
```

## 使用

```scala
trait Iterator[A] {
    def hasNext: Boolean
    def next(): A
}

class IntIterator(to: Int) extends Iterator[Int] {
    private var current = 0
    override def hasNext: Boolean = current < to
    override def next(): Int = {
        if (hasNext) {
            val t = current
            current += 1
            t
        } else 0
    }
}

val iterator = new Iterator(10)
iterator.next() // prints 0
iterator.next() // prints 1
```

## Subtyping

```scala
import scala.collection.mutable.ArrayBuffer

trait Pet {
  val name: String
}

class Cat(val name: String) extends Pet
class Dog(val name: String) extends Pet

val dog = new Dog("Harry")
val cat = new Cat("Sally")

val animals = ArrayBuffer.empty[Pet]
animals.append(dog)
animals.append(cat)
animals.foreach(pet => println(pet.name))  // Prints Harry Sally
```

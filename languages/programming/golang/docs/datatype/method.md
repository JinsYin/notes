# 方法（Method）

方法本质是一个函数，在 `func` 关键字与方法名直接加入了特殊的接收器类型。接收器类型可以是结构体类型或者非结构体类型，接收器可以在方法内部访问。

```go
// 接收器类型为 Type 的方法
func (t Type) methodName(parameter list) {}
```

## 函数与方法

```go
package main

import "fmt"

type Person struct {
    name string
    age int
}

// 基于类型的方法（Person 是接收器类型，e 是接收器）
func (e Person) emthod() {
    fmt.Printf("%s %d\n", e.name, e.age)
}

// 函数
func function(e Person) {
    fmt.Printf("%s %d\n", e.name, e.age)
}

int main() {
    e := Person {
        name: "JinsYin",
        age: 26,
    }

    e.emthod() // 调用 Person 类型的 f1()

    function(e)
}
```

有了函数，为什么还需要类：

* Go 不是纯粹的面向对象编程语言，也不支持 “类”；基于类型的方法可以近似实现 “类” 的功能。
* 可以在不同类型上定义同名的方法，但不同定义同名的函数

## 值接收器与指针接收器

* 值接收器 => 值传递
* 引用接收器 => 引用传递

```go
package main

import (
    "fmt"
)

type Person struct {
    name string
    age int
}

func (e Person) changeName(name string) {
    e.name = name
}

func (e *Person) changeAge(age int) {
    e.age = age // (*e).age == e.age
}

func main() {
    e := Person{
        name: "jinsyin",
        age: 26,
    }

    e.changeName("Jins")
    fmt.Println(e.name) // jinsyin

    (&e).changeAge(18)
    fmt.Println(e.age) // 18
}
```

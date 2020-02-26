# 流程控制

## for

Go 语言只有一个循环结构，即 `for` 循环。需要注意的是，Go 语言的 `for` 语句没有小括号 `()`，但大括号 `{}` 是必须的。

`for` 循环包含三个以 `;` 分隔的组件：

    * 初始化语句：第一次迭代之前执行；通常是一句简短的变量声明，且该变量声明仅在 `for` 语句的作用域中可见。
    * 条件表达式：每次迭代之前进行判断；一旦条件表达式的值为 `false`，循环将被终止。
    * 后置语句：每次迭代之后执行

其中，初始化语句和后置语句都是可选的，当两者都省略后其实就相当于其他编程语言的 `while` 循环。如果三者都被省略，将进入无限循环。

* 范例

```go
package main

import "fmt"

func main() {
    sum := 1
    for sum < 1000 { // for ; sum < 1000; {
        sum += sum
    }
    fmt.Println(sum)

    // 无限循环
    for {
    }
}
```

## if

* 可以在条件表达式之前执行一个初始化语句，声明的变量的作用域仅在 `if` 和 `else` 语句范围内
* 表达式外不需要小括号 `()`，但大括号 `{}` 是必须的。

```go
package main

import (
    "fmt"
    "math"
)

func pow(x, n, lim float64) float64 {
    if v := math.Pow(x, n); v < lim {
        return v
    } else { // else 必须在 } 之后，如果换行编译器会自动在 } 后面插入分号
        fmt.Printf("%g >= %g\n", v, lim)
    }
    return lim
}

func main() {
    // 27 >= 20
    // 9 20
    fmt.Println(
        pow(3, 2, 10),
        pow(3, 3, 20),
    )
}
```

## Switch

`switch` 是一连串 `if - else if - else` 语句的简便方法。与其他编程语言不同的是，Go 语言只执行选定的 `case`，而非之后所有的 `case`（只有当所有 `case` 都不满足条件才会执行 `default` 语句），实际上是 Go 语言在每个 `case` 后面自动提供了 `break` 语句。若想要执行之后的 `case`，可以用 `fallthrough` 语句结束 case。另一点不同的是，`switch` 的 `case` 不必是常量，且取值不必是整数。

* 语法

`swtich` 的 `case` 语句从上到下依次执行，直到匹配成功为止。

```go
// 当 i == 0 时 f() 不会被调用
switch i {
case 0:
case f():
}
````

* 没有条件的 switch

没有条件的 switch 同 `switch true` 一样。

```go
switch {
case t.Hour() < 12:
    fmt.Println("Good morning.")
case t.Hour() < 17:
    fmt.Println("Good afternoon.")
default:
    fmt.Println("Good evening.")
}
```

* 范例

```go
package main

import (
    "fmt"
    "runtime"
)

func main() {
    fmt.Print("Go run on ")

    /*
        由于我是在 Linux 上执行的，所以输出结果为：Go runs on linux.
        注意：这里 default 语句块并没有被执行;
    */
    switch os := runtime.GOOS; os {
    case "darwin":
        fmt.Println("OS X.")
    case "linux":
        fmt.Println("Linux.")
    default:
        fmt.Printf("%s.", os)
    }
}
```

## Defer

`defer` 语句将其后调用的函数推迟到外层函数返回之后再执行。

* defer 栈

推迟的函数调用（function call）会依次入栈，当外层函数返回后，被推迟的函数会按 `后进先出` 的顺序依次被调用。

* 范例

```go
package main

import "fmt"

func main() {
    /*
        XXX
        BBB
        AAA
    */
    defer fmt.Println("AAA")
    defer fmt.Println("BBB")
    fmt.Println("XXX")
}
```

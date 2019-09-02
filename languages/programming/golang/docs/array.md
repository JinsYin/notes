# 数组（Array）

## 数组类型

数组类型定义了 **长度** 和 **元素类型**。类型 `[n]T` 表示 `n` 个 `T` 类型的值所组成的数组；其中，`n` 是数组的大小，`T` 是数组元素的类型。

* 声明

```go
// 语法
var a [n]T
```

```go
// 声明一个拥有 10 个整数的数组
var a [10]int
```

* 初始化

```go
// {} 中的元素个数可以小于等于数组长度，但 [] 中的数字必须和声明是相同
a = [10]int{1, 2, 3}
```

```go
// [...] 会根据数组元素个数自动推断数组大小
a = [...]int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
```

* 访问数组元素

不同于 C 语言，Go 的数组变量表示的是整个数组，而不是指向第一个元素的指针。当一个数组变量被赋值或被传递的时候，实际上会复制整个数组（如果要避免复制数组，可以传递一个指向数组的指针）。

```go
a[2] = 33
fmt.Println(a[2]) // 33

a = [10]{11, 22}  // 数组变量被赋值时，数组长度不能改变
fmt.Println(a)    // [11 22 0 0 0 0 0 0 0 0]
```

## 数组作为函数参数

切片实际上是一个指向数组的指针，通过切片可以实现数组的引用传递。由于数组变量表示的是整个数组，所以 Go 可以实现数组的值传递，缺点是它会限制函数的使用范围。

```go
package main

import "fmt"

func sum1(arr []int) int {
    s := 0
    for i := 0; i < len(arr); i++ {
        s += arr[i]
    }
    return s
}

func sum2(arr [3]int) int {
    s := 0
    for i := 0; i < len(arr); i++ {
        s += arr[i]
    }
    return s
}

func main() {
    arr1 := [3]int{1, 2, 3}
    arr2 := [4]int{1, 2, 3}

    //
    sum2 := sum(arr[:]) // 引用传递：切片 a[:] 是对数组 arr 的引用

    fmt.Println(sum)   // 6
}
```

* 形参指定了数组大小

```go
func myFunc(param [10]int) float32 {}
```

* 形参未指定数组大小

```go
func myFunc(param []int) float32 {}
```

示例：

```go
func avg(arr []int) float32 {
    var sum float32
    var size = len(arr)

    for i := 0; i < len(arr); i++ {
        sum += float32(arr[i])
    }

    return sum / float32(size)
}

func main() {
    var numbers = []int{1, 2, 3, 4, 5}
    fmt.Println(avg(numbers))
}
```
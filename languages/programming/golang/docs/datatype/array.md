# 数组（Array）

## 数组类型

**数组类型包含 “数组大小” 和 “元素类型” 两部分**，即数组大小会作为数组类型的一部分。类型 `[n]T` 表示 `n` 个 `T` 类型的值所组成的数组；其中，`n` 是数组的大小，`T` 是数组元素的类型。

* 声明

```go
// 语法
var a [n]T
```

```go
// 声明一个拥有 10 个整数的数组，元素的默认值为 int 类型的零值
var a [10]int
```

* 初始化

```go
// {} 中的元素个数可以小于等于数组长度，但 [] 中的数字必须和声明时相同
a = [10]int{1, 2, 3}
```

```go
// [...] 会根据数组元素个数自动推断数组大小
a = [...]int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
```

* 声明 + 初始化

```go
a := [10]int{4, 5, 6}

var b := [...]int{3, 2, 1}
```

* 访问数组元素

不同于 C 语言，Go 的数组变量表示的是整个数组，而不是指向第一个元素的指针。当一个数组变量被赋值或被传递的时候，实际上会复制整个数组（如果要避免复制数组，可以传递一个指向数组的指针）。

```go
a[2] = 33
fmt.Println(a[2]) // 33

a = [10]{11, 22}  // 数组变量被赋值时，数组长度不能改变
fmt.Println(a)    // [11 22 0 0 0 0 0 0 0 0]
```

## 值类型与引用类型

* 数组是值类型，数组变量表示整个数组
* 切片本质是一个指向数组的指针，通过切片可以实现数组的引用传递

## 数组作为函数参数

由于数组变量表示的是整个数组，所以 Go 可以实现数组的值传递，缺点是它会限制函数的使用范围。

```go
package main

import "fmt"

// 引用传递，支持任意长度的切片
func f1(arr []int) {
    arr[0] *= 10
}

// 值传递，只能接收 [3]int 类型的数组
func f2(arr [3]int) {
    arr[0] *= 100
}

func main() {
    arr := [4]int{4, 5, 6, 7}

    f1(arr[:])       // 引用传递：切片 arr[:] 是对数组 arr 的引用
    fmt.Println(arr) // [40, 5, 6, 7]

    f1(arr) // 不允许，[]int 与 [4]int 类型不同
    f2(arr) // 不允许，[3]int 与 [4]int 类型不同
}
```

* 形参指定了数组大小 —— 值传递（接收同类型的数组拷贝）

```go
func myFunc(param [10]int) float32 {}
```

* 形参未指定数组大小 - 引用传递（接收切片）

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

## range

`range` 结合 `for` 语句可实现遍历数组。

```go
package main

import "fmt"

func main() {
    arr := [...]int{11, 22}

    /*
     * 0 11
     * 1 22
     */
    for i, v := range arr {
        fmt.Println(i, v)
    }

    // 使用空白标识符忽略索引
    for _, v := range arr {
        fmt.Println(v)
    }
}
```

## 多维数组

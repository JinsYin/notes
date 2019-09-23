# 切片（Slice）

切片是对其底层数组的引用，它并不存储任何数据，仅仅是描述了底层数组的一段。因此修改切片元素会修改其底层数组中对应的元素，同时与它共享底层数组的切片也会感知到这些变化。

## 切片类型

类型 `[]T` 表示一个元素类型为 `T` 的切片类型。

* 声明

```go
var s []T
```

* 初始化

```go
// 直接初始化
var s []T = []T{element1, element2, ..., elementN}

// 通过数组进行初始化
// 它会从数组中选择一个半开区间 [low, high)；默认的下界（low）为 0，上界（high）为数组长度，使用默认值时可以省略上下界
var s []T = arr[low:high]

// 通过切片进行初始化
var s []T = sls[low:high]

// 通过内置函数 make() 进行初始化
var s []T = make([]T, length, capacity) // capacity 是可选参数
```

* 字面量

数组的长度是固定的，而切片类似于没有长度的数组。切片的零值为 `nil`，nil 切片的长度和容量都是 0 且没有底层数组。

```go
// 这是一个数组
[3]bool{true, true, false}

// 这会创建一个和上面相同的数组，并构建一个引用它的切片
[]bool{true, true, false}
```

## 内置函数

| 函数名                    | 说明                                                             |
| ------------------------- | ---------------------------------------------------------------- |
| len(s)                    | 获取数组或切片的长度                                             |
| cap(s)                    | 获取数组或切片的容量                                             |
| make([]T, len, cap)       | 创建一个动态大小的数组，并返回一个引用该数组的切片；cap 参数可选 |
| copy(dst, src)            | 拷贝原切片元素到新切片                                           |
| append(s []T, elems ...T) | 向原切片追加新元素，并返回新切片                                 |

切片的长度等于它所包含的元素个数。
切片的容量是从切片的第一个元素开始算起，直到其底层数组的最后一个元素这之间的元素个数，即 `cap(slice) == cap(underlyingArrayOfSlice) - lowBoundOfSlice`。

这些内置函数均来自内置的包 [builtin](https://golang.org/pkg/builtin)。

## 切片的切片

切片可以包含任何类型，包括其它的切片。

```go
board := [][]string{
    []string{"_", "_", _"},
    []string{"_", "_", _"},
    []string{"_", "_", _"}, // 这里有个逗号
}

board[1][1] = "X"
```

## 范例

```go
package main

import "fmt"

func main() {
    // nil 切片
    var s []int

    // 创建数组
    arr := [...]int{1, 2, 3, 4, 5}

    // 创建切片
    sls := []int{5, 4, 3, 2, 1}

    // 通过引用数组创建新的切片
    sls1 := arr[:]

    // 修改 sls1 切片元素后，arr 会被修改，并且 sls2 也会感知到 arr 的变化
    sls1[2] = 33

    // 通过截取数组创建新的切片（新切片容量 == cap(arr) - lowBound）
    sls2 := arr[2:]

    // 通过截取切片创建新的切片（新切片容量 == cap(sls) - lowBound）
    sls3 := sls[:3]

    // 通过内置函数 make() 创建新的切片
    sls4 := make([]int, len(sls), cap(sls)*2)

    // 通过添加新元素创建新的切片，这不会改变原切片；如果新元素的个数少于原切片的容量，新切片的容量
    sls5 := append(sls1, 6, 7)

    // 通过拷贝切片创建新的切片
    copy(sls4, sls)

    fmt.Printf("arr=%v len=%d cap=%d type=%T\n", arr, len(arr), cap(arr), arr)      // arr=[1 2 33 4 5] len=5 cap=5 type=[5]int
    fmt.Printf("sls=%v len=%d cap=%d type=%T\n", sls, len(sls), cap(sls), sls)      // sls=[5 4 3 2 1] len=5 cap=5 type=[]int
    fmt.Printf("sls1=%v len=%d cap=%d type=%T\n", sls1, len(sls1), cap(sls1), sls1) // sls1=[1 2 33 4 5] len=5 cap=5 type=[]int
    fmt.Printf("sls2=%v len=%d cap=%d type=%T\n", sls2, len(sls2), cap(sls2), sls2) // sls2=[33 4 5] len=3 cap=3 type=[]int
    fmt.Printf("sls3=%v len=%d cap=%d type=%T\n", sls3, len(sls3), cap(sls3), sls3) // sls3=[5 4 3] len=3 cap=5 type=[]int
    fmt.Printf("sls4=%v len=%d cap=%d type=%T\n", sls4, len(sls4), cap(sls4), sls4) // sls4=[5 4 3 2 1] len=5 cap=10 type=[]int
    fmt.Printf("sls5=%v len=%d cap=%d type=%T\n", sls5, len(sls5), cap(sls5), sls5) // sls5=[1 2 33 4 5 6 7] len=7 cap=10 type=[]int
    fmt.Println("nil!") // nil!
}
```

## 参考

* [Go 切片：用法和本质](https://blog.go-zh.org/go-slices-usage-and-internals)

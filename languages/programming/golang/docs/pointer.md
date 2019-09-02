# 指针（Pointer）

指针保存（指向）一个变量值的内存地址。

## 指针类型

类型 `*T` 是一个指向 `T` 类型值的指针类型，其对应的零值为 `nil`，即空指针。

```go
var p *int // p 指向 int 型变量值的指针
```

## `&` 运算符

`&` 运算符生成一个指向其操作数的指针，即操作数的内存地址。

```go
i := 123
p = &i // &i 返回 123 的内存地址
```

## `*` 运算符

`*` 运算符表示指针指向的底层值。

```go
fmt.Println(*p) // 通过指针 p 读取变量 i
*p = 321        // 通过指针 p 修改变量 i
```

这就是通常说的 `间接引用` 或 `重定向`。

## 指针数组

* 语法格式

```go
var ptr [SIZE]*variable_type
```

* 示例

```go
package main

import "fmt"

func main() {
    var ptr [3]*int
    var arr = []int{1, 2}

    for i := 0; i < len(arr); i++ {
        ptr[i] = &arr[i]
    }

    /*
        0 0xc420016150
        1 0xc420016158
        2 <nil>
    */
    for index, elem := range ptr {
        fmt.Println(index, elem)
    }
}
```
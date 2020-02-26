# 指针（Pointer）

指针保存（指向）一个变量值的内存地址。

## 指针类型

类型 `*T` 是一个指向 `T` 类型值的指针类型，其对应的零值为 `nil`，即空指针。

```go
var p *int // p 指向 int 型变量值
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

## 解引用

指针的解引用即获取指针所指向的变量的值。

`pointer` => `*pointer`

$$
pointer = \&(*pointer)
$$

## 指针变量作为函数参数

```go
func f(x *int) {}
```

## 数组指针

数组指针传递给函数（不推荐，建议使用切片）：

```go
func f(arr *[3]int) {
    (*arr)[0] *= 10  // 特注：(*arr)[x] = arr[x]
}

a := [3]int{1, 3, 5}
f(&a)
```

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

## 指针运算

Go 语言不支持指针运算（C 支持）。

```go
package main

import "fmt"

func main() {
    a := [...]int{1, 3, 5}
    p := &a
    fmt.Printf("%p %p\n", p, ++p) // unexpected ++, expecting expression
}
```

```c
#include <stdio.h>

int main() {
    int a[] = {1, 3, 5};
    int* p = a;
    printf("%p %p\n", p, ++p); // 0x7ffd65cf5b18 0x7ffd65cf5b10
}
```

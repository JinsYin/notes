# 包

## 创建自定义包

项目目录结构：

```txt
src
└── project-a
    └── pkgx
        └── mathx.go
    └── main.go
```

`mathx.go`:

```go
package pkgx // 在第一行声明当前源文件属于哪个包，通常包名与源文件所在的文件夹同名

func Max(x, y int) int { // 函数名首字母大小
    return x > y ? x : y
}
```

## 导入包

语法：

```go
import packagepath // 自定义包必须是相对于 $GOPATH/src 的路径
```

`main.go`：

```go
package main

import (
    "fmt"            // 导入内置包
    "project-a/pkgx" // 导入自定义包
)

func main() {
    a, b := 3, -3
    max := pkgx.Max(a, b) // 可见需要避免下定义同名函数
    fmt.Printf("%d\n", max);
}
```

## init 函数

每个包都可以包含一个或多个（分布于多个文件）`init` 函数，用于执行初始化任务，或者在开始执行之前验证程序的正确性。此外，`init` 函数不能显示地被调用。

```go
// 无参数、无返回值
func init() {}
```

包的初始化顺序：

1. 如果导入了其他包，则优先初始化被导入的包；导入多次，仅初始化一次
2. 初始化包级别（Package Level）的变量
3. 执行 `init` 函数；如果有多个，则按编译器解析顺序进行执行

## 空白标识符（Blank Identifier）

Go 不允许导入了包而不使用。如果确实需要先导入，暂不使用，可以使用空白标识符。

```go
package main

import (
    "fmt"            // 导入内置包
    "project-a/pkgx" // 导入自定义包
)

var _ = pkgx.Max // 错误屏蔽器


func main() {
}
```

```go
package main

import (
    _ "project-a/pkgx" // 仅进行初始化，但不使用包中的函数和变量
)

func main() {
}
```

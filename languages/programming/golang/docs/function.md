# 函数

## 内置函数

* `len`：计算（字符串，数组或者切片，map）长度
* `cap`：计算（数组或者切片，map）容量
* `close`：关闭通道
* `append`：追加内容到切片
* `copy`：拷贝数组/切片内容到另一个数组/切片
* `delete`：用于删除map的元素

## 递归函数

* 语法格式

```go
func recursion() {
    recursion() // 调用函数自身
}
```

递归函数必须设置退出条件，否则递归将陷入无限循环。

* 范例

```go
// 阶乘
func factorial(n uint64) uint64 {
    if n > 0 {
        return n * factorial(n-1)
    }
    return 1
}

// 斐波那契数列
func fibonacci(n int) int {
    if n >= 2 {
        return fibonacci(n-1) + fibonacci(n-2)
    }
    return n
}

func main() {
    for i := 0; i < 10; i++ {
       fmt.Printf("%d\t", fibonacci(i)) // 0    1    1    2    3    5    8    13    21    34
    }
}
```

## 参数列表/可变参数

```go
func f(a ...interface{}) {
}
```

* 原理是将可变参数转换为一个新的切片
* 只有函数的最后一个参数才允许是可变的
* 如果要将切片传入可变参数函数，可以在在切片后加上 `...` 后缀

```go
// elems 相对于一个 Type 类型的切片
func append(slice []Type, elems ...Type) []Type
```

## 命名返回值

下面两种方式是完全等价的。

```go
func f() (x int) { // 函数体中不能再声明变量 x
    return         // 返回值为 x
}
```

```go
func f() int {
    var x int
    return x
}
```

## 多返回值

```go
func cal(x, y int) (int, int) {
    var sum = x + y
    var diff = x - y
    return sum, diff
}
```

## 空白符

`_` 被用作空白符，可以表示任何类型的任何值。

```go
sum, _ := cal(3, 4)
```

## 命名法

驼峰命名法。

## 访问权限

常量、变量、函数、结构体名称的首字母大写，表示可以被导出，即允许被其他包访问
常量、变量、函数、结构体名称的首字母小写，表示不能被导出，即只能被本包访问

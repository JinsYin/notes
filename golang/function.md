# 函数

## 多返回值

## 内置函数

* `len`：计算（字符串，数组或者切片，map）长度
* `cap`：计算（数组或者切片，map）容量
* `close`：关闭通道
* `append`：追加内容到切片
* `copy`：拷贝数组/切片内容到另一个数组/切片
* `delete`：用于删除map的元素

## 递归函数

* 语法格式

```golang
func recursion() {
    recursion() // 调用函数自身
}
```

递归函数必须设置退出条件，否则递归将陷入无限循环。

* 范例

```golang
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

## 参数列表

```golang
func f(a ...interface{}) {
}
```

## 命名返回值

下面两种方式是完全等价的。

```golang
func f() (x int) { // 函数体中不能再声明变量 x
    return         // 返回值为 x
}
```

```golang
func f() int {
    var x int
    return x
}
```
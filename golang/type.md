# 类型

## 数据类型

### 基础数据类型

布尔类型：`bool`
整数类型：`int8` `uint8` `int16` `uint16` `int32` `uint32` `int64`  `uint64` `int` `uint` `rune` `byte` `complex128` `complex64`，其中，`byte` 是 `int8` 的别名
浮点类型：`float32` `float64`
字符串类型：`string`
字符类型： `rune`，是 `int32` 的别名
空： `nil`
万能类型： `interface{}`

其中，`int`、`uint` 和 `` 在 64 位系统上占用 64 位，在 32 位系统上占用 32 位。

### 更多数据类型

* [指针](pointer.md)
* [结构体](struct.md)
* [数组](array.md)
* [切片](slice.md)
* [Map](map.md)

## 零值

没有被显示初始化的变量会被赋予相应的 `零值`（zero value），也称为 `空值`。不同类型的变量会有不同的空值：

| 类型  | 对应空值 |
| 数值型 | `0`      |
| 布尔型 | `false`  |
| 字符串 | `""`     |
| Map 指针 | `nil` |

## 类型转换

类型转换用于将一种类型的变量转换为另一种类型的变量。

* 语法格式

```golang
T(v) // 将值 v 转换为类型 T
```

* 范例

```golang
func main() {
    var sum, count int
    var mean float32

    sum, count = 10, 3
    mean = float32(sum) / float32(count) // 分子分母都必须是 float32 类型

    fmt.Println(sum / count) // 3
    fmt.Println(mean)        // 3.3333333
}
```

## 类型推断

当声明一个不带显示类型的变量时，变量的类型会根据右侧的值自动推断。

当声明的右侧是有类型的，新变量的类型与其相同：

```golang
var i int
j := i // j is an int
```

当右侧包含一个无类型的数字常量时，新变量的类型取决于常量的精度：

```golang
i := 42           // int
f := 3.142        // float64
g := 0.867 + 0.5i // complex128
```
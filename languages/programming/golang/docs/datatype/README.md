# Go 数据类型

## 数据类型

### 基础数据类型

布尔类型：`bool`
整数类型：`int8` `uint8` `int16` `uint16` `int32` `uint32` `int64`  `uint64` `int` `uint` `rune` `byte` `complex128` `complex64`，其中，`byte` 是 `int8` 的别名
    * `int`：整数默认是 `int` 类型；在 32 位系统下是 `int32`，在 64 位系统下是 `int64`
浮点类型：`float32` `float64`（浮点数默认是 `float64` 类型）
字符串类型：`string`
字符类型： `rune`，是 `int32` 的别名
万能类型： `interface{}`
空： `nil`

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

```go
T(v) // 将值 v 转换为类型 T
```

* 范例

```go
a := 3
b := 3.5

sum1 := a + b      // 不允许（C 语言允许）
sum2 := a + int(b) // 强制类型转换，保持类型一致
```

## 类型推断

当声明一个不带显示类型的变量时，变量的类型会根据右侧的值自动推断。

当声明的右侧是有类型的，新变量的类型与其相同：

```go
var i int
j := i // j is an int
```

当右侧包含一个无类型的数字常量时，新变量的类型取决于常量的精度：

```go
i := 42           // int
f := 3.142        // float64
g := 0.867 + 0.5i // complex128
```

## 类型别名

```go
// 语法
type newtypename typename

// 示例
type ElemType int
```

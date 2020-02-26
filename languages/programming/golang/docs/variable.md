# 变量

## 定义

* 声明

默认使用相应类型的 Zero Value 自动初始化变量。

```go
// 语法
var name type

// 示例
var age int
```

* 声明并初始化

```go
// 语法
var name type = initialvalue

// 示例
var age int 25
```

* 类型推断（Type Inference）

根据初始值自动推断变量的类型。

```go
// 语法
var name = initialvalue

// 示例
var age = 25
```

* 声明多个变量

```go
// 语法
var name1, name2 type = initialvalue1, initialvalue2
```

* 声明多个不同类型的变量

```go
var {
    name = "jinsyin"
    age = 26
    height int
}
```

* 简短声明（Short Hand Declaration）

限函数内部。

```go
name := initialvalue
```

## 常量

常量使用 `const` 关键字来声明，但不能使用 `:=` 语法来声明初始化。常量的值在程序编译时确定，而函数调用发生在运行时，所以不能将函数的返回值赋值给常量。

```go
const Pi = 3.14
const name = "jins" // 所有双引号括起来的值都是字符串常量，且没有类型！

const str1 string = "jinsyin" // 带有类型的常量

var str2 = "jinsyin" // 有类型（当代码需要时提供一个相关联的默认类型）
```

# 结构体（Struct）

结构体是字段（field）的集合。定义好的结构体将作为新的类型来处理。

## 结构体类型

* 定义

```go
// Named Structure （结构体名首字母大写 => 可导出的类型 Exported Type）
type STRUCT_TYPE_NAME struct {
    field1 T1 // 字段名首字母大小 => Exported Type
    ......
    fieldn Tn
}
```

```go
// 匿名结构体（名称首字母小写）
var struct_name struct {
    field1 T1
    ......
    fieldn Tn
}
```

* 声明 + 初始化

结构体使用 `.` 来访问结构体字段。

```go
var struct_name STRUCT_TYPE_NAME // 声明命名结构体变量
struct_name.field1 = ...         // 初始化
struct_name.field2 = ...

// 声明 + 初始化
var struct_name STRUCT_TYPE_NAME{field1: ..., fieldn: ...}
```

* 示例

```go
// 定义
var Person struct {
    age int
    name string
}

// 声明 + 初始化
var person Person
person.age = 10
person.name = "jins"

// 声明时初始化（带有字段名）
var person Person{age: 20, name: "jins"}

var person Person{
    age: 20,
    name: "jins", // 如果 } 要换行则需要这个 ,
}

// 声明时初始化（没有字段名）
var person Person(20, "jins")
```

## 结构体指针

结构体字段可以通过结构体指针来访问。对于结构体指针 `pointer`，我们可以通过 `(*pointer).filed` 来访问结构体字段 `filed`，同时 Go 允许使用 `pointer.filed` 来代替显示的解引用 `(*pointer).field`。

```go
func main() {
    var person Person{age: 20, name: "jins"}
    var p *Persion

    // 返回一个指向结构体值的指针
    p = &person

    // 访问字段
    fmt.Println(person.name) // jins
    fmt.Println((*p).name)   // jins
    fmt.Println(p.name)      // jins
}
```

## 结构体数组/切片

* 结构体数组

```go
// 声明
var sa [3]Person
sa = { {20, "a"}, {21, "b"}, {22, "c"} }
```

```go
func main() {}
```

## 结构体零值

基础类型的零值的组合，限忽略的字段。

```go
```

## 匿名字段

```go
type Person struct {
    string // 字段名称与其类型同名
    int
}
```

## 相等性

**结构体是值类型**，如果两个结构体变量的对应字段均相等（前提是结构体字段是可比较的，比如 map 类型无法比较），则这两个结构体变量相等。

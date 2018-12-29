# 结构体（Struct）

结构体是字段（field）的集合。定义好的结构体将作为新的类型来处理。

## 结构体类型

* 定义

```golang
type STRUCT_TYPE_NAME struct {
    field1 T1
    ......
    fieldn Tn
}
```

* 初始化

结构体使用 `.` 来访问结构体字段。

```golang
// 声明 + 初始化
var struct_name STRUCT_TYPE_NAME
struct_name.field1 = ...
struct_name.field2 = ...

// 声明时初始化
var struct_name STRUCT_TYPE_NAME{field1: ..., fieldn: ...}
```

* 示例

```golang
// 定义
var Person struct {
    age int
    name string
}

// 声明 + 初始化
var person Person
person.age = 10
person.name = "jins"

// 声明时初始化
var person Person{age: 20, name: "jins"} // var person Person{20, "jins"}
```

## 结构体指针

结构体字段可以通过结构体指针来访问。对于结构体指针 `p`，我们可以通过 `(*p).X` 或 `p.X` 来访问结构体字段 `X`。

```golang
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

```golang
// 声明
var sa [3]Person
sa = {{20, "a"}, {21, "b"}, {22, "c"}}
```

```golang
func main() {
    var
}
```
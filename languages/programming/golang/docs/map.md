# map

`map` 是一种无序的键值对的集合。

## 定义

```go
// 声明
var map_variable map[key_type]value_type // 默认值为 nil

// 使用内置函数 make() 初始化 map
map_variable := make(map[key_type]value_type)
```

## 范例

```go
package main

import "fmt"

func main() {
    // 声明
    var amap map[string]string

    // 初始化
    amap = make(map[string]string)

    amap["a"] = "A"
    amap["b"] = "B"
    amap["c"] = ""

    /*
        key = a , value = A
        key = b , value = B
        key = c , value =
    */
    for key, value := range amap {
        fmt.Println("key =", key, ", value =", value)
    }

    mapContainsKey(amap, "b") // Key found value is B
    mapContainsKey(amap, "d") // Key not found

    // 不能通过值是否存在的方式来判断 key 是否存在
    fmt.Printf("val = %v, type= %T\n", amap["c"], amap["c"]) // val = , type= string
    fmt.Printf("val = %v, type= %T\n", amap["d"], amap["d"]) // val = , type= string

    // 删除 map 集合中的元素
    delete(amap, "c")

    /*
        key = a , value = A
        key = b , value = B
    */
    for key, value := range amap {
        fmt.Println("key =", key, ", value =", value)
    }
}

/*
    判断 map 中是否存在某个 key
    在 Go 语言中 if 语句可以包含一个条件语句和一个初始化语句
*/
func mapContainsKey(dict map[string]string, key string) {
    // val 要么是 dict[key] 的值，要么是零值（这里是空字符串）
    // ok 接收一个 bool 值
    if val, ok := dict[key]; ok {
        fmt.Println("Key found value is", val)
    } else {
        fmt.Println("Key not found")
    }
}

func containsKey(dict map[string]string, key string) bool {
    if _, ok := dict[key]; ok {
        return true
    }
    return false
}
```

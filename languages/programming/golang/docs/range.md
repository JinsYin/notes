# range

`range` 关键字用于 for 循环中迭代数组（array）、切片（slice）、通道（channel）、或集合（map）的元素。在数组和切片中返回元素的索引值，在集合中返回 key/value 对中的 key。

## 范例

```go
package main

import "fmt"

func main() {
    slice := []int{1, 4, 9}
    amap := map[string]string{"name": "jim", "age": "20"}

    fmt.Println(sliceSum(slice)) // 14
    printMap(amap)
    // name -> jim
    // age -> 20
}

func sliceSum(slice []int) int {
    sum := 0

    // _ 作为抛弃值，是一个只写变量，其实际值是切片索引；使用抛弃值的原因是 Go 语言中声明的变量必须被使用
    for _, elem := range slice {
        sum += elem
    }

    return sum
}

func printMap(amap map[string]string) {
    // 还可以省略第二个值
    for key := range amap {
        fmt.Printf("%s -> %s\n", key, amap[key])
    }
}
```

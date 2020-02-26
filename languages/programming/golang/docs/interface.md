# 接口（interface）

`interface` 是一种类型，它包含一组方法。如果一个类型实现了一个 interface 中所有方法，我们说类型实现了该 interface。Go 没有显式的关键字用来实现 interface，只需要实现 interface 包含的方法即可。

* empty interface

空接口，即不带任何方法的 interface。

## 定义

```go
type INTERFACE_NAME interface {
    METHOD_NAME1 [return_type]
    ......
    METHOD_NAMEX [return_type]
}
```

## 声明与实现

```go
type Person interface {

}
```

```go
package main
import (
    "fmt"
)

//interface definition

type VowelsFinder interface {
    FindVowels() []rune
}

type MyString string// MyString implements VowelsFinder

func (ms MyString) FindVowels() []rune {
    var vowels []rune
    for _, rune := range ms {
        if rune == 'a' || rune == 'e' || rune == 'i' || rune == 'o' || rune == 'u' {
            vowels = append(vowels, rune)
        }
    }
    return vowels
}

func main() {
    name := MyString("Sam Anderson")
    var v VowelsFinder
    v = name // possible since MyString implements VowelsFinder
    fmt.Printf("Vowels are %c", v.FindVowels())

}
```

# 字符串

Go 语言中的字符串是一个字节切片，而不是一个字符数组。

## 特性

* 字符串是不可变的

## 定义

```go
s := "Hello"

// 使用字节切片构造字符串
byteSlice := []byte{0x43, 0x61, 0x66, 0xC3, 0xA9}
str := string(byteSlice)
```

## for range

```go
for index, rune := range s
```

## 示例

```go
func printChars(s string) {
    for i := 0; i < len(s); i++ {
        fmt.Printf("%c ", s[i])
    }
}
```

# 字符串字面量（String literal）/字符串常量（String Constant）

字符串常量是用双引号 `"` 括起来的一个或多个字符构成的序列，例如 `"Hello"`。

## 字符串的类型

字符串的类型为 “字符数组（array of characters）”，存储类为 **static**。

## 字符串的内容

字符串常量包含和字符常量相似的字符：

* 普通字符（plain character）
* 转义序列（escape sequence）
* 通用字符（universal character）

## 表示形式

```c
// 形式一
"Hello, world"

// 形式二（使用 \ 分成多行）
"Hello, \
world"

// 形式三（使用空格分隔它们）
"hello, " "w" "ord"
```

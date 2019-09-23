# 空白符（White Space）

空白符（whitespace）是 C 语言中使用的术语。

可以使用 `<ctype.h>` 中的 `isspace` 库函数判断一个字符否为空白符（whitespace）。

## 种类

* 空格（blanks）
* 横向制表符（hirizontal tabs）
* 纵向制表符（Vertical tabs）
* 换行符（newlines）
* 换页符（formfeeds）
* 注释（comments）

空白符在程序中仅用来分隔记号，因此会被编译器忽略。相邻的标识符、关键字和常量之间需要使用空白符来分隔。

只包含空白（Whitespace），也可能带有注释的行，被称为空行（blank line），编译器会完全忽略它。

空白符（whitespace）将语句的一部分和另一部分分隔开，并使编译器能够识别语句中的每一个元素。形如：

```c
int age;                  // int 和 age 之间至少有一个空白符（通常是一个）
fruit = apples + oranges; // 为了增加可读性
```

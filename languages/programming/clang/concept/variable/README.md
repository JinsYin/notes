# 变量（Variable）

C 语言中，所有变量必须先声明后使用（即先声明后初始化）。

## 声明 & 定义 & 初始化

声明（declaration）通常放在函数起始处，在任何可执行语句（executable statement）之前。声明用于描述变量的属性，它由一个 `类型名` 和 一个 `变量列表` 组成。

声明的目的是为了告诉编译器变量的类型，并指示编译器在内存中为变量保留空间。

声明变量并不会为变量分配内存空间，它只发生在变量定义（definition）上。

* 变量的声明（Declaration）

声明用于指定变量、函数、类、命名空间等程序的名称。

未涉及内存的分配。可以多次声明。

```syntax
// 声明 a 是一个已经定义了的外部变量，变量类型可以去掉
extern int a;

// 函数的声明
int add (int p1, int p2);
```

Though you can declare a variable multiple times in your C program, it can be defined only once in a file, a function, or a block of code.

* 变量的定义（Definition）

涉及对变量的内存分配。仅可以定义一次。初始值是 **NULL**。

外部变量的定义在所有函数之外。

```syntax
data_type variable_name;
or
data_type variable1, variable2, …, variablen;
```

* 变量的初始化（Initialization）

变量初始化意味着为变量赋值。

```syntax
data_type variable_name=constant/literal/expression;
or
variable_name=constant/literal/expression;
```

可以在一个语句中用单个值初始化多个变量，如：`a=b=c=d=0`。

## 标识符（identifier）

C 语言的标识符是一个用于标识变量、函数或其他用户自定义项的名字。

C89 中，以字母（`A-Z`，`a-z`）开头（紧接着是零个或多个 `A-Z`、`a-z`、`0-9`）的字母和数字序列。

C99 中，以字母（`A-Z`，`a-z`）或下划线（`_`）开头（紧接着是零个或多个 `A-Z`、`a-z`、`0-9`、`_`）的字母和数字序列。

C 语言不允许在标识符中存在标点符号（如：`@`、`$`、`%`）。

C 语言是一种大小写敏感（case-sensitive）的编程语言，所以变量 abc、Abc 和 ABC 都不相同。

变量名由字母（`A-Z`、`a-z`）、数字（`0-9`）和下划线（`_`）组成，且必须以字母或下划线开头。

参考：

```plain
mohd       zara    abc   move_name  a_123
myname50   _temp   j     a23b9      retVal PI
```

## 示例

```c
#include <stdio.h>

int main()
{
    int x, y;   // 声明
    int z = 1;  // 初始化声明（依然遵循 “先声明后使用” 原则）

    // 默认值都是 0
    printf("x is %d, y is %d\n", x, y)

    x = 4; // 初始化
    y = 2; // 初始化

    printf("x is %d, y is %d, z is %d\n", x, y, z)

    return 0;
}
```

# 函数声明（Function declaration）

函数声明告诉编译器函数的名称、返回类型和函数参数。

## 语法

```c
返回值类型 函数名(0个或多个参数声明);
```

```c
Return_Type Function_Name(Parameter_List);
```

```c
int max(int x, int y);
```

在函数声明中参数名称并不重要，重要的是它们的类型。换句话说，函数声明中参数名称可以省略，或者使用跟函数定义不相同的名称：

```c
int max(int, int); // 有效

int max(int m, int n); // 有效
```

何时需要函数声明：

* 在一个源文件中定义函数而在另一个源文件调用该函数时（不同于 `#include` 预处理器，这种方式要求两个源文件一起编译）

需要在调用函数前声明该函数。

## 示例

* [函数调用](call.md)

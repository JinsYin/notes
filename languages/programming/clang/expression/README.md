# 表达式（Expression）

表达式由 _运算符（Operator）_ 和 _操作数（Operand）_ 组成。任何一个表达式，包括赋值表达式和函数调用表达式，都可以是一个语句。

C 语言中，整数除法运算将执行舍位，结果中的小数部分都会被舍弃。

```c
#include <stdio.h>

int main()
{
    printf("%d\n", 5 / 9); // 结果为 0
    return 0;
}
```

```c
#include <stdio.h>

int main()
{
    printf("%f\n", 5.0 / 9.0); // 结果为：0.555556
    return 0;
}
```

```c
#include <stdio.h>

int main()
{
    printf("%.3f\n", 5.0 / 9.0); // 结果为：0.556
    return 0;
}
```

## 两种表达式

* 左值（lvalue）表达式 - 引用了内存位置的表达式；左值可以出现在赋值的左侧或右侧
* 右值（rvalue）表达式 - 指的是在内存中某个地址的数据值；可能出现在右侧，不能出现在左侧

```c
int g = 20; // 变量是左值

10 = 20;    // 数字是右值
```

# 常量（Constant）

Constants refer to fixed values that the program may not alter during its execution. These fixed values are also called literals.

定义后不可以被修改。

常量的值叫做字面量（literal）。

## 分类

每一种常量都有一个数据类型。

* [整型常量](integer-const.md)
* [字符常量](character-const.md)
* [浮点常量](floating-const.md)
* [枚举常量](enumeration-const.md)

符号常量？

## 常量的定义方式

* 使用 **#define** 预处理器；`#define` 定义的常量也叫符号常量
* 使用 **const** 关键字

### 符号常量（Symbolic constant）

`#define` 指令可以将符号名（或称为符号常量）定义为一个特定的字符串：

```c
#define <标识符> <替换文本>
```

在该定义之后，程序中出现的所有在 `#define` 中定义的名字（既没有引号，也不是其他名字的一部分）都将用相应的替换文本替换。

符号常量名通常用大写字母拼写。

`#define` 指令行的末尾没有分号。

```c
#include <stdio.h>

#define PI 3.14
#define max(x, y) (x > y ? x : y)

// 计算圆的面积
int main()
{
    int r = 5; // 半径

    printf("%.1f\n", PI * r * r); // 78.5

    return 0;
}
```

### const 关键字

可以使用 **const** 前缀来声明具有特定类型的常量。

大写 -> 好习惯

```c
const <类型> <标识符> = <值>
```

```c
#include <stdio.h>

int main()
{
    const PI = 3.14;
    int r;
    int area;

    r = 3;
    area = PI * r * r;

    printf("value of area : %d\n", area);

    return 0;
}
```

## 参考

* [Characters in C](https://www.cs.swarthmore.edu/~newhall/unixhelp/C_chars.html)

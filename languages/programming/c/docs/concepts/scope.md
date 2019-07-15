# 作用域（Scope）

## 不同作用域的变量

* 局部变量
* 全局变量
* 形式参数

## 局部变量

在函数或代码块内部声明的变量称为 **局部变量**（Local Variables）。它们只能在该函数或代码块中被使用。

```c
#include <stdio.h>

// a、b、c 是 main() 函数的局部变量
int main()
{
    int a, b, c;

    a = 10;
    b = 20;
    c = a + b;

    printf("%d\n", c);

    return 0;
}
```

**定义局部变量时，系统不会初始化它，必须自己手动初始化它**。

```c
#include <stdio.h>

void func()
{
    int x;

    printf("%d\n", x);
}

int main()
{
    func();

    return 0;
}
```

## 全局变量

在所有函数外部（通常是在程序顶部）声明的变量，称为 **全局变量**（Global Variables）。全局变量在程序的整个声明周期保存其值，并且可以在为程序定义的任何函数内访问它们。

任何函数都可以访问全局变量。也就是说，全局变量在声明后可用于整个程序。

```c
#include <stdio.h>

int g;

void increase(int increment)
{
    g = g + increment;
}

void decrease(int decrement)
{
    g = g - decrement;
}

int main()
{
    printf("g: %d\n", g); // g: 0

    increase(10);
    printf("g: %d\n", g); // g: 10

    decrease(5);
    printf("g: %d\n", g); // g: 5

    return 0;
}
```

局部变量和全局变量可以有相同的名称，但函数内的局部变量的值将优先考虑。

```c
#include <stdio.h>

// 全局变量声明
int g = 20;

int main()
{
    // 局部变量声明
    int g = 10;

    printf("g: %d\n", g); // g: 10

    return 0;
}
```

## 形式参数

在函数定义中的参数，称为 **形式参数**（Formal Parameters）。形式参数可以看作是函数内的局部变量，它们优先于全局变量。

# 存储类（Storage Class）

存储类定义 C 程序中变量和/或函数的作用域（scope）和生命周期（life-time）。

## 种类

* auto
* register
* static
* extern

## auto 存储类

**auto** 存储类是所有局部变量（local variables）的默认存储类。`auto` 只能在函数内部使用。

```c
// 在同一存储类中定义了两个变量
{
    int mount;
    auto int mouth;
}
```

## register 存储类

**register** 存储类用于定义应该存储在寄存器（register）而不是 RAM 中的局部变量（local variables）。这意味着变量的最大大小等于寄存器大小（通常是一个 `word`），并且该变量不能使用一元运算符 `&`（因为它没有内存地址）。

```c
{
    register int miles;
}
```

`register` 仅应用于需要快速访问的变量，比如计数器。同时还应该注意，定义 `register` 并不意味着变量将存储在寄存器中，而是 **可能** 根据硬件和实现限制（implementation restrictions）存储在寄存器中。

```c
#include <stdio.h>

int main()
{
    register int counters;
    int i;  // 换成 "register int i;" 后结果完全不一样

    for (i = 0; i <= 100; i++)
         counters = counters + i;

    printf("%d\n", counters);

    return 0;
}
```

## static 存储类

**static** 存储类知识编译器在程序的生命周期内维持一个局部变量，而不是每次进出和超出作用域时创建和销毁它。因此，允许静态局部变量在函数调用之间维持它们的值。

**static** 修饰符（modifier）也可以用于全局变量，它会将变量的作用域限制在声明它的文件中，并且导致该成员的所有对象共享该成员的一个副本。

```c
#include <stdio.h>

// 函数声明
void func(void);

// 全局变量
static int count = 5;

int main()
{
    while (count--) // 试试 --count
        func();

    return 0;
}

// 函数定义
void func(void)
{
    // 本地 static 变量
    static int i = 5;
    i++;

    printf("i is %d and count is %d\n", i, count);
}
```

## extern 存储类

**extern** 存储类用于提供全局变量（对所有程序文件可见）的引用。使用 `extern` 时，无法初始化变量，但它将变量的名称指向先前已定义的存储位置。

`extern` 用于在另一个文件中 **声明** 全局变量或函数。

`extern` 修饰符通常用于在两个或多个文件中共享相同的全局变量或函数。

```c
// First File: main.c
#include <stdio.h>

int count;
extern void write_extern();

int main()
{
    count = 5;
    write_extern();
}
```

```c
// Second File: support.c
#include <stdio.h>

extern int count;

void write_extern(void)
{
    printf("count is %d\n", count);
}
```

```sh
# 编译两个文件（extern 用于在第二个文件声明 count，而在第一个文件定义 count）
$ gcc main.c support.c -o main
```

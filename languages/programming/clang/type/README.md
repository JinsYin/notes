# 数据类型（Data Type）

C 语言是一门强类型（strongly typed）语言。

C 语言的数据类型用于声明不同类型的变量或函数。变量的类型决定了它在存储中占用的空间大小以及如何解释存储的位模式（ bit pattern）。

## 基本类型（Basic Types）

基本类型指的是算术类型（arithmetic types），进一步分为整数类型（integer types）和浮点类型（floating-point types）。

| Type   | 类型                                | 存储大小（取值范围）                                                                |
| ------ | ----------------------------------- | ----------------------------------------------------------------------------------- |
| int    | 整型（integer type）                | * 通常反应所用机器中整数的最大自然长度 <br> * 16bit（-32768 ~ +32767） <br> * 32bit |
| short  | 短整型                              |                                                                                     |
| char   | 字符型                              | 8bit，可以存放本地字符集中的一个字符                                                |
| float  | 单精度浮点型（floating-point type） | * 32bit（至少有 6 位有效数字；`10^{-38} ~ 10^{+38}`）                               |
| double | 双精度浮点型                        |                                                                                     |

The C language provides the four basic arithmetic type specifiers char, int, float and double, and the modifiers signed, unsigned, short and long.

### 整型（integer types）

| Type           | Storage size | Value range                                          |
| -------------- | ------------ | ---------------------------------------------------- |
| char           | 1 byte       | -128 to 127 or 0 to 255                              |
| unsigned char  | 1 byte       | 0 to 255                                             |
| signed char    | 1 byte       | -128 to 127                                          |
| int            | 2 or 4 bytes | -32,768 to 32,767 or -2,147,483,648 to 2,147,483,647 |
| unsigned int   | 2 or 4 bytes | 0 to 65,535 or 0 to 4,294,967,295                    |
| short          | 2 bytes      | -32,768 to 32,767                                    |
| unsigned short | 2 bytes      | 0 to 65,535                                          |
| long           | 4 bytes      | -2,147,483,648 to 2,147,483,647                      |
| unsigned long  | 4 bytes      | 0 to 4,294,967,295                                   |

整数常量表明该常数是一个 int 型整数；带小数点的常数（如：5.0）表明该常数是一个单精度浮点数，而不是双精度浮点数。

unsigned int

数据类型的大小取决于具体的机器。为了在特定平台上获得类型或变量的确切大小，可以使用 **sizeof** 运算符。表达式 `sizeof(type)` 将以字节为单位返回对象（变量、函数等）或类型的存储大小，返回值的类型为 **long unsigned int**（等同于 `unsigned long int`；格式符：`%lu`）。

```c
#include <stdio.h>
#include <limits.h> // Sizes of integer types

int main()
{
    int c = 'a';
    printf("Storage size for int: %lu byte(s)\n", sizeof(int));
    printf("%d\n", c); // 97; char 也是整型！

    return 0;
}
```

### 浮点型（Floating-Point Types）

| Type        | Storage size | Value range            | 精确值         | 类型说明符 |
| ----------- | ------------ | ---------------------- | -------------- | ---------- |
| float       | 4 byte       | 1.2E-38 to 3.4E+38     | 小数点后 6 位  | `%f`       |
| double      | 8 byte       | 2.3E-308 to 1.7E+308   | 小数点后 15 位 | `%f`       |
| long double | 10 byte      | 3.4E-4932 to 1.1E+4932 | 小数点后 19 位 | `%f`       |

```c
#include <stdio.h>
#include <float.h>

int main()
{
    printf("Storage size for float : %d \n", sizeof(float));
    printf("Minimum float positive value: %E\n", FLT_MIN ); // %E 科学计数法
    printf("Maximum float positive value: %E\n", FLT_MAX );
    printf("Precision value: %d\n", FLT_DIG );

    return 0;
}
```

> 指针类型在 64 位机器上占用 8 个字节，在 32 位机器上占用 4 个字节（注：64位/32位指的是 CPU 通用寄存器的数据宽度）；CPU 与内存之间地址总线的宽度决定了指针类型的大小

## 枚举类型（Enumerated types）

## 派生类型（Derived types）

（貌似没有格式说明符）

* 数组（array types）
* 结构体（structure types）
* 枚举（Enumeration）
* 联合类型（union types）
* 指针类型（pointer types）
* 函数类型（function types） - 指函数返回值的类型

数组类型和结构体类型统称为聚合类型（aggregate types）

## void 类型

`void` 类型指的是没有可用的值。用于三种情况：

| 类型             | 描述                                          | 示例                                                                                        |
| ---------------- | --------------------------------------------- | ------------------------------------------------------------------------------------------- |
| 函数返回为 void  | 没有返回值的函数的返回类型为 void             | void exit(int status);                                                                      |
| 函数参数为 void  | 没有参数的函数可以接受 void                   | int rand(void);                                                                             |
| 指向 void 的指针 | `void *` 类型的指针代表对象的地址，而不是类型 | void *malloc(size_t size); <br>（返回一个指向 void 的指针，该指针可以转换为任何数据类型。） |

## 数组

### 字符数组

字符数组是 C 语言中最常用的数组类型。

## 强制类型转换

```c
```

## 初始默认值（零值）

当定义未初始化的变量，系统会使用默认值自动初始化它。

| 数据类型 | 零值 |
| -------- | ---- |
| int      | 0    |
| char     | \0   |
| float    | 0    |
| double   | 0    |
| pointer  | NULL |

最好养成正常初始化变量的习惯，因为为初始化的变量会在其内存位置产生一些垃圾值。

## 特殊类型

* size_t 类型 - 一种可以保存任何数组索引的类型

`sizeof()` 的返回值类型
`strlen()` 的返回值类型
`malloc()` 将 size_t 作为函数参数，确定了可以分配的最大大小。

```sh
# 结果因环境的不同而不同
$ echo | gcc -E -xc -include 'stddef.h' - | grep size_t
typedef long unsigned int size_t;
```

由于 size_t 的具体类型因环境而异，为了跨平台需要使用 `%zd`（十进制 size_t） 或 `%zx`（十六进制 size_t） 的格式说明符（format specifier），参考 [Platform independent size_t Format specifiers in c?](https://stackoverflow.com/questions/2125845/platform-independent-size-t-format-specifiers-in-c)

详见：<https://linux.die.net/man/3/printf> - length modifiers

## 格式占位符（Format Specifiers）

| 格式占位符 | 数据类型       |
| ---------- | -------------- |
| `%d`       | int            |
| `%f`       | float / double |
| `%c`       | char           |
| `%s`       | char[]         |
| `%p`       | 指针（地址）   |

```c
/*
 * MacOS(GCC) => 0x7ffeeb39190c 0x7ffeeb391910 0x7ffeeb391910 5
 */
int main()
{
    int arr[3] = {3, 4, 5};
    // 0x1 即一个存储单元，对于 int 数据而言是 4 个字节
    printf("%p %p %p %d\n", &arr[0], &arr[1], &arr[0] + 0x1, *(&arr[1] + 0x1));
    return 0;
}
```

## 参考

* [C data types](https://en.wikipedia.org/wiki/C_data_types)

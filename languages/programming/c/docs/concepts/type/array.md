# 数组（Array）

数组是一种数据结构，可以存储相同类型元素的固定大小的顺序集合。

## 特点

* 数组所有元素的类型相同
* 数组的大小是固定的
* 数组的内存地址是连续的
* 一个单独的数组名代表第一个元素的地址
* 数组越界将返回默认值

## 声明数组

```c
Type Array_Name[Array_Size]; // 一维数组
```

* Array_Size 必须是大于 0 的整数常量

```c
int a[10];
```

## 初始化数组

```c
// 一个一个地初始化
a[0] = 1;
a[1] = 2;
...
a[9] = 10;
```

```c
// 初始化声明（{} 之间元素的数量不能大于 [] 中的值）
int a[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

// 同上
int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
```

所有数组都将 0 作为其第一个元素的索引。数组的最后一个索引将是数组的总大小减 1 。

```plain
+---+     +---+     +---+     +---+     +---+     +---+     +---+     +---+     +---+     +----+
| 1 |     | 2 |     | 3 |     | 4 |     | 5 |     | 6 |     | 7 |     | 8 |     | 9 |     | 10 |
+---+     +---+     +---+     +---+     +---+     +---+     +---+     +---+     +---+     +----+
  0         1         2         3         4         5         6         7         8         9
```

## 数组大小和长度

* 数组大小

```c
// 数组大小、容量
size_t size = sizeof(a); // 单位：字节

// 数组长度（元素个数）
size_t length = sizeof(a) / sizeof(a[0]);
```

使用宏定义：

```c
#define LENGTHOF(arr) (sizeof(arr) / sizeof(arr[0])) // 返回值类型为 size_t
```

## 访问数组元素

数组元素可以通过索引（indexing）数组名来访问，例如 `a[0]`。如果索引值大于或等于数组大小，将返回数组类型所对应的默认值，而不是数组越界异常。

```c
int b = a[9];

int c = a[10]; // 返回 0，而不是数组越界异常
```

```c
#include <stdio.h>
#define LEN(arr) (sizeof(arr) / sizeof(arr[0])) // 返回值类型为 size_t

void printarray(int a[])
{
    size_t i;
    for (i = 0; i < LEN(a); i++)
        printf("a[%zu] = %d\n", i, a[i]);
}

int main()
{
    int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

    printarray(a);

    return 0;
}
```

## 数组作为函数参数

传递一维数组的数组名作为函数参数（本质上传递的是数组第一个元素的地址）。由于数组中的内存是连续的，您仍然可以使用指针算法（如（b + 1））指向第二个元素或等效 b[1]。可以用以下三种方式声明形式参数：

```c
void func(int* arr);  // 指向数组第一个元素的指针作为形参
```

```c
void func(int arr[10]); // 有大小的数组作为形参（实参数组的长度可以大于形参数组的长度）
```

```c
void func(int arr[]); // 无大小的数组作为新参
```

```c
#include <stdio.h>

/**
 * 打印一维数组
 * 必须传递数组长度，不能通过 sizeof(a)/sizeof(a[0]) 来获取，
 * 因为形参 arr 获取到的是数组第一个元素的地址
 */
void print_array(int *arr, size_t size)
{
    size_t i;
    for (i = 0; i < size; i++)
        printf("%zu\n", arr[i]);
}
```

## 从函数返回数组

C 语言不允许将整个数组作为参数返回给函数，但可以通过指定不带索引的数组名称来返回指向数组的指针。

C 语言不主张将局部变量的地址返回到函数外部，因此必须将局部变量定义为静态（static）变量。

```c
int *func() {}
```

```c
```

## 指向数组的指针

```c
double *p;
double balance[10];

p = balance;
```

## 数组越界

C 语言并没有规定数组访问越界时编译器该如何处理，导致程序可以自由访问所有内存空间，并且每次越界访问得到的值可能还不一样。

```c
int main(int argc, char* argv[]) {
    int arr[10] = {3, 4, 5};
    printf("%d\n", arr[100]);
    return 0;
}
```

## 内存地址

一维数组元素 `arr[i]` 的内存地址：

```c
// base_address 即 arr、arr[0] 的地址
arr[i]_address = base_address + i * type_size
```

二维数组元素 `arr[i][j]`（0 <= i < m，0 <= j < n） 的内存地址：

```c
// base_address 即 arr、arr[0][0] 的地址
a[i][j]_address = base_address + (i * n + j) * type_size
```

```c
/*
 * 从左到右、从上到下连续
 *
 * 0x7ffc1eb977e0   0x7ffc1eb977e4  0x7ffc1eb977e8
 * 0x7ffc1eb977ec   0x7ffc1eb977f0  0x7ffc1eb977f4
 */
int main() {
    int arr[2][3] = {{1, 2, 3}, {4, 5, 6}};
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            printf("%p\t", &arr[i][j]);
        }
        printf("\n");
    }
    return 0;
}
```

## 动态数组

在内存的 “堆” 中开辟地址空间，并且是在运行时开辟。

```c
#include <stdio.h>
#include <stdlib.h>

// 10 11 12 13 14 15 16 17 18 19
int main() {
    size_t n = 10;
    int* arr = (int *) malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) { // 数组越界无异常
        arr[i] = i + 10;
        printf("%d ", arr[i]);
    }
    return 0;
}
```

`malloc(size_in_bytes)` 的返回值为 `void *`，表示类型未知的指针，因此需要强制类型转换以确定将要存储的地址的类型。

## 二维数组（2D Arrays）

二维数组实质上是以一维数组为元素而组成的新数组。同理，三维数组是以二维数组为元素而组成的数组，以此类推。

* 声明

```c
type name[x][y];
```

* 数据结构

二维数组 `a[x][y]` 可以看作是具有 x 行 y 列的表。数组 `a[3][4]` 的数据结构如下：

```c
       Column0   Column1   Column2   Column3
     +---------+---------+---------+---------+
Row0 | a[0][0] | a[0][1] | a[0][2] | a[0][3] |
Row1 | a[1][0] | a[1][1] | a[1][2] | a[1][3] |
Row2 | a[2][0] | a[2][1] | a[2][2] | a[2][3] |
     +---------+---------+---------+---------+
```

* 初始化

```c
// 每一行使用嵌套的大括号 {}
// 若缺省元素会自动在相应行补默认值
int a[3][4] = {
    {1, 2, 3, 4},
    {5, 6, 7, 8},
    {9, 10, 11, 12},
};

// 省略行的嵌套大括号 {}
// 若缺省元素会自动在末尾补默认值
int a[3][4] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
```

* 访问数组元素

```c
#include <stdio.h>
#define LEN(arr) (sizeof(arr) / sizeof(arr[0]))

int main()
{
    // Row2 缺省两个元素
    int a[3][4] = {
        {1, 2, 3, 4},
        {5, 6},
        {9, 10, 11, 12},
    };

    size_t i, j;
    for (i = 0; i < LEN(a); i++)
        for (j = 0; j < LEN(a[i]); j++)
            printf("a[%zu][%zu] = %d\n", i, j, a[i][j]);

    return 0;
}
```

## 参考

* [Arrays are not the same as pointers!](https://brianbondy.com/blog/91/arrays-are-not-the-same-as-pointers)

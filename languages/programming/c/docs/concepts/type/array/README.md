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
// 数组大小
size_t size = sizeof(a); // 单位：字节

// 数组长度
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

传递一维数组（数组名）作为函数参数（本质上传递的是数组第一个元素的地址）。由于数组中的内存是连续的，您仍然可以使用指针算法（如（b + 1））指向第二个元素或等效b [1]。可以用以下三种方式声明形式参数：

```c
void func(int *param) {}  // 形式参数作为指针（指针指向数组第一个元素）
```

```c
void func(int param[10]) {} // 形式参数作为有大小的数组
```

```c
void func(int param[]) {} // 形式参数作为无大小的数组
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

## 参考

* [Arrays are not the same as pointers!](https://brianbondy.com/blog/91/arrays-are-not-the-same-as-pointers)

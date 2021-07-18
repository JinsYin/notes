# 函数调用（function call）

```c
函数名(0个或多个参数值);
```

当程序调用函数时，程序控制（program control）将被转移到调用函数。被调用函数执行已定义的任务，当执行其 return 语句或达到其函数结束右括号时，它将程序控制返回给主程序。

为了调用函数，需要传递必需的函数和函数名称，如果函数返回一个值，那么可以存储返回的值。

## 示例

* first.c

```c
#include <stdio.h>

// 函数声明
int max(int, int);

int main()
{
    int mx;

    // 函数调用
    mx = max(3, 4);

    printf("%d\n", m);

    return 0;
}
```

* second.c

```c
// 函数定义
int max(int x, int y)
{
    return x > y ? x : y;
}
```

* 编译

```sh
$ gcc first.c second.c -o exe
```

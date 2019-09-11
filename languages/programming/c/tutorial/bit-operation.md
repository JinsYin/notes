# 位运算

## 练习 · 判断一个数是奇数还是偶数

> 数学定义：凡是能被 2 整除的数都是偶数，反之则为奇数。

初级程序员：

```c
#include <stdio.h>

int main()
{
    int number;
    int result;

    scanf("%d", &number);
    result = number % 2; // 求余运算比较费力

    if(result == 0)
    {
       printf("%d is even\n", number);
    } else {
       printf("%d is odd\n", number);
    }
    return 0;
}
```

高级程序员：

```c
#include <stdio.h>

int main()
{
    int number;
    int result;

    scanf("%d", &number);
    result = number & 1; // “按位与”运算（奇数的二进制末位一定是 1，偶数的二进制的末位一定是 0）

    if(result == 0)
    {
        printf("%d is even\n", number);
    } else {
        printf("%d is odd\n", number);
    }
}
```

## 按位与运算

| A   | B   | A & B |
| --- | --- | ----- |
| 0   | 0   | 0     |
| 1   | 0   | 0     |
| 0   | 1   | 0     |
| 1   | 1   | 1     |
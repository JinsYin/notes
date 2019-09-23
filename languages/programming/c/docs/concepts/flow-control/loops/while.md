# while 循环

while 语句的循环体可以是用花括号 `{}` 括起来的一条或多条语句，也可以是不用花括号包含的单条语句。for 语句同理。

## 语法 & 流程图

* 语法

```c
while (A)  // condition expression
    B;     // single statement
```

```c
while (A) {  // condition expression
    B;       // single or multiple statement(s)
}
```

A 为 **non-zero** 或 **non-null** 时值为 **true**。

* 流程图

```graph
                  +------------------+
                  v                  |
+---------+     +-------+  true   +-----+
| (start) | --> |   A   | ------> |  B  |
+---------+     +-------+         +-----+
                  |
                  | false
                  v
                +-------+
                | (end) |
                +-------+
```

## 示例

```c
#include <stdio.h>

// 求 1 ~ 100 之间奇数的和
int main()
{
    int sum;
    int i;

    sum = 0;
    i = 100;

    while (i > 0) {
        // 使用 “按位与” 运算判断数字是否为奇数
        if (i & 1 == 1)
            sum = sum + i;
        i--;
    }

    printf("%d\n", sum);

    return 0;
}
```

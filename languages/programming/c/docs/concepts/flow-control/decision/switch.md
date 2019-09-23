# switch 语句

## 语法 & 流程图

* 语法

```c
switch (E) {    // expression
case C1:        // constant expression
    S1;         // single or multiple statement(s)
    break;      // optional
case C2:
    S2;
    break;
default:        // optional
    D;          // optional single or multiple statement(s)
}

F;
```

> `switch` 语句包含零个或多个 `case` 子语句，以及零个或一个 `default` 子语句，且可以两者都为空。
> S1、S2 可以是零个或多个语句，并且可以使用语句块符号 `{}` 括起来。
> case 的常量表达式必须与 switch 中的变量具有相同的类型
> default 语句总是被执行（假设没有 break），而不是当 case 语句都是 false 才执行

* 流程图

```graph
                                            break
                                 +---------------------------+
                                 |                           v
+---------+     +---+  E==C1   +----+  default   +---+     +---+     +-------+
| (start) | --> | E | -------> | S1 | ---------> | D | --> | F | --> | (end) |
+---------+     +---+          +----+            +---+     +---+     +-------+
                  |                                ^         ^
                  |                        default |         | break
                  |    E==C2   +----+              |         |
                  +----------> | S2 | -------------+---------+
                               +----+

```

## 示例

```c
#include <stdio.h>

/*
start
2
22
3
defualt
end
*/
int main()
{
    int a = 2;

    printf("start\n");

    switch (a) {
    case 1:
        printf("1\n");
    case 2:
        printf("2\n");
        printf("22\n");
    case 3:
        printf("3\n");
    default:
        printf("defualt\n");
    }

    printf("end\n");

    return 0;
}
```

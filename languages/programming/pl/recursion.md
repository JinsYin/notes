# 递归

## 死循环

已知正向数列 $a_{n} = a_{n-1} + 1$，求 $a_{n}$ 的通项公式。是不是感觉少个条件，少什么呢？少了一个 $a_{1}$ 的值。这里的 $a_{1}$ 便是退出条件，用于结束循环。

```c
int a(unsigned int n) {
    if (n == 0) exit(EXIT_FAILURE); // stdlib.h
    if (n == 1)
        return 1;
    return a(n - 1) + 1;
}
```

# 汇编代码（Assembly Code）

在线网站 [Compiler Explorer](https://godbolt.org) 可以将源代码转换成汇编代码。

```c
// C
int square(int num) {
    return num * num;
}
```

```assembly
square(int):
        push    rbp
        mov     rbp, rsp
        mov     DWORD PTR [rbp-4], edi
        mov     eax, DWORD PTR [rbp-4]
        imul    eax, DWORD PTR [rbp-4]
        pop     rbp
        ret
```

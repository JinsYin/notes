# stdio.h

stdio 即 standard input/output

C 语言本身并没有定义输入输出功能。常用的 `printf` 函数仅仅是标准库 `<stdio.h>` 中的一个有用的函数而已。

## 格式化输入/输出（Formatted input/output）

## 字符输入/输出（character input/output）

无论文本从何处输入，输出到何处，其输入/输出都是按 **字符流（character stream）** 的方式处理。**文本流** 是由多行字符构成的字符序列，而每行字符则由 0 个或多个字符组成，行末是一个换行符。标准库负责使每个输入/输出流都能够遵循这一模型。

* getchar() - 从文本流中读入下一个输入字符，并将其作为结果值返回
* putchar() - 打印一个字符（没有换行）

## EOF

```c
#include <stdio.h>

int main()
{
    printf("%d\n", EOF); // -1
}
```

## 参考

* [<cstdio> (stdio.h)](http://www.cplusplus.com/reference/cstdio/)

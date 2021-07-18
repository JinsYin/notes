# getchar & putchar

## 示例

* 文件复制（copy.c）

```c
#include <stdio.h>

// 版本一
void cp_v1()
{
    int c; // 不能用 char 的原因是还要存储文件结束符 EOF（它不是一个字符）

    c = getchar();
    while (c != EOF) // EOF: 文件结束指示符
    {
        putchar(c);
        c = getchar();
    }
}

// 版本二
void cp_v2()
{
    int c;

    while ((c = getchar()) != EOF)
        putchar(c);
}

int main()
{
    cp_v1();  // cp_v2();
    return 0;
}
```

```sh
# 编译
$ gcc copy.c -o copy

# 测试一
$ echo -e "hello\nworld" > README.md # 重定向输出
$ ./copy <README.md # 重定向输入
hello
world

# 测试二
$ ./copy
123 # 输入
123 # 输出
^D  # Ctrl+D （Linux 中 ^D 表示 EOF）
```

* 字符计数（charcount.c）

```c
#include <stdio.h>

long cc_v1()
{
    long count;

    for (count = 0; getchar() != EOF;)
        count++; // 效率比 “count = count + 1” 高

    return count;
}

long cc_v2()
{
    long count = 0;

    while (getchar() != EOF)
        count++;

    return count;
}

int main()
{
    long count;

    count = cc_v1(); // count = cc_v2();

    printf("%ld\n", count);
}
```

```sh
# 编译
$ gcc countofchar.c -o countofchar

# 测试
$ ./countofchar
1234 # 输入第一行
5678 # 输入第二行
10   # 按 Ctrl+D（表示文件换行符 EOF） 后的输出，上面每行有一个换行符
```

* 行计数（linecount.c）

```c
#include <stdio.h>

int main()
{
    int c;
    long line;

    line = 0;

    while ((c = getchar()) != EOF)
    {
        if (c == '\n')
            line++;
    }

    printf("%ld\n", line);
}
```

```sh
# 编译
$ gcc linecount.c -o linecount

# 测试
$ ./linecount
123456 # 输入第一行
abcdef # 输入第二行
2      # 按 Ctrl+D（表示文件换行符 EOF） 后的输出
```

* 单词计数（wordcount.c）

```c
#include <stdio.h>

int main()
{
    int c;

    while ((c = getchar()) != EOF)
    {

    }
}
```

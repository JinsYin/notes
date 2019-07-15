#include <stdio.h>

/*
 * 将输入复制到输出
 */
void copy()
{
    int c;

    while ((c = getchar()) != EOF)
    {
        putchar(c);
    }
}

/*
 * 将输入复制到输出，并将其中连续的多个空格用一个空格替换
 */
void format_copy()
{
    int c;
    char pre;

    while ((c = getchar()) != EOF)
    {
        // 仅当前字符和前一个字符都是空格时才不打印，否则都打印
        if (pre != ' ' || c != ' ')
            putchar(c);
        pre = c;
    }
}

/*
 * 测试代码： ./copy < README.md
 */
int main()
{
    format_copy();
    return 0;
}
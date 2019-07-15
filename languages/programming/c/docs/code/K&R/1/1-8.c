#include <stdio.h>

/*
 * 统计空格、制表符和换行符的个数
 */
long whitespace_count()
{
    int ch;
    long count;

    while ((ch = getchar()) != EOF)
        if (ch == ' ' || ch == '\t' || ch == '\n')
            count++;

    return count;
}

/*
 * 测试代码
 */
int main()
{
    long count;

    count = whitespace_count();
    printf("%ld", count);

    return 0;
}
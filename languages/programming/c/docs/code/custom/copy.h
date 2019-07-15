#include <stdio.h>

/*
 * 复制输入到输出
 */
void copy()
{
    int c;

    while ((c = getchar()) != EOF)
        putchar(c);
}

void cat()
{
}

/*
 * Unix cp 命令的基本实现
 */
void cp(char **argv)
{
}

/*
 * Unix echo 命令的基本实现
 */
void echo(int argc, char **argv)
{
    int i;

    for (i = 0; i < argv; i++)
        putchar(argv[i])
}
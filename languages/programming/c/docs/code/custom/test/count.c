#include <stdio.h>

/**
 * 测试代码
 * 用法1： ./count （^D 发送 EOF 给进程）
 * 用法2： ./count < README.md
 */
int main()
{
    long newline_count;

    newline_count = char_count('\t');
    printf("tab count: %ld\n", newline_count);
}
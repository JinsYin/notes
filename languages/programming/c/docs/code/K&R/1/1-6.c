#include <stdio.h>

/*
 * 验证表达式 “getchar() != EOF” 的是 0 还是 1
 */
int main()
{
    // 除了输入 Ctrl+D（代表 EOF） 外，其他输入的结果都是 1
    printf("The value is %d\n", (getchar() != EOF));

    return 0;
}
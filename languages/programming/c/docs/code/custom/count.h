#include <stdio.h>

/*
 * 统计字符个数
 */
long charcount()
{
    long count;

    count = 0L;
    while (getchar() != EOF)
        count++;

    return count;
}

/*
 * 统计特定字符（空格：''，制表符：'\t'，换行符：'\n'）的个数
 */
long charcount(char target)
{
    int ch;
    long count;

    count = 0L;
    while ((ch = getchar()) != EOF)
        if (ch == target)
            count++;

    return count;
}

/*
 * 统计字符数组中每个元素出现的次数
 */
long charcount(char *argv[])
{
    int ch;
    long count;

    count = 0;
    while ((ch = getchar()) != EOF)
        for (int i = 0; i < sizeof(argv); i++)
            if (ch == argv[i])
                count++;

    return count;
}

/**
 * 统计单词个数
 * 单词的简单定义：不包含空格、制表符或换行符的字符序列
 */
long wordcount()
{
    char pre; // 前一字符
    char cur; // 当前字符
    long count;

    count = 0L;
    while ((cur = getchar()) != EOF)
    {
        // 当前字符是 “非单词字符” 且前一字符是 “单词字符” 时，单词数增 1
        if ((cur == ' ' || cur == '\t' || cur == '\n') &&
            (pre && pre != ' ' && pre != '\t' && pre != '\n'))
            count++;
        pre = cur;
    }

    return count;
}

long wordcount_v2()
{
    int c;
    int label;  // 用于标记当前字符是否为 “单词字符”（1 是 0 否）
    long count; // 单词个数

    int pre;
    int cur;

    count = 0L;
    label = 0;

    while ((c = getchar()) != EOF)
    {
        if (c != ' ' && c != '\t' && c != '\n')
        {
            cur = 1;
        }
        else
        {
            count++;
            if (pre == 1)
                pre = cur = 0;
        }
    }

    return count;
}
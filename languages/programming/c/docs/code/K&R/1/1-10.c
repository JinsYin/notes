#include <stdio.h>

void unformated_copy()
{
    int c;

    while ((c = getchar()) != EOF)
    {
        switch (c)
        {
        case '\t':
            printf("\\t");
            break;
        case '\b':
            printf("\\b");
            break;
        case '\\':
            printf("\\\\");
            break;
        default:
            putchar(c);
        }
    }
}

int main()
{
    unformated_copy();
    return 0;
}
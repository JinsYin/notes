#include <stdio.h>

/*
 * $ cat /usr/include/stdio.h | grep '# define EOF' -C 1
 * #ifndef EOF
 * # define EOF (-1)
 * #endif
 */

/*
 * 编写一个打印 EOF 值的程序
 */
int main()
{
    // EOF is -1
    printf("EOF is %d\n", EOF);

    return 0;
}
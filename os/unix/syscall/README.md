# 系统调用（System call）

Unix 操作系统通过一系列的系统调用（system calls）提供服务，这些系统调用实际上是操作系统内核中的函数，它们可以被用户程序调用。我们经常需要借助于系统调用以获得更高的效率，或者访问标准库中没有的某些功能。

## 低级 I/O - read 和 write

Unix 的输入和输出是通过 **read** 和 **write** 系统调用实现的。在 C 语言程序中，可以通过函数 read 和 write 访问这两个系统调用（函数名多是有意和系统调用名相同的）。

```c
int n_read = read(int fd, char *buf, int n);
int n_written = write(int fd, char *buf, int n);
```

```c
// Unix
#include "syscalls.h"

int main()
{
    char buf[BUFSIZ];
    int n;

    while ((n = read(0, buf, BUFSIZ)) > 0)
        write(1, buf, n);

    return 0;
}
```

```c
// Linux
#include <unistd.h> // or: <sys/syscall.h>
#include <stdio.h>

int main()
{
    char buf[BUFSIZ]; // BUFSIZ 来自 stdio.h
    int n;

    while ((n = read(0, buf, BUFSIZ)) > 0)
        write(1, buf, n);

    return 0;
}
```

```sh
$ gcc io.c -o io

# 用法一
$ ./io
123 # 输入
123 # 输出

# 用法二
$ ./io <~/.viminfo
```
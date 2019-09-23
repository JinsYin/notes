# getpid()

获取调用进程的「进程 ID」（PID）。

## 手册

```sh
$ man 2 getpid
```

## 语法

```c
#include <sys/types.h>
#include <unistd.h>

/* 总是成功返回调用进程的 PID */
pid_t getpid(void);
```

* PID 是一个正数，用以唯一标识系统中的进程。
* 返回值的数据类型为 pid_t，该类型是有 SUSv3 所规定的整数类型，专门用于存储 PID

## 示例

```c
#include <unistd.h>
#include <stdio.h>

int main()
{
    pid_t pid = getpid();

    printf("PID=%d\n", pid);
    return 0;
}
```

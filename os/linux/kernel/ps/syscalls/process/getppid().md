# getppid()

获取调用进程的父进程的 PID 。

## 手册

```sh
$ man 2 getppid
```

## 语法

```c
#include <sys/types.h>
#include <unistd.h>

/* 总是成功返回调用进程的父进程的 PID */
pid_t getppid(void);
```

## 示例

```c
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>

int main()
{
    pid_t ppid = getppid();
    printf("%d\n", ppid);
    return 0;
}
```

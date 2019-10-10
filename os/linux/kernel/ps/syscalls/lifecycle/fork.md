# fork() - 创建一个新进程（子进程）

## 手册

```sh
$ man 2 fork
```

## 语法

```c
#include <unistd.h>

/*
 * 创建一个新进程（子进程）
 * 调用一次、返回两次，且父、子进程都以调用处为起点，继续执行调用处之后的所有代码
 *
 * @Return：失败则返回 -1；成功则在父进程中将返回子进程的 PID，而在子进程中返回 0
 */
pid_t fork(void);
```

调用失败的原因可能在于，进程数量要么超出了系统针对此「真实用户」（real user ID）在进程数量上施加的显示（RLIMIT_NPROC），要么是达到允许该系统创建的最大进程数这一系统级上限。

## 示例

```c
#include <unistd.h>
#include <stdio.h>

int main()
{
    pid_t fpid;
    printf("My PID=%d\n\n", getpid());

    /*
     * 这条语句之前，只有一个父进程在执行
     * 这条语句之后，父、子进程同时在执行，下一条语句都是 “if (fpid == -1)”
     */
    fpid = fork();

    /* 父、子进程都会执行 */
    if (fpid == -1)
        printf("error");
    else if (fpid == 0)
        printf("(child) PID=%d PPID=%d RETURN=%d\n", getpid(), getppid(), fpid);
    else
        printf("(parent) PID=%d PPID=%d RETURN=%d\n", getpid(), getppid(), fpid);

    /* 父、子进程都会执行 */
    printf("My PID=%d\n\n", getpid());
}
```

```sh
$ ./fork
My PID=1705958

(parent) PID=1705958 PPID=4026704 RETURN=1705959
My PID=1705958

(child) PID=1705959 PPID=1705958 RETURN=0 # 尝试多次，此处的 PPID 可能为 1
My PID=1705959
```

# 进程组和会话

进程组：是一组相关进程的集合
会话：是一组相关进程组的集合
前台进程组：
后台进程组：

## 进程组

每个进程都拥有一个以数字表示的进程组 ID，表示该进程所属的进程组。新进程会继承父进程的 PGID，使用 `getpgrp()` 能够获取一个进程的 PGID 。

```c
#include <unistd.h>
#include <stdio.h>

int main()
{
    pid_t pid = getpid();
    pid_t pgid = getpgrp();

    printf("PID=%d, PGID=%d\n", pid, pgid);
    return 0;
}
```

## 示例

* 分析各进程之间的进程组和会话关系

```sh
# 显示 shell 进程的 PID
$ echo $$
3208499

# 在后台进程组创建两个进程
$ find / 2> /dev/null | wc -l
[1] 3406981

# 在前台进程组创建两个进程
$ sort < longlist | uniq -c
```

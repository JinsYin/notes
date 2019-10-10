# getpgid()

## 示例

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

# setpgpid()

## 帮助

```sh
$ man 2 setpgid
```

## 定义

```c
#include <unistd.h>

/* 成功则返回 0，错误则返回 -1 */
int setpgid(pid_t pid, pid_t pgid);
```

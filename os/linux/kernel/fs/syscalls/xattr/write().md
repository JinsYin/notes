# write()

## 语法

```c
numwritten = write(fd, buffer, count);
```

## 参数

| 参数 | 描述 |
| ---- | ---- |

## 示例

```c
#include <string.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    char *msg = "Hello, world!\n";
    write(1, msg, strlen(msg));

    return 0;
}
```
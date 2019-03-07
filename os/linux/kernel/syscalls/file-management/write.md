# write

## 语法

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
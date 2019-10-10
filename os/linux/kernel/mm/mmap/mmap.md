# mmap() - 映射文件和设备到内存

## 语法

```c
#include <sys/mmap.h>

/*
 * 在调用进程的虚拟地址空间创建一个新的映射
 */
void *mmap(void *addr, size_t length, int prot, int flags,
            int fd, off_t offset);

int munmap(void *addr, size_t length);
```

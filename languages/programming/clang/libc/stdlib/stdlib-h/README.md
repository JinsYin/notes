# <stdlib.h>

内存管理：

| 函数        | 描述 |
| ----------- | ---- |
| `calloc()`  |      |
| `malloc()`  |      |
| `realloc()` |      |
| `free()`    |      |

* 必须检查 `calloc`、`malloc` 或 `realloc` 的返回值是否为 NULL，因为当内存不足时将返回 NULL

## calloc()

```c
// 动态分配 `num(数量) * size(字节)` 个字节的连续内存空间
void *calloc(size_t nitems, size_t size)

// 示例
char* ptr = (char *) calloc(10, sizeof(int));
```

* 每个字节默认初始化为 0
* 返回值是连续内存空间的起始地址（指针）

## malloc()

```c
// 动态分配 size 个字节的连续内存空间
void *malloc(size_t size);
```

* 内存空间未被初始化
* 返回值是连续内存空间的起始地址（指针）

## realloc()

```c
// 调整之前调用 malloc 或 calloc 时所分配（由 ptr 所指向的）的内存的大小
void *realloc(void *ptr, size_t new_size)
```

* 缩容（new_size < size）：释放末尾 size - new_size 字节大小的内存空间
* 扩容（new_size > size）
  * 如果原内存空间后面有足够内存，直接在尾部新增 new_size - size 字节大小的内存
  * 如果原内存空间后面无足够内存，重新分配一块 new_size 字节大小的内存空间，并将原内存中的数据复制到新内存

## free()

```c
// 释放之前调用 calloc、malloc 或 realloc 时所分配的内存空间
void free(void *ptr);
```

* 参数要么是 `NULL`，要么是 `malloc()`、`calloc()` 或 `realloc()` 返回的指针

## 参考

* [C — 动态内存分配之 malloc 与 realloc 的区别](https://www.cnblogs.com/tangshiguang/p/6735402.html)

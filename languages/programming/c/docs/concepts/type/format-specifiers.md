# 格式占位符

| 格式占位符 | 数据类型       |
| ---------- | -------------- |
| `%d`       | int            |
| `%f`       | float / double |
| `%c`       | char           |
| `%s`       | char[]         |
| `%p`       | 指针（地址）   |

## 示例

```c
/*
 * MacOS(GCC) => 0x7ffeeb39190c 0x7ffeeb391910 0x7ffeeb391910 5
 */
int main()
{
    int arr[3] = {3, 4, 5};
    // 0x1 即一个存储单元，对于 int 数据而言是 4 个字节
    printf("%p %p %p %d\n", &arr[0], &arr[1], &arr[0] + 0x1, *(&arr[1] + 0x1));
    return 0;
}
```

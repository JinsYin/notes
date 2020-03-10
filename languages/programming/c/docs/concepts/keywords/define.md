# #define

```c
#define LENGTHOF(arr) (sizeof(arr) / sizeof(arr[0]))
```

```c
#define CREATE_ARRAY(array_name, elem_t, size) static elem_t array_name[size]
```

```c
// swap(int, a, b)
// swap(char, a, b)
// 注：此次是引用传递
#define swap(type_t, x, y) ({ \
    type_t temp; \
    temp = x; \
    x = y; \
    y = temp; \
})
```

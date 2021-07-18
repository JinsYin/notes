# 预处理器（Preprocessor）

## 预处理器命令（Preprocessor commands）

```c
#include <stdio.h>  // 通知 C 编译器在实际编译之前导入标准库文件 stdio.h
#include "header.h" // 通知 C 编译器在实际编译之前导入本地头文件 header.h
```

## 预处理指令

| 预处理指令 | 描述                                  |
| ---------- | ------------------------------------- |
| `#define`  | 定义宏                                |
| `#undef`   | 取消宏的定义，即 `#define` 的反向操作 |

## 预定义宏

| 预定义宏   | 描述 |
| ---------- | ---- |
| `__FILE__` |      |

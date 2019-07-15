# 进程控制

* load
* execute
* end, abort
* create process (for example, fork on Unix-like systems, or NtCreateProcess in the Windows NT * Native API)
* terminate process
* get/set process attributes
* wait for time, wait event, signal event
* allocate/free memory

| 系统调用 | 描述                                                                                       |
| -------- | ------------------------------------------------------------------------------------------ |
| `fork()` | 父进程申请创建一个子进程，子进程获得父进程的 **数据段**、**代码段**、**堆**、**栈** 的拷贝 |
| `exit()` |                                                                                            |
| `wait()` |                                                                                            |

## 进程的内存空间

| 段（Segment）                       | 分配方式 | 描述                                                                                                                    |
| ----------------------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------- |
| 代码段（code segment/text segment） | 静态分配 | 用于存放程序执行代码的一块内存区域；程序运行前就已分配完成                                                              |
| 数据段（data segment）              | 静态分配 | 用于存放程序已初始化的全局变量的一块内存区域。数据段属于静态内存分配                                                    |
| BSS 段（bss segment）               | 静态分配 | 用于存放程序未初始化的全局变量的一块内存区域。数据段属于静态内存分配；BSS 即 Block Started by Symbolj，属于静态内存分配 |
| 堆（heap）                          | 动态分配 | 用于存放进程运行中被动态分配的内存区域，其大小可以动态伸缩；`malloc()`/`free()` 等系统调用是指在堆上扩张或缩减内存      |
| 栈（stack）                         |          | 用于存放程序临时创建的局部变量                                                                                          |

## 参考

* [浅谈程序中的 text 段、data 段和 bss 段](https://zhuanlan.zhihu.com/p/28659560)
* [C 程序的内存布局](https://wongxingjun.github.io/2015/07/25/C程序的内存布局/)
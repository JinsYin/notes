# 进程控制

* load
* execute
* end, abort
* create process (for example, fork on Unix-like systems, or NtCreateProcess in the Windows NT * Native API)
* terminate process
* get/set process attributes
* wait for time, wait event, signal event
* allocate/free memory

## 生命周期管理

| 系统调用 | 描述                                                                                                                        |
| -------- | --------------------------------------------------------------------------------------------------------------------------- |
| `fork()` | 父进程申请创建一个子进程，子进程获得父进程的 **数据段**、**代码段**、**堆**、**栈** 的拷贝（将父进程 PCB 复制到子进程 PCB） |
| `exit()` |                                                                                                                             |
| `wait()` |                                                                                                                             |
| `exec()` |                                                                                                                             |

## 进程标识符

| 系统调用                | 描述                    |
| ----------------------- | ----------------------- |
| [getpid()](getpid.md)   | 返回进程的进程号（PID） |
| [getppid()](getppid.md) | 返回父进程的进程号      |

## 参考

* [浅谈程序中的 text 段、data 段和 bss 段](https://zhuanlan.zhihu.com/p/28659560)
* [C 程序的内存布局](https://wongxingjun.github.io/2015/07/25/C程序的内存布局/)
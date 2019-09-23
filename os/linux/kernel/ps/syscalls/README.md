# 进程 · 系统调用

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

## 创建进程

* `fork()` - 创建当前进程（即父进程）的副本，父进程与子进程只有 PID 不同；使用了写时复制（copy on write）技术：将内存复制操作延迟到父进程或子进程向某内存页面写入数据之前，在只读访问的情况父进程和子进程共用同一内存页
* `exec()` - 将新程序加载到当前进程的内存中并执行。旧程序的内存页将释放，替换成新的数据，如何执行新程序。

## 进程标识符

| 系统调用                | 描述                    |
| ----------------------- | ----------------------- |
| [getpid()](getpid.md)   | 返回进程的进程号（PID） |
| [getppid()](getppid.md) | 返回父进程的进程号      |

## 参考

* [浅谈程序中的 text 段、data 段和 bss 段](https://zhuanlan.zhihu.com/p/28659560)
* [C 程序的内存布局](https://wongxingjun.github.io/2015/07/25/C程序的内存布局/)

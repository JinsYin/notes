# 内联函数（inline function）

函数会在其所调用的位置上展开。

好处：可以消除函数调用和返回所带来的开销（寄存器存储和恢复）
坏处：代码会变长，意味着占用更多的内存空间或者占用更多的指令缓存

Linux 内核开发者通常把那些对时间要求较高、本身长度较短的函数定义为内联函数。

## 定义

```c
static inline void wolf(unsigned long tail_size)
```

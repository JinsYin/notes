# 线程创建

线程的创建与普通进程的创建类似，只不过在调用 `clone()` 时需要传递一些参数标志来指明需要共享的资源。

```c
```
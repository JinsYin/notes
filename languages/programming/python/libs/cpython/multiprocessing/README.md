# multiprocessing 模块 - 基于进程的并发

## 概述

* 同时支持本地和远程并发
* 使用子进程代替线程，有效避免 GIL 带来的影响
* 允许程序员充分利用机器上的多个核心
* 支持 Unix 和 Windows

## Process 类

```python
from multiprocessing import Process
```

## 上下文和启动方法

multiprocessing 支持三种启动进程的方法：

| 方法       | 描述                                                                                                                                                                          | 支持平台                               |
| ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| spawn      | * 父进程启动一个新的 Python 解释器进程                                                                                                                                        | Unix、 Windows（默认设置）             |
| fork       |                                                                                                                                                                               | Unix（默认设置）                       |
| forkserver | * 父进程首先启动一个新的服务器进程 <br> * 当需要新进程时，父进程连接并请求服务器进程，由服务器进程创建一个新进程 <br> * 服务器子进程是单线程的，因此使用 `os.fork()` 是安全的 | Unix；支持通过 Unix 管道传递文件描述符 |

使用 `multiprocessing.set_start_method()` 方法设置启动方法，使用 `multiprocessing.get_context()` 获取上下文对象。

```python
import multiprocessing as mp

def
```

## 进程间通信

multiprocessing 支持进程间的两种通信通道：

### 队列

_multiprocessing.Queue_ 是线程和进程安全的，近似于 queue.Queue 的克隆。

### 管道

**multiprocessing.Pipe()** 函数返回一个由管道连接的连接对象，默认情况下是 **双工**（即能够同时收发）。

```python
```

如果两个进程（或线程）同时尝试读取或写入管道的同一端，则管道中的数据可能会损坏

## 进程间同步

```python
import os,time
import multiprocessing as mp

def f(l, i):
    l.acquire() # 获得锁
    time.sleep(1)
    print('pid: {}, num: {}'.format(os.getpid(), i))
    l.release() # 释放锁

if __name__ == '__main__':
    print('pid: {}'.format(os.getpid()))

    lock = mp.Lock()
    for num in range(10):
        mp.Process(target=f, args=(lock, num,)).start()

```

## 进程间共享状态

### 共享内存

### 服务器进程

## 范例

```python
```

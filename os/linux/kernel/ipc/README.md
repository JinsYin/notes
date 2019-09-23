# 进程间通信（IPC）

进程间通信（inter-process communication 或 interprocess communication，即 IPC）是操作系统提供的一种允许进程管理共享数据的机制。

* 命名管道（Named pipe） - 单向数据流
* Socket - 全双工

## 目录

* 管道和 FIFO
* IPC
  * POSIX IPC
  * System V IPC
* 消息队列
  * POSIX 消息队列
  * System V 消息队列
* 信号量
  * POSIX 信号量
  * System V 信号量
* 内存映射

## IPC 机制

* 在地址空间之间传输数据或信息
* 保护和隔离
* 提供灵活性和性能

## IPC 类型

| 类型     | 优点                           | 缺点                                     |
| -------- | ------------------------------ | ---------------------------------------- |
| 消息传递 | 操作系统管理信道               | 开销                                     |
| 共享内存 | 建立共享信道后操作系统不受阻碍 | 需要重新实现操作系统本可以完成的大量代码 |

## IPC 工具

![Unix IPC 工具分类](.images/unix-ipc-tools.png)

按功能分类：

| 类别 | 描述                                                 |
| ---- | ---------------------------------------------------- |
| 通信 | 关注进程之间的数据交换                               |
| 同步 | 关注进程和线程操作之间的同步                         |
| 信号 | 特定场景下可作为一种同步技术，甚至可作为一种通信技术 |

## IPC 途径

| 方式               | 描述 |
| ------------------ | ---- |
| File               |      |
| Signal             |      |
| Socket             |      |
| Unix domain socket |      |
| Message queue      |      |
| Pipe               |      |
| Named Pipe         |      |
| 共享内存           |      |
| 消息传递           |      |
| 内存映射文件       |      |

### 消息传递

![消息传递](.images/ipc-messagepassing.png)

* 操作系统提供通信信道线共享缓存区
* 进程向信道写入（发送）消息，或者从信道读取（接收）消息

### 共享内存

![共享内存](.images/ipc-sharedmemeory.png)

* 操作系统建立共享信道并将其映射到每个进程的地址空间
* 进程直接向此内存写入（发送）消息，或者从此内存读取（接收）消息

## 参考

* [Inter-process communication](https://en.wikipedia.org/wiki/Inter-process_communication)

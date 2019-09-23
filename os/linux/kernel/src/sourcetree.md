# Linux 内核源码树（Kernel Source Tree）

源码根目录下的目录和文件：

| 目录          | 描述                                       |
| ------------- | ------------------------------------------ |
| arch          | 特定体系结构的源码，如 alpha、arm、x86     |
| block         | 块设备 I/O 层                              |
| certs         |                                            |
| crypto        | 加密 API                                   |
| Documentation | 内核源码文档                               |
| drivers       | 设备驱动程序                               |
| fs            | VFS 和各种文件系统                         |
| include       | 内核头文件                                 |
| init          | 内核引导和初始化                           |
| ipc           | 进程间通信代码                             |
| kernel        | 内核核心子系统，如调度程序（schd）、cgroup |
| lib           | 通用内核函数                               |
| LISENCES      | 许可证                                     |
| mm            | 内存管理子系统和虚拟内存（vm）             |
| net           | 网络子系统                                 |
| samples       | 示例代码                                   |
| scripts       | 编译内核所用的脚本                         |
| security      | 内核安全模块                               |
| sound         | 语音子系统                                 |
| tools         | 内核开发中有用的工具                       |
| usr           | 早期用户空间代码（所谓的 initramfs）       |
| virt          | 虚拟化基础结构                             |

| 文件        | 描述                                     |
| ----------- | ---------------------------------------- |
| COPING      | 内核许可证                               |
| CRDITS      | 开发者列表                               |
| MAINTAINERS | 维护者列表，负责维护内核子系统和驱动程序 |
| Makefile    | 基本内核的 Makefile                      |

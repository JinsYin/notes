# TTY

## 界面（Interface）

* GUI - Graphic User Interface
* CLI - Command Line Interface

对于那些命令行 (CLI) 程序，终端模拟器会「假装」成一个传统终端设备；而对于现代的图形接口，终端模拟器会「假装」成一个 GUI 程序。一个终端模拟器的标准工作流程是这样的：

1. 捕获你的键盘输入；
2. 将输入发送给命令行程序（程序会认为这是从一个真正的终端设备输入的）；
3. 拿到命令行程序的输出结果（STDOUT 以及 STDERR）；
4. 调用图形接口（比如 X11），将输出结果渲染至显示器。

## 终端（Terminal）

* 终端 - 电传打字机（Teletype）：为了满足 Unix 多用户需求的输入输出设备（原本用于收发电报）

### 终端模拟器（Terminal Emulator）

* GNU/Linux: gnome-terminal, Konsole
* macOS: Terminal.app, iTerm2
* Windows: Win32 console, ConEmu

## 控制台（Console）

* 一种特殊的终端，与计算机主机是一体的，即计算机的组成部分。
* 用于管理主机（系统管理员使用），比普通终端拥有更大的权限
* 一台计算机一般只有一个控制台，但可以连接多个终端

## TTY1 ~ 7

| 类型        | 快捷键                 | 描述                     |
| ----------- | ---------------------- | ------------------------ |
| tty1 ~ tty6 | Ctrl + Alt + （F1-F6） | 文本型控制台             |
| tty7        | Ctrl + Alt + F7        | X Windows 图形显示管理器 |

## 参考

* [命令行界面 (CLI)、终端 (Terminal)、Shell、TTY，傻傻分不清楚？](https://segmentfault.com/a/1190000016129862)
* [TTY 的历史与工作原理](https://www.cnblogs.com/liqiuhao/p/9031803.html)
* [强悍的 Linux —— Linux 中 TTY 是什么意思](https://blog.csdn.net/lanchunhui/article/details/51580039)

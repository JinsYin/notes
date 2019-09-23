# 信号（Signal）

信号是一条非常短的消息，可以发送给一个进程或一组进程，只包含一个识别信号的号码。

_信号_ 是事件发生时对进程的通信机制，有时也称之为 _软件中断_。信号与硬件中断的相似之处在于打断了程序执行的正常流程，大多数情况下，无法预测信号到底的精确时间。

针对每个信号，都定义了一个唯一的整数，从 1 开始顺序展开。`<signal.h>` 以 `SIGxxx` 形式的符号名对这些整数做了定义。由于每个信号的实际编号因系统而异，所以在程序中总是使用符号名。

信号分为两大类：第一组信号用于内核向进程通知事件，构成传统或标准信号；另一组信号由实时信号构成。

信号因某些事件而产生。信号产生后，会稍后被传递给某一进程，而进程也会采取某些措施向相应信号。在产生和到达期间，信号处于等待（pending）状态。

产生信号的方式：

* 进程向另一进程发送信息 - 可作为一种同步技术，甚至是 IPC 的原始形式
* 进程向自身发送信号
* 内核向进程发送信号（大多数情况）

内核为进程产生信号的各类事件：

* 硬件出现异常 - 即硬件检测到一个错误条件并通知内核，随即再由内核发送相应信号给相关进程；例如，执行一条异常的机器语言指令（如被 0 除），或者引用了无法访问的内存区域
* 用户键入了能够产生信号的终端特殊字符；例如，在 bash 中 Ctrl+C 代表中断字符，Ctrl+Z 代表暂停字符
* 发送了软件事件 - 例如，针对文件描述符的输出变为有效，调整了终端窗口大小，定时器到期，进程执行的 CPU 时间超限，进程的某个子进程退出

```sh
$ man 7 signal
```

## LPI

* 基本概念
* 信号处理器函数
* 高级特性

* POSIX 信号量

## 分类

```base
$ kill -l
---------
 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
 2) SIGABRT      7) SIGBUS       8) SIGFPE       9) SIGKILL     10) SIGUSR1
1)   SIGSEGV     12) SIGUSR2     13) SIGPIPE     14) SIGALRM     15) SIGTERM
2)   SIGSTKFLT   17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
3)   SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU     25) SIGXFSZ
4)   SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGIO       30) SIGPWR
5)   SIGSYS      34) SIGRTMIN    35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3
6)   SIGRTMIN+4  39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
7)   SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12 47) SIGRTMIN+13
8)   SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14 51) SIGRTMAX-13 52) SIGRTMAX-12
9)   SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7
10) SIGRTMAX-6  59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
11) SIGRTMAX-1  64) SIGRTMAX
```

任何应用程序都不能捕获、处理 **SIGKILL** 信号，该信号完全有操作系统内核控制，而不由应用程序控制。

## 默认行为

| 默认行为 | 描述     |
| -------- | -------- |
| Term     | 终止进程 |
| Core     |          |
| Ign      |          |
| Stop     |          |

## 信号类型

| 信号名称 | 信号值   | 默认行为 | 描述                                                                          |
| -------- | -------- | -------- | ----------------------------------------------------------------------------- |
| SIGHUP   | 1        | Term     | Hangup detected on controlling terminal or death of controlling process       |
| SIGINT   | 2        | Term     | Interrupt from keyboard                                                       |
| SIGQUIT  | 3        | Core     | Quit from keyboard                                                            |
| SIGILL   | 4        | Core     | Illegal Instruction                                                           |
| SIGABRT  | 6        | Core     | Abort signal from abort(3)                                                    |
| SIGFPE   | 8        | Core     | Floating point exception                                                      |
| SIGKILL  | 9        | Term     | 必杀（sure kill）信号，处理程序无法对其进行捕获、忽略或阻塞，故而总能终止进程 |
| SIGSEGV  | 11       | Core     | Invalid memory reference                                                      |
| SIGPIPE  | 13       | Term     | Broken pipe: write to pipe with no readers                                    |
| SIGALRM  | 14       | Term     | Timer signal from alarm(2)                                                    |
| SIGTERM  | 15       | Term     | Termination signal                                                            |
| SIGUSR1  | 30,10,16 | Term     | User-defined signal 1                                                         |
| SIGUSR2  | 31,12,17 | Term     | User-defined signal 2                                                         |
| SIGCHLD  | 20,17,18 | Ign      | Child stopped or terminated                                                   |
| SIGCONT  | 19,18,25 | Cont     | Continue if stopped                                                           |
| SIGSTOP  | 17,19,23 | Stop     | Stop process                                                                  |
| SIGTSTP  | 18,20,24 | Stop     | Stop typed at terminal                                                        |
| SIGTTIN  | 21,21,26 | Stop     | Terminal input for background process                                         |
| SIGTTOU  | 22,22,27 | Stop     | Terminal output for background process                                        |

1 ～ 31 为标准信号，34 ～ 64 为实时信号。

## 发送信号

向 PID=1234 的进程发送 kill 信号：

```sh
$ kill -9 1234
# or
$ kill -KILL 1234
# or
$ kill -SIGKILL 1234
```



## 示例

```sh
# macOS
$ kill -l
 1) SIGHUP	   2) SIGINT	   3) SIGQUIT	   4) SIGILL
 5) SIGTRAP	   6) SIGABRT	   7) SIGEMT	   8) SIGFPE
 9) SIGKILL	  10) SIGBUS	  11) SIGSEGV	  12) SIGSYS
13) SIGPIPE	  14) SIGALRM	  15) SIGTERM	  16) SIGURG
17) SIGSTOP	  18) SIGTSTP	  19) SIGCONT	  20) SIGCHLD
21) SIGTTIN	  22) SIGTTOU	  23) SIGIO	      24)   SIGXCPU
25) SIGXFSZ	  26) SIGVTALRM   27) SIGPROF	  28) SIGWINCH
29) SIGINFO	  30) SIGUSR1	  31) SIGUSR2
```

```sh
# Linux
$ kill -l
 1) SIGHUP	     2) SIGINT	    3) SIGQUIT	    4) SIGILL	     5) SIGTRAP
 6) SIGABRT	     7) SIGBUS	     8) SIGFPE	     9) SIGKILL	    10) SIGUSR1
11) SIGSEGV	    12) SIGUSR2	    13) SIGPIPE	    14) SIGALRM 	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	    18) SIGCONT   	19) SIGSTOP	    20) SIGTSTP
21) SIGTTIN	    22) SIGTTOU	    23) SIGURG	    24) SIGXCPU	    25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	    28) SIGWINCH	29) SIGIO	    30) SIGPWR
31) SIGSYS	    34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX
```

## 参考

* [Sending signal to Processes](https://bash.cyberciti.biz/guide/Sending_signal_to_Processes)

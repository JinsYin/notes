# 信号（Signal）

信号是一条非常短的消息，可以发送一个进程或一组进程，只包含一个识别信号的号码。

* 基本概念
* 信号处理器函数
* 高级特性

* POSIX 信号量

## 分类

```base
$ kill -l
---------
 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
 6) SIGABRT      7) SIGBUS       8) SIGFPE       9) SIGKILL     10) SIGUSR1
11)  SIGSEGV     12) SIGUSR2     13) SIGPIPE     14) SIGALRM     15) SIGTERM
16)  SIGSTKFLT   17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
21)  SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU     25) SIGXFSZ
26)  SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGIO       30) SIGPWR
33)  SIGSYS      34) SIGRTMIN    35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3
38)  SIGRTMIN+4  39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
43)  SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12 47) SIGRTMIN+13
48)  SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14 51) SIGRTMAX-13 52) SIGRTMAX-12
53)  SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7
58) SIGRTMAX-6  59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
61) SIGRTMAX-1  64) SIGRTMAX
```

任何应用程序都不能捕获、处理 **SIGKILL** 信号，该信号完全有操作系统内核控制，而不由应用程序控制。

## 发送信号

向 PID=1234 的进程发送 kill 信号：

```bash
$ kill -9 1234
# or
$ kill -KILL 1234
# or
$ kill -SIGKILL 1234
```

## 参考

* [Sending signal to Processes](https://bash.cyberciti.biz/guide/Sending_signal_to_Processes)
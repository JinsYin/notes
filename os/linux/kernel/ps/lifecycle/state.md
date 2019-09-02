# 进程状态

| 状态标志             | 状态码 | 状态                                                                       | 描述                                                                                                                                                                        |
| -------------------- | ------ | -------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| TASK_RUNNING         | R      | 「正在运行」（Running）或「可运行」（Runnable，即在 run queue 中等待运行） | 对应于教科书中的 **运行**（RUNNING）和 **就绪**（READY）状态：<br> * 运行：进程获得 CPU 时间片 <br> * 就绪：进程已获得除 CPU 以外的其他系统资源（意味着也会消耗内存等资源） |
| TASK_INTERRUPTIBLE   | S      | 「可中断的睡眠」（Interruptible Sleep），亦称「阻塞」（Block）             | 进程等待某个事件发生或某个信号到达，一旦达成，进程状态变为 TASK_RUNNING；典型的是在程序中调用 `sleep()` 库函数                                                              |
| TASK_UNINTERRUPTIBLE | D      | 「不可中断的睡眠」（Uninterruptible Sleep），亦称「Disk Sleep」            | 类似于 Interruptible Sleep，不同的是即使进程接收到信号也不会被唤醒或切换为 Runnable（通常是 I/O 操作），即 **进程不可阻塞**，意味着无法杀死（`kill -9`）此类进程            |
| __TASK_STOPPED       | T      |                                                                            | 进程停止执行：进程没有投入运行也不能投入运行；通常发生在接收到 SIGSTOP、SIGTSTP、SIGTTIN、SIGTTOUT 等作业控制信号时，或者调试器暂停时收到任何信号                           |
| __TASK_TRACED        | T      |                                                                            | 进程被其他进程跟踪，例如通过 ptrace() 系统调用对调试程序进行跟踪                                                                                                            |
| EXIT_ZOMBIE          | Z      | 「僵尸」（Zombie）或 「Defunct」                                           | 进程调用 `do_exit()` 终止之后、其描述符从任务列表上删除之前所处的状态；详见「进程终止」                                                                                     |
| EXIT_DEAD            | X      | 「死亡」（Dead）（无法观测到）                                             | 进程调用 `do_exit()` 终止之后、以及从任务列表上删除之后所处的状态；详见「进程终止」                                                                                         |

## 状态查询

```sh
# TASK_RUNNING
$ STATUS_CODE="R" && ps aux | awk '$8=="$STATUS_CODE"' # R 状态需要尝试多次

# TASK_INTERRUPTIBLE
$ STATUS_CODE="S" && ps aux | awk '$8=="$STATUS_CODE"'
```

## 特殊字符

`ps aux` 等命令在输出 stat 关键字时，可能会显示额外的字符：

| 字符 | 描述                                    |
| ---- | --------------------------------------- |
| `<`  | 高优先级                                |
| `N`  | 低优先级                                |
| `l`  | 多线程，克隆线程                        |
| `L`  | 将页锁定在内存中（用于实时和自定义 IO） |
| `s`  | 一个 session leader                     |
| `+`  | 在前台进程组                            |

## 相似术语

* 就绪（ready） == 等待（waiting）== 可运行（runnable）
* 就绪队列（ready queue）== 运行队列（run queue）
* 可中断的睡眠（interruptible sleep） == 阻塞（block） ~= 睡眠（sleep）
* 睡眠（sleep）== 可中断的睡眠（interruptible sleep）+ 不可中断的睡眠（uninterruptible sleep）

> uninterruptible sleep 不可阻塞

## 内核代码

```c
/*
 * <include/linux/sched.h>
 */

/* Used in tsk->state: */
#define TASK_RUNNING			0x0000
#define TASK_INTERRUPTIBLE		0x0001
#define TASK_UNINTERRUPTIBLE	0x0002
#define __TASK_STOPPED			0x0004
#define __TASK_TRACED			0x0008
/* Used in tsk->exit_state: */
#define EXIT_DEAD			0x0010
#define EXIT_ZOMBIE			0x0020
#define EXIT_TRACE			(EXIT_ZOMBIE | EXIT_DEAD)
/* Used in tsk->state again: */
#define TASK_PARKED			0x0040
#define TASK_DEAD			0x0080
#define TASK_WAKEKILL		0x0100
#define TASK_WAKING			0x0200
#define TASK_NOLOAD			0x0400
#define TASK_NEW			0x0800
#define TASK_STATE_MAX			0x1000

/* Convenience macros for the sake of set_current_state: */
#define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
#define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
#define TASK_TRACED			(TASK_WAKEKILL | __TASK_TRACED)

#define TASK_IDLE			(TASK_UNINTERRUPTIBLE | TASK_NOLOAD)

/* Convenience macros for the sake of wake_up(): */
#define TASK_NORMAL			(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)

/* get_task_state(): */
#define TASK_REPORT			(TASK_RUNNING | TASK_INTERRUPTIBLE | \
					 TASK_UNINTERRUPTIBLE | __TASK_STOPPED | \
					 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
					 TASK_PARKED)
```

## 帮助

```sh
$ man ps | grep "^PROCESS STATE CODES$" -A 19
PROCESS STATE CODES
       Here are the different values that the s, stat and state output specifiers (header "STAT" or "S") will display to describe the state of a process:

               D    uninterruptible sleep (usually IO)
               R    running or runnable (on run queue)
               S    interruptible sleep (waiting for an event to complete)
               T    stopped, either by a job control signal or because it is being traced
               W    paging (not valid since the 2.6.xx kernel)
               X    dead (should never be seen)
               Z    defunct ("zombie") process, terminated but not reaped by its parent

       For BSD formats and when the stat keyword is used, additional characters may be displayed:

               <    high-priority (not nice to other users)
               N    low-priority (nice to other users)
               L    has pages locked into memory (for real-time and custom IO)
               s    is a session leader
               l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
               +    is in the foreground process group
```
# 进程资源限制（Resource limit）

Linux 提供了资源限制机制，用于对进程所使用的系统资源施加某些限制。

## 数据结构

`include/uapi/linux/resource.h`

```c
struct rlimit {
	__kernel_ulong_t	rlim_cur;
	__kernel_ulong_t	rlim_max;
};
```

* `rlim_cur` 指进程当前的资源限制，也称之为 _软限制（soft limit）_
* `rlim_max` 指该限制的最大值，也称之为 _硬限制（hard limit）_

## 系统调用

* `setrlimit()` - 调整系统限制
* `getrlimits()` - 检查当前限制

## 内核代码

`include/uapi/asm-generic/resource.h`：

```c
#define RLIMIT_CPU		0	/* CPU time in sec */
#define RLIMIT_FSIZE		1	/* Maximum filesize */
#define RLIMIT_DATA		2	/* max data size */
#define RLIMIT_STACK		3	/* max stack size */
#define RLIMIT_CORE		4	/* max core file size */

#ifndef RLIMIT_RSS
# define RLIMIT_RSS		5	/* max resident set size */
#endif

#ifndef RLIMIT_NPROC
# define RLIMIT_NPROC		6	/* max number of processes */
#endif

#ifndef RLIMIT_NOFILE
# define RLIMIT_NOFILE		7	/* max number of open files */
#endif

#ifndef RLIMIT_MEMLOCK
# define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
#endif

#ifndef RLIMIT_AS
# define RLIMIT_AS		9	/* address space limit */
#endif

#define RLIMIT_LOCKS		10	/* maximum file locks held */
#define RLIMIT_SIGPENDING	11	/* max number of pending signals */
#define RLIMIT_MSGQUEUE		12	/* maximum bytes in POSIX mqueues */
#define RLIMIT_NICE		13	/* max nice prio allowed to raise to
					   0-39 for nice level 19 .. -20 */
#define RLIMIT_RTPRIO		14	/* maximum realtime priority */
#define RLIMIT_RTTIME		15	/* timeout for RT tasks in us */
#define RLIM_NLIMITS		16
```

## 特定于进程的资源限制

| 常量              | 描述                                     |
| ----------------- | ---------------------------------------- |
| RLIMIT_CPU        | 最大的 CPU 时间（单位：秒）              |
| RLIMIT_FSIZE      | 最大的文件大小                           |
| RLIMIT_DATA       | 数据段的最大长度                         |
| RLIMIT_STACK      | （用户态）栈的最大长度                   |
| RLIMIT_CORE       | 核心转储文件的最大长度                   |
| RLIMIT_RSS        | RSS 段的最大长度                         |
| RLIMIT_NPROC      | 与进程所关联的用户可以拥有的进程最大数目 |
| RLIMIT_NOFILE     | 打开文件的最大数目                       |
| RLIMIT_MEMLOCK    | 不可换出页的最大数目                     |
| RLIMIT_AS         | 进程占用的虚拟地址空间的最大尺寸         |
| RLIMIT_LOCKS      | 文件锁的最大数目                         |
| RLIMIT_SIGPENDING | 待决信号的最大数目                       |
| RLIMIT_MSGQUEUE   | POSIX 消息队列的最大字节数               |
| RLIMIT_NICE       | 非实时进程的优先级（nice prio）          |
| RLIMIT_RTPRIO     | 最大的实时优先级                         |
| RLIMIT_RTTIME     |                                          |
| RLIM_NLIMITS      |                                          |

## init 进程

init 进程的限制在系统启动时生效，定义在 `include/asm-generic/resource.h` 中的 INIT_RLIMITS ：

```c
#define INIT_RLIMITS							\
{									\
	[RLIMIT_CPU]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
	[RLIMIT_FSIZE]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
	[RLIMIT_DATA]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
	[RLIMIT_STACK]		= {       _STK_LIM,  RLIM_INFINITY },	\
	[RLIMIT_CORE]		= {              0,  RLIM_INFINITY },	\
	[RLIMIT_RSS]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
	[RLIMIT_NPROC]		= {              0,              0 },	\
	[RLIMIT_NOFILE]		= {   INR_OPEN_CUR,   INR_OPEN_MAX },	\
	[RLIMIT_MEMLOCK]	= {    MLOCK_LIMIT,    MLOCK_LIMIT },	\
	[RLIMIT_AS]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
	[RLIMIT_LOCKS]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
	[RLIMIT_SIGPENDING]	= { 		0,	       0 },	\
	[RLIMIT_MSGQUEUE]	= {   MQ_BYTES_MAX,   MQ_BYTES_MAX },	\
	[RLIMIT_NICE]		= { 0, 0 },				\
	[RLIMIT_RTPRIO]		= { 0, 0 },				\
	[RLIMIT_RTTIME]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
}
```

## 当前进程

```sh
$ cat /proc/self/limits
Limit                     Soft Limit           Hard Limit           Units
Max cpu time              unlimited            unlimited            seconds
Max file size             unlimited            unlimited            bytes
Max data size             unlimited            unlimited            bytes
Max stack size            8388608              unlimited            bytes
Max core file size        0                    unlimited            bytes
Max resident set          unlimited            unlimited            bytes
Max processes             102400               102400               processes
Max open files            102400               102400               files
Max locked memory         65536                65536                bytes
Max address space         unlimited            unlimited            bytes
Max file locks            unlimited            unlimited            locks
Max pending signals       128407               128407               signals
Max msgqueue size         819200               819200               bytes
Max nice priority         0                    0
Max realtime priority     0                    0
Max realtime timeout      unlimited            unlimited            us
```

## 用户资源限制

```sh
$ vi /etc/security/limits.conf
# <domain>        <type>  <item>  <value>
```

```sh
$ ulimit -a
```

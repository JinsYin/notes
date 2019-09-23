# 进程生命周期（Process Lifecycle）

## 进程状态转换

![Process state](.images/process-state-switch.png)

| 切换过程      | 切换缘由                                                                        |
| ------------- | ------------------------------------------------------------------------------- |
| 就绪 --> 运行 | 调度器调度进程投入运行（即进程获得 CPU 时间）：schedule() 调用 context_switch() |
| 运行 --> 就绪 | 进程被优先级更高的进程抢占                                                      |
| 运行 --> 终止 | 1. 进程执行完成，调用 do_exit() 退出 <br> 2. 明确杀死该进程                     |
| 运行 --> 睡眠 | 为了等待特定事件，进程在等待队列（wait queue）中睡眠                            |
| 睡眠 --> 就绪 | 等待的事件发生后进程被唤醒并且被重新置入运行队列（run queue）中                 |
| 创建 --> 就绪 | 现有进程调用 fork() 创建一个新进程                                              |

## 设置进程状态

```c
/*
 * <include/sched.h>
 */
#define set_current_state(state_value)				\
	do {							\
		WARN_ON_ONCE(is_special_task_state(state_value));\
		current->task_state_change = _THIS_IP_;		\
		smp_store_mb(current->state, (state_value));	\
	} while (0)
```


## 命令

* `ps` - 报告当前进程的快照

## 示例

* 模拟可中断的睡眠状态（S）

```sh
# 窗口 1
$ sleep 100
```

```sh
# 窗口 2
$ ps aux | grep "[s]leep"
root       50793  0.0  0.0  11404   656 pts/9    S+   15:20   0:00 sleep 100
```

* 模拟不可中断的睡眠状态（D）

```sh
# 窗口 1
$ cat > uninterruptible.c <<EOF
int main() {
    vfork();
    sleep(60);
    return 0;
}
EOF

$ gcc uninterruptible.c -o uninterruptible
$ ./uninterruptible
```

```sh
# 窗口 2 （1min 以内的结果）
$ ps aux | grep "[u]ninterruptible"
yin       863582  0.0  0.0   4204   624 pts/16   D+   10:09   0:00 ./uninterruptible # 父进程
yin       863584  0.0  0.0   4204   624 pts/16   S+   10:09   0:00 ./uninterruptible # 子进程

# 窗口 2 （1min ~ 2min 之间的结果）
$ ps aux | grep "[u]ninterruptible"
yin       863582  0.0  0.0   4204   684 pts/16   S+   10:09   0:00 ./uninterruptible
yin       863584  0.0  0.0      0     0 pts/16   Z+   10:09   0:00 [uninterruptible] <defunct>

# 窗口 2 （2min 以后的结果：空）
$ ps aux | grep "[u]ninterruptible"
```

## 参考

* [TASK_KILLABLE: New process state in Linux](https://www.ibm.com/developerworks/linux/library/l-task-killable/)
* [Process state](https://en.wikipedia.org/wiki/Process_state)
* [Linux 进程状态](https://www.cnblogs.com/diegodu/p/9167671.html)

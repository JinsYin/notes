# SIGKILL(9)

## 不能 kill 的进程

两类进程：

* 僵尸进程 - 父进程没有读取其退出状态的进程 - `ps`|`top` 显示的状态为 `Z`
* 无间断休眠的进程 - `ps`|`top` 显示的状态为 `H` - 解决办法是重启或等待

详细描述：

* 只要拥有杀死进程的权限，`kill -9` 命令总是可以工作；所以编程语言（如 Python）几乎都没有具备处理 SIGKILL 信号的机制（也没法处理）
* root 用户可以发送 SIGKILL 信号给除 PID=1（`init` 进程）以外的所有进程，换句话说，root 用户可以杀死除 PID=1 外的所有进程
* `kill -9` 不保证立即工作，所有信号都是 **异步传递** 的：Kernel 可能会花些时间传递给它们
  * 通常传递信号最多需要几微秒，只需要目标进程获得时间片所需的时间
  * 如果目标进程已阻止信号，则信号将排队，直到目标解除阻塞
* 通常，进程无法阻止 SIGKILL，但内核代码可以在调用 syscall 时处理内核代码
* 进程不间断睡眠的经典案例是当服务器没有响应时通过 NFS 访问文件的进程。现代实现倾向于不强加不间断睡眠（例如在Linux下，intr mount选项允许信号中断NFS文件访问）。—— `man 5 nfs`

```bash
ps aux | awk '$8=="D"'
```

### 僵尸进程

* `ps` 或 `top` 输出状态显示为 `Z`
* 仅仅是进程表中的一个条目，保留它以便可以通知父进程其子进程的死亡
* 父进程死亡时，它们会消失

```bash
ps aux | awk '$8=="Z"'
```

### 解决办法

重启

## 示例

```bash
# 有一个僵尸进程 PID=124826
$ ps aux | awk '$8=="Z"'
root     124826  0.0  0.0      0     0 ?        Z    09:11   0:00 [gzip] <defunct>

# 该僵尸进程的父进程为 PID=124825
$ ps -ef | awk '$2=="124826"'
root     124826 124825  0 09:11 ?        00:00:00 [gzip] <defunct>

# 父进程是一个无间断休眠进程
ps aux | awk '$2=="124825"'
root     124825  0.0  0.0 123404  1212 ?        D    09:11   0:00 tar zcf 201206_compress_200m.tar.gz 201206_compress_200m
```

## 参考

* [What if 'kill -9' does not work?](https://unix.stackexchange.com/questions/5642/what-if-kill-9-does-not-work)
* [孤儿进程与僵尸进程(https://www.cnblogs.com/Anker/p/3271773.html)
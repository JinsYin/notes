# /proc/sys/kernel/pid_max

Linux 进程号（PID）的默认上限是 32767 。当 PID 达到 32767 ，系统会将 PID 重置为 300 ，而不是 1 ，因为低数值的 PID 几乎被系统进程和守护进程所长期占用，在此范围内搜索尚未被使用的 PID 等于浪费时间。

不过，可以通过 `/proc/sys/kernel/pid_max` 文件修改 PID 的上限（其值 = 最大进程号 + 1）

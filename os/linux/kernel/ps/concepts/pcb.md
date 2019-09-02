# 进程控制块（PCB）

![PCB](.images/process-pcb.png)

* 进程创建时，PCB 被创建
* 当进程状态改变时，更新某些字段
* 内核利用 PCB 来管理不同的进程
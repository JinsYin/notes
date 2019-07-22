# 线程（Thread）

* 介绍
* 线程同步
* 线程安全和线程存储
* 线程取消
* 更多细节

## 进程与线程

![进程与线程](.images/process-vs-thread.png)

## 并发控制和协调

* 相互排斥（mutual exclusion）
  * 一次只能访问一个线程
  * 互斥（mutex）
* 等待其他线程
  * 进行前的具体情况
  * 条件变量（condition variable）
* 从等待状态唤醒其他线程

## 线程数据结构

* 线程类型（Thread type）
* 线程 ID（Thread ID）
* PC
* SP
* 寄存器（Registers）
* 栈（Stack）
* 属性（Attributes）

## 互斥

```c
lock(mutex){
    //Critical Section
    //Only one thread can access at a time
}
unlock(mutex)
```

## 死锁（Deadlocks）
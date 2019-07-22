# ICMP 协议

互联网控制报文协议（Internet Control Message Protocol，缩写：**ICMP**）

## ICMP 报文格式

ICMP 报文是封装在 IP 包中的，因为在传输指令的时候，必须要有 `Source IP` 和 `Destination IP` 。

![ICMP 报文格式](.images/icmp-message.png)

字段说明：

| 类型（Type） | 代码（Code）                                                  |
| ------------ | ------------------------------------------------------------- |
| `0`          | * `0` = Echo Replay <br/> * `8` = Echo Request <br/> * ...... |
| `8`          | * `3` =                                                       |

ICMP 报文主要有两种类型，不同的 `类型（Type）` 有不同的 `代码（Code）`。

## ICMP 报文类型

* 查询报文类型（Query）
  * `Type 8`: Echo Request
  * `Type 0`: Echo Reply
* 差错报文类型（Error）
  * `Type 3`: 终点不可达
  * `Type 4`: 源点抑制
  * `Type 5`: 重定向（Redict）
  * `Type 11`: 超时
  * `Type 12`: 参数问题

## Ping

Ping 发出去的包符合 ICMP 协议格式，但新增了两个字段：

* 标识符：区分不同的任务
* 序号：对发出去的包进行编号，从而知道回来的包的数量

## 参考

* [《TCP/IP详解卷1：协议》第6章 ICMP：Internet控制报文协议-读书笔记](https://www.cnblogs.com/mengwang024/p/4442370.html)
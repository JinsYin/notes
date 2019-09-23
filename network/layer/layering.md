# 网络分层

只要在网络上跑的包，都是完整的。可以有下层没上层，绝对不可能有上层没下层。

## 分层目的

网络为什么要分层？

**网络分层是为了降低网络工作的复杂度**。

## 工作过程

层与层之间如何工作？

![工作过程](.images/layer-workflow.png)

接受过程：

1. 网卡接收到网络包后交由 **process_layer2(buffer)** 假函数（不真实存在，但功能存在）处理，该函数会将来自物理层的 Buffer 摘掉二层的头，再根据包头的内容确定下一步操作
2. 如果 MAC 地址与本地网卡相符，则需要调用 **process_layer3(buffer)** 假函数（此时的 Buffer 已不包含二层的头），该函数会摘掉三层的头，再根据包头的内容判断是发送给自己，还是转发出去
3. 如果该地址是 TCP 的，则调用 **process_tcp(buffer)** 假函数，该函数会摘掉四层的头，再根据包头判断这是一个发起，还是一个应答，又或者是一个正常的数据包
   * 如果是发起或应答，接下来可能要发送一个回复包
   * 如果是一个正常的数据包，则交给上层处理
4. 最后，操作系统将网络包交由应用程序处理（没有 **process_http(buffer)** 假函数）。交给哪个应用程序由四层包头的端口号决定，不同的应用程序监听不同的端口号

请求过程：

1. 操作系统调用 **send_tcp(buffer)** 假函数，Buffer 中包含 HTTP 的头和内容。该函数会增加一个 TCP 头，用来记录 `源端口` 和 `目标端口`
2. 操作系统调用 **send_layer3(buffer)** 假函数，Buffer 中包含 `TCP Header`、`HTTP Header` 和 `HTTP Body`。该函数会增加一个 IP 头，用来记录 `源 IP 地址` 和 `目标 IP 地址`
3. 操作系统调用 **send_layer2(buffer)** 假函数，BUffer 中包含 IP 头、TCP 头，以及 HTTP 的头和内容。该函数会增加一个 MAC 头，用来记录 `源 MAC 地址` 和 `目标 MAC 地址`
4. 只要 Buffer 内容完整，就可以从网口发出去了

## 参考

* [Why is it necessary to have layering in a network? How do two adjacent layers communicate in a layered network?](https://www.quora.com/Why-is-it-necessary-to-have-layering-in-a-network-How-do-two-adjacent-layers-communicate-in-a-layered-network)

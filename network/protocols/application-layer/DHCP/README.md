# DHCP

动态主机配置协议（Dynamic Host Configuration Protocol，缩写：`DHCP`）

网络管理员只需要配置一段 `共享的 IP 地址池`，新加入的机器都通过 DHCP 协议到这个共享的 IP 地址池申请，操作系统会为网卡自动配置相应的 IP，待机器不用了再还回去。

## 工作方式

1. 新机器加入一个网络时，一头雾水，仅知道自己的 MAC 地址
2. 先吼一声：“我来了，有人吗？”，这个吼的过程叫做 `DHCP Discover`
3. 新加入的机器会使用 IP 地址 `0.0.0.0` 发送一个 `广播包`，目标 IP 地址为 `255.255.255.255`；广播包封装了 `UDP`，UDP 封装了 `BOOTP`（Bootstrap Protocol）；其实 DHCP 是 BOOTP 的增强版，但是抓包时很可能看到的是 BOOTP 协议
4. 广播包中，新人大喊：我是新来的（`Boot request`），我的 MAC 地址是这个，我还没有 IP 地址，谁租给我一个 IP 地址；格式如下

| 模型层 Header | 内容                                               |
| ------------- | -------------------------------------------------- |
| MAC Header    | 新人的 MAC；广播的 MAC（`ff:ff:ff:ff:ff`）         |
| IP Header     | 新人的 IP：`0.0.0.0`；广播的 IP：`255.255.255.255` |
| UDP Header    | 源端口：`68`；目标端口：`67`                       |
| BOOTP Header  | `Boot request`                                     |
| ~             | 我的 MAC 是这个，我还没有 IP                       |

（MAC 地址唯一的重要性：只有 MAC 地址唯一，DHCP Server 才知道这是一个新人）

5. 只有 IP 地址唯一，DHCP Server 才会租给新机器一个 IP 地址，这个过程称为 **DHCP Offer**；DHCP Offer 的格式如下（包含给新人分配的地址）：

| 模型层 Header | 内容                                                                                                   |
| ------------- | ------------------------------------------------------------------------------------------------------ |
| MAC Header    | DHCP Server 的 MAC；广播的 MAC（`ff:ff:ff:ff:ff:ff`）                                                  |
| IP Header     | DHCP Server 的 IP（如：`192.168.1.2`）；广播的 IP（`255.255.255.255`）                                 |
| UDP Header    | 源端口：`67`；目标端口：`68`                                                                           |
| BOOTP Header  | `Boot reply`                                                                                           |
| ~             | 这是你的 MAC，我分配了这个 IP 租给你，你看如何（除了 IP 外，还有子网掩码、网关和 IP 地址租用期等信息） |

6. 如果网络中有多个 DHCP Server，新机器会收到多个 IP 地址，并从中选择一个 DHCP Offer，一般会选择最先到达那个，并向网络发送一个 DHCP Request 广播包，包中包含客户端的 MAC 地址、接受的租约中的 IP 地址、提供租约的 DHCP Server 的地址等；并告诉所有 DHCP Server 它将接受哪一台服务器提供的 IP 地址，告诉其他 DHCP Server，谢谢你们的接纳，并请求撤销它们提供的 IP 地址，以便提供给下一个 IP 租用请求者；DHCP Request 格式：

| 模型层 Header | 内容                                                      |
| ------------- | --------------------------------------------------------- |
| MAC Header    | 新人的 MAC；广播的 MAC（`ff:ff:ff:ff:ff:ff`）             |
| IP Header     | 新人的 IP：`0.0.0.0`；广播的 IP（`255.255.255.255`）      |
| UDP Header    | 源端口：`68`；目标端口：`67`                              |
| BOOTP Header  | `Boot request`                                            |
| ~             | 我的 MAC 是这个；我准备租用这个 DHCP Server 给我分配的 IP |

7. DHCP Server 接收到客户机的 DHCP request 之后，会广播返回给客户机一个 `DHCP ACK` 消息包，表明已经接收客户机的选择，并将这一 IP 地址的合法租用信息和其他配置信息都放入广播包，发给客户机；最终租约达成的时候，还是要广播一下，让大家都知道；DHCP ACK 格式如下：

| 模型层 Header | 内容                                                        |
| ------------- | ----------------------------------------------------------- |
| MAC Header    | 新人的 MAC；广播的 MAC（`ff:ff:ff:ff:ff:ff`）               |
| IP Header     | 新人的 IP：`0.0.0.0`；广播的 IP（`255.255.255.255`）        |
| UDP Header    | 源端口：`67`；目标端口：`68`                                |
| BOOTP Header  | `Boot replay`                                               |
| ~             | DHCP ACK：这个新人的 IP 是我这个 DHCP Server 组的，租约在此 |

## IP 地址的收回和续租

租期到了以后，如果客户机不用了，DHCP Server 会将 IP 收回；如果还要续租，客户机需要在租期过去 `50%` 的时候，直接向为其提供 IP 地址的 DHCP Server 发送 `DHCP request` 消息包。客户机收到该服务器回应的 `DHCP ACK` 消息包，会根据包中所提供的新租约以及其他已经更新的 TCP/IP 参数，更新自己的配置。

## 参考

* [BOOTP](https://zh.wikipedia.org/wiki/BOOTP)
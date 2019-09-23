# PROTOCOL - 命令行生成 ASCII 网络协议头

## 安装

```sh
git clone https://github.com/luismartingarcia/protocol.git
cd protocol/
sudo ./setup.py install
```

## 用法

```sh
# 形式
$ protocol {<protocol> or <spec>} [OPTIONS]
```

参数：

* `<protocol>`：已支持的协议名称
* `<spec>`：自定义协议规范

选项：

| OPTION               | Description                                          |
| -------------------- | ---------------------------------------------------- |
| `-b, --bits <n>`     | 每一行的 bit 数，默认是 32                           |
| `-f, --file`         | Read specs from a text file                          |
| `-h, --help`         | Displays this help information                       |
| `-n, --no-numbers`   | Do not print bit numbers on top of the header        |
| `-V, --version`      | Displays current version                             |
| `--evenchar <char>`  | Character for the even positions of horizontal lines |
| `--oddchar <char>`   | Character for the odd positions of horizontal lines  |
| `--startchar <char>` | Character that starts horizontal lines               |
| `--endchar <char>`   | Character that ends horizontal lines                 |
| `--sepchar <char>`   | Character that separates protocol fields             |

```plain
Bit counts                                                     sepchar(|)
 ^   ^                                                              |
 |   |                                                              |
 |   |                                                              |
 0   |               1                   2                   3      |
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+   |
|             Source            |      TTL      |    Reserved   | <-+
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
^              ^ ^ ^              ^ ^ ^                         ^
|              | | |              | | |                         |
startchar(+)  evenchar( -)       oddchar(+)                endchar(+)

|<------------------------------------------------------------->|
                                 bits(32)
```

### 支持的协议

```plain
"ethernet"            : Ethernet
"8021q"               : IEEE 802.1q
"dot1q"               : IEEE 802.1q
"tcp"                 : Transmission Control Protocol (TCP)
"udp"                 : User Datagram Protocol (TCP)
"ip"                  : Internet Protocol (IP), version 4.
"ipv6"                : Internet Protocol (IP), version 6.
"icmp"                : Internet Control Message Protocol (ICMP)
"icmp-destination":   : ICMP Destination Unreachable
"icmp-time"           : ICMP Time Exceeded
"icmp-parameter"      : ICMP Parameter Problem
"icmp-source"         : ICMP Source Quench
"icmp-redirect"       : ICMP Redirect
"icmp-echo"           : ICMP Echo Request/Reply
"icmp-timestamp"      : ICMP Timestamp Request/Reply
"icmp-information"    : ICMP Information Request/Reply
"icmpv6"              : Internet Control Message Protocol for IPv6 (ICMPv6)
"icmpv6-destination"  : ICMPv6 Destination Unreachable
"icmpv6-big"          : ICMPv6 Packet Too Big
"icmpv6-time"         : ICMPv6 Time Exceeded
"icmpv6-parameter"    : ICMPv6 Parameter Problem
"icmpv6-echo"         : ICMPv6 Echo Request/Reply
"icmpv6-rsol"         : ICMPv6 Router Solicitation
"icmpv6-radv"         : ICMPv6 Router Advertisement
"icmpv6-nsol"         : ICMPv6 Neighbor Solicitation
"icmpv6-nadv"         : ICMPv6 Neighbor Advertisement
"icmpv6-redirect"     : ICMPv6 Redirect
```

### 自定义协议

除了上述协议外，还可以自定义协议，协议规范如下：

```plain
"<LIST_OF_FIELDS>[?OPTIONS]"
```

* LIST_OF_FIELDS

逗号分割的协议字段名称（不能是 “?”）和字段长度（单位：bit）。如果协议字段包含空格，则协议规范必须使用双引号。

```plain
// 逗号后面没有空格
Type:8,Code:8,Checksum:16,Message Body:64
Source Port:16,Destination Port:16,Length:16,Checksum:16
```

字段长度不需要和行的长度对齐，如果某个特定字段太长，协议将把它包装到下一行。

```sh
# 示例
$ protocol "Source:16,Reserved:40,TTL:8"
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|             Source            |                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+               +-+-+-+-+-+-+-+-+
|                    Reserved                   |      TTL      |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

```sh
$ protocol "Reserved:32,Target Address:128"
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                            Reserved                           |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
+                                                               +
|                                                               |
+                         Target Address                        +
|                                                               |
+                                                               +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

* [?OPTIONS]

可选部分，允许用户为 ASCII 协议头指定格式修饰符。

## 示例

```sh
# TCP 包头格式
$ protocol tcp

 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Source Port          |        Destination Port       |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                        Sequence Number                        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                     Acknowledgment Number                     |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Offset|  Res. |     Flags     |             Window            |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|            Checksum           |         Urgent Pointer        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Options                    |    Padding    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

```sh
$ protocol "Source Port:16,Destination Port:16,Sequence Number:32,\
      Acknowledgment Number:32,Offset:4,Res.:4,Flags:8,Window:16,Checksum:16,\
      Urgent Pointer:16,Options:24,Padding:8"

 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Source Port          |        Destination Port       |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                        Sequence Number                        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                        Acknowledgment Number                  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| Offset|  Res. |     Flags     |             Window            |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|            Checksum           |            Urgent Pointer     |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Options                    |    Padding    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

```sh
$ protocol "Field4:4,Field4:4,Field8:8,Field16:16,Field32:32,Field64:64?\
      bits=16,numbers=y,startchar=*,endchar=*,evenchar=-,oddchar=-,sepchar=|"

 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
*---------------------------------------------------------------*
| Field4| Field4|     Field8    |            Field16            |
*---------------------------------------------------------------*
|                            Field32                            |
*---------------------------------------------------------------*
|                                                               |
*                            Field64                            *
|                                                               |
*---------------------------------------------------------------*
```

```sh
$ protocol ip --bits 16

 0                   1
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|Version|  IHL  |Type of Service|
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Total Length         |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|         Identification        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|Flags|     Fragment Offset     |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|  Time to Live |    Protocol   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|        Header Checksum        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                               |
+         Source Address        +
|                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                               |
+      Destination Address      +
|                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|            Options            |
+               +-+-+-+-+-+-+-+-+
|               |    Padding    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

```sh
$ protocol udp --evenchar "-" --oddchar " "
$ protocol udp --evenchar "-" --oddchar " " --startchar "+" --endchar "+"

 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -+
|          Source Port          |        Destination Port       |
+- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -+
|             Length            |            Checksum           |
+- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -+
```

```sh
$ protocol ipv6 --no-numbers

+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|Version| Traffic Class |               Flow Label              |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|         Payload Length        |  Next Header  |   Hop Limit   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
+                                                               +
|                                                               |
+                         Source Address                        +
|                                                               |
+                                                               +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
+                                                               +
|                                                               |
+                       Destination Address                     +
|                                                               |
+                                                               +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

```sh
# 输出多个协议
$ protocol udp icmp

 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Source Port          |        Destination Port       |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|             Length            |            Checksum           |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|      Type     |      Code     |            Checksum           |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
+                          Message Body                         +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## 参考

* [PROTOCOL](https://github.com/luismartingarcia/protocol)

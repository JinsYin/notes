# iperf 测量网络吞吐量

## iperf2 vs iperf3

Iperf3 is rewrite of iperf from scratch to create a smaller, simpler code base and a library version of the functionality that can be used in other programs, iperf3 is single threaded while iperf2 is multi-threaded[2]. Iperf3 was started in 2009, with the first release in January 2014. The website states: "iperf3 is not backwards compatible with iperf2.x".

## 安装 iperf

```sh
# CentOS
$ yum install epel-release
$ yum install -y iperf
```

## TCP 测量

* Server

```sh
$ iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
```

* Client

```sh
$ iperf -c <server-ip> -P 1 # 1 个线程
------------------------------------------------------------
Client connecting to 10.0.10.100, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  3] local 10.0.10.200 port 34880 connected with 10.0.10.100 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec  5.66 GBytes  4.86 Gbits/sec
```

## UDP 测量

* Server

```sh
$ iperf -s -u
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size:  208 KByte (default)
------------------------------------------------------------
```

* Client

```sh
$ iperf -c <server-ip> -u -P 1 # 1 个线程
------------------------------------------------------------
Client connecting to 10.0.10.100, UDP port 5001
Sending 1470 byte datagrams, IPG target: 11215.21 us (kalman adjust)
UDP buffer size:  208 KByte (default)
------------------------------------------------------------
[  3] local 10.0.10.200 port 52647 connected with 10.0.10.100 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec  1.25 MBytes  1.05 Mbits/sec
[  3] Sent 892 datagrams
[  3] Server Report:
[  3]  0.0-10.0 sec  1.25 MBytes  1.05 Mbits/sec   0.006 ms    0/  892 (0%)
```

## 参考

* [iperf3 FAQ](http://software.es.net/iperf/faq.html)
* [iperf3 at 40Gbps and above](https://fasterdata.es.net/performance-testing/network-troubleshooting-tools/iperf/multi-stream-iperf3/)
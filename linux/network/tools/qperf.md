# qperf 测量网络带宽和延迟

## 安装

```bash
# qperf 来自 epel-release 源
$ yum install -y epel-release qperf
```

## 测量带宽

* server

```bash
# 默认监听在 TCP/19765，可以使用 --listen_port 选项进行修改
$ qperf

# 防火墙
$ iptables -I INPUT -m tcp --dport 19765 -j ACCEPT
# 或
$ firewall-cmd --add-port=19765/tcp
```

* client

```bash
# 单位是 MB/sec、GB/sec 等
$ qperf -t 60 <server-ip> tcp_bw
tcp_bw:
    bw  =  702 MB/sec

# 单位是 Gb/sec （注意是 bit）
$ qperf -t 60 --use_bits_per_sec <server-ip> tcp_bw
tcp_bw:
    bw  =  4.57 Gb/sec
```

## 测量延迟

* client

```bash
$ qperf -vvs <server-ip> tcp_lat
tcp_lat:
    latency         =    15.8 us
    msg_rate        =    63.1 K/sec
    loc_send_bytes  =    63.1 KB
    loc_recv_bytes  =    63.1 KB
    loc_send_msgs   =  63,150
    loc_recv_msgs   =  63,149
    rem_send_bytes  =    63.1 KB
    rem_recv_bytes  =    63.1 KB
    rem_send_msgs   =  63,150
    rem_recv_msgs   =  63,150
```

## 参考

* [How to use qperf to measure network bandwidth and latency performance](https://access.redhat.com/solutions/2122681)
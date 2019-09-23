# Docker 常见错误

## docker info

* 问题

```palin
WARNING: IPv4 forwarding is disabled
WARNING: bridge-nf-call-iptables is disabled
WARNING: bridge-nf-call-ip6tables is disabled
```

* 解决

需要修改 Kernel 参数，以允许 IP 转发、开启 iptables 。

```sh
# 启用 net.ipv4.ip_forward 使得在多网络接口设备模式下，数据报可以在网络设备之间转发
$ sysctl -w net.ipv4.ip_forward=1 # 方法一
$ dockerd --ip-forward=true # 方法二（方法一和方法二是等价的）

# 临时
$ sysctl -w net.bridge.bridge-nf-call-iptables=1
$ sysctl -w net.bridge.bridge-nf-call-ip6tables=1
```

```sh
# 永久
$ cat >> /etc/sysctl.conf <<EOF
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
EOF

# 立即生效
$ sysctl -p /etc/sysctl.conf
```

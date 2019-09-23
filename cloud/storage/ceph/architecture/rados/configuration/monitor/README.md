# Monitor 配置

```ini
[global]
mon initial members = ip-192-168-1-222.ceph.ew # 对应的 Monitor ID 就是这个
mon host = 192.168.1.222 # 对应的 Monitor 地址为 192.168.1.222:6789
```

```ini
[mon.a] # 对应的 Monitor ID 为 a
host = ip-192-168-1-222.ceph.ew
mon addr = 192.168.1.222:6789
```

```ini
[mon]
mon host = <mon_ip:port> <mon_ip:port> ... <new_mon_ip:port>

[mon.<mon_id>]
host = <mon_id>
mon addr = <mon_ip>
```

```ini
[global]
mon initial members = node1 node2 node3 node4
...
[mon]
mon host = 192.168.0.1:6789 192.168.0.2:6789 192.168.0.3:6789 192.168.0.4:6789
...
[mon.node4]
host = node4
mon addr = 192.168.0.4
```

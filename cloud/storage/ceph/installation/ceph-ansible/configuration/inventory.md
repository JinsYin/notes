# 主机清单 Inventory

```yaml
# ceph-mon
[mons]
192.168.10.[205:207]

# 为了让 playbook 创建 CRUSH 层次结构，必须像下面一样设置 Inventory 文件
[osds]
192.168.10.210 osd_crush_location="{'root': 'ew', 'region': 'shh', 'datacenter': 'dchk', 'room': '411', 'rack': 'r1', 'host': 'ip-210.ceph.ew'}"
192.168.10.211 osd_crush_location="{'root': 'ew', 'region': 'shh', 'datacenter': 'dchk', 'room': '411', 'rack': 'r3', 'host': 'ip-211.ceph.ew'}"
192.168.10.212 osd_crush_location="{'root': 'ew', 'region': 'shh', 'datacenter': 'dchk', 'room': '411', 'rack': 'r2', 'host': 'ip-212.ceph.ew'}"
192.168.10.213 osd_crush_location="{'root': 'ew', 'region': 'shh', 'datacenter': 'dchk', 'room': '411', 'rack': 'r2', 'host': 'ip-213.ceph.ew'}"
```

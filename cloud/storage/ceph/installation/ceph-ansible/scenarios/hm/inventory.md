# Inventory & hosts

## /etc/ansible/hosts

```ini
# 第一列可以是 IP 地址或主机别名；如果第一列是主机别名，确保已在 /etc/hosts 中定义并同步到所有机器

[admins]
192.168.10.111

[clients]
192.168.10.111 # 1Gbps

[mons]
mon205 monitor_address=192.168.100.205
mon206 monitor_address=192.168.100.206
mon207 monitor_address=192.168.100.207

[rgws]
rgw205 radosgw_address=192.168.100.205
rgw206 radosgw_address=192.168.100.206
rgw207 radosgw_address=192.168.100.207

[mdss]
mds205
mds206
mds207

[mgrs]
mgr205
mgr206
mgr207

# 为了让 playbook 创建 CRUSH 层次结构，必须像下面一样设置 Inventory 文件
[osds]
osd210 osd_crush_location="{'root': 'ew', 'region': 'shh', 'datacenter': 'dchk', 'room': '411', 'rack': 'r1', 'host': 'ip-210-ceph-ew'}"
osd211 osd_crush_location="{'root': 'ew', 'region': 'shh', 'datacenter': 'dchk', 'room': '411', 'rack': 'r3', 'host': 'ip-211-ceph-ew'}"
osd212 osd_crush_location="{'root': 'ew', 'region': 'shh', 'datacenter': 'dchk', 'room': '411', 'rack': 'r2', 'host': 'ip-212-ceph-ew'}"
osd213 osd_crush_location="{'root': 'ew', 'region': 'shh', 'datacenter': 'dchk', 'room': '411', 'rack': 'r2', 'host': 'ip-213-ceph-ew'}"
```

## /etc/hosts

```ini
192.168.100.111 ip-110-kvm-ew

192.168.100.210 ip-210-ceph-ew osd210
192.168.100.211 ip-211-ceph-ew osd211
192.168.100.212 ip-212-ceph-ew osd212
192.168.100.213 ip-213-ceph-ew osd213

192.168.100.205 ip-205-gw-ceph-ew mon205 mds205 rgw205 mgr205
192.168.100.206 ip-206-gw-ceph-ew mon206 mds206 rgw206 mgr206
192.168.100.207 ip-207-gw-ceph-ew mon207 mds207 rgw207 mgr207
```

```sh
$ ansible all -m copy -a 'src=/etc/hosts dest=/etc/hosts mode=0644'
```

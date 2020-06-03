# ceph config log

## 示例

```sh
$ ceph config set "mgr" "mgr/dashboard/ip-192-168-10-205/server_addr" "192.168.10.205"

$ ceph config log
--- 2 --- 2020-01-19 16:55:39.298381 ---
+ mgr/mgr/dashboard/ip-192-168-10-205/server_addr = 192.168.10.205
--- 1 --- 2020-01-06 16:53:19.583646 ---
```

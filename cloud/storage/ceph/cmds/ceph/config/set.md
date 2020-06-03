# ceph config set

## 用法

```sh
ceph config set <who> <name> <value>
```

## 示例

```sh
# 允许删除存储池
$ ceph config set mon mon_allow_pool_delete true
```

```sh
$ ceph config set "mgr" "mgr/dashboard/ip-192-168-10-205/server_addr" "192.168.10.205"
```

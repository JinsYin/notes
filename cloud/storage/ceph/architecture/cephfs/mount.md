# 挂载

## 用法

```sh
mount.ceph monaddr1[,monaddr2,…]:/[subdir] dir [ -o options ]
```

## 示例

```sh
# 挂载 CephFS 的默认文件系统（通常是 `cephfs`）
$ mount -t ceph 192.168.100.205:6789,192.168.100.206:6789,192.168.100.207:6789:/ /home/zzh/ceph_cfs/ -o name=admin,secret=AQB/9RJe8aDEIhAAat0ZbQKtS5IHzvI2kT9fng==
```

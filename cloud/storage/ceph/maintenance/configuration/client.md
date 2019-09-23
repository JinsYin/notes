# Ceph 客户端配置

## 客户端类型

* Ceph 块设备客户端
* Ceph 文件系统客户端

## 客户端配置

Ceph 客户端只需要在 `[client]` 下配置 Monitor 地址即可。

```sh
# ceph -s --name client.jins --keyring ceph.client.jins.keyring --conf ceph.conf
$ cat ceph.conf
[client]
    mon host = 192.168.8.222:6789,192.168.8.221:6789,192.168.8.220:6789
```

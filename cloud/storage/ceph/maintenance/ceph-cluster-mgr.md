# Ceph 集群管理

## 列出所有 Ceph systemd units

```sh
$ systemctl status ceph.service ceph.target
```

## 查看所有失败的 Ceph systemd unit

```sh
$ systemctl --failed | grep ceph
```

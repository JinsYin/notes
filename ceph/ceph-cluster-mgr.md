# Ceph 集群管理

## 列出所有 Ceph systemd units

```bash
$ sudo systemctl status ceph\*.service ceph\*.target
```

## 查看所有失败的 Ceph systemd unit

```bash
$ systemctl --failed | grep ceph
```


# Ceph Debug

## 查看日志、状态

```sh
$ # 状态
$ systemctl status ceph-osd@0.service

$ # unit 日志
$ journalctl -f -u ceph-osd@0.service
```
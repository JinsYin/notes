# Ceph Debug

## 查看日志、状态

```bash
$ # 状态
$ systemctl status ceph-osd@0.service

$ # unit 日志
$ journalctl -e -u ceph-osd@0.service
```
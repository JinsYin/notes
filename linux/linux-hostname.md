# Linux 主机名

## 修改主机名

```bash
$ # 永久写入 hostname
$ echo "192-168-10-200.data.centos" > /etc/hostname 

$ # 不重启的情况下使内核生效
$ sysctl kernel.hostname=192-168-10-200.data.centos

$ # 验证
$ hostname
192-168-10-200.data.centos
```

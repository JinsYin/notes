# hostname | hostnamectl

## 修改主机名

```bash
# 永久写入 hostname，但需要重启才生效
$ echo "centos-data-1" > /etc/hostname 

# 不重启的情况下使内核生效，但重启后无效
$ sysctl kernel.hostname=centos-data-1

# 内核生效 + 重启生效（建议）
$ hostnamectl --static set-hostname centos-data-1

# 验证
$ hostname
centos-data-1
```

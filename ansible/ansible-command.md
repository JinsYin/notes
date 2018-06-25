# Ansible 命令

## 并行数 --fork

默认值：`5`

```bash
$ ansible all -a "/sbin/reboot" -f 10
```
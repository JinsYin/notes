# SSH 守护进程配置

```sh
$ man 5 sshd_config
```

## 配置选项

| 配置选项 | 默认值 | 描述                                                                                           |
| -------- | ------ | ---------------------------------------------------------------------------------------------- |
| UseDNS   | `no`   | 指定是否 sshd 应该查找远程主机名，以及检查远程 IP 地址的解析主机名是否映射回非常相同的 IP 地址 |

### UseDNS

* `no`

在 `~/.ssh/authorized_keys` **from** 和 **sshd_config match host** 指令中只能使用地址而不能使用主机名。

* 建议

```sh
sed -i "/#UseDNS/ s|^#||; /UseDNS/ s|yes|no|" /etc/ssh/sshd_config
```

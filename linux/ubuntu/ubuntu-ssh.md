# Ubuntu ssh

## 允许 root 用户登录

修改/设置密码
```bash
$ passwd root
```

修改配置并重启服务
```bash
$ sed -i 's|PermitRootLogin without-password| PermitRootLogin yes|g' /etc/ssh/sshd_config
$ service ssh restart
```

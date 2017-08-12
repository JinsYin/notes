# Linux SSH

## 

```
The authenticity of host '9.111.143.205 (9.111.143.205)' can't be established.
ECDSA key fingerprint is SHA256:QQYvT8PFYzVL8oD5fIySTEH5LjPCN8BtayCDLsvp42k.
Are you sure you want to continue connecting (yes/no)?
```

```bash
$ vi ~/.ssh/config
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
```

OR 

```bash
$ vi /etc/ssh/sshd_config
IgnoreUserKnownHosts yes
```

## 参考

> http://geek.csdn.net/news/detail/93239
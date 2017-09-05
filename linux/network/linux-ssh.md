# Linux SSH

## ssh-keygen

```bash
$ ssh-keygen -t rsa -N ''
```

## ssh-agent

```bash
$ 
```


## 问题整理

* 首次登录免确认

首次登录时，如果没有把被登录节点加入到 `~/.ssh/known_hosts` 中会提示是否继续连接。如果使用脚本来登录时需要避免出现这样的情况，因为脚本无法像键入 Enter 键一样进行确认。

```
The authenticity of host '9.111.143.205 (9.111.143.205)' can't be established.
ECDSA key fingerprint is SHA256:QQYvT8PFYzVL8oD5fIySTEH5LjPCN8BtayCDLsvp42k.
Are you sure you want to continue connecting (yes/no)?
```

```bash
$ # 登录端进行修改
$ cat >> ~/.ssh/config <<EOF
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
EOF
$
$ # 别忘了修改权限
$ chmod 0600 ~/.ssh/config
```

OR 

```bash
$ # 服务端进行修改
$ vi /etc/ssh/sshd_config
IgnoreUserKnownHosts yes
$
$ # 别忘了重启 sshd
$ systemctl restart sshd.service
```

* ssh 登录时提示　“Permission denied (publickey,gssapi-keyex,gssapi-with-mic).”

（暂时没有找到解决办法）


## 参考

* [ssh-agent 命令](http://man.linuxde.net/ssh-agent)
* [SSH agent 转发](http://wiki.jikexueyuan.com/project/github-developer-guides/using-ssh-agent.html)

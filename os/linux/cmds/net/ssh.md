# SSH

## ssh-keygen

```sh
$ ssh-keygen -t rsa -N ''
```

## ssh-agent

## 问题整理

* 首次登录免确认

首次登录时，如果没有把被登录节点加入到 `~/.ssh/known_hosts` 中会提示是否继续连接。如果使用脚本来登录时需要避免出现这样的情况，因为脚本无法像键入 Enter 键一样进行确认。

```PlainText
The authenticity of host '9.111.143.205 (9.111.143.205)' can't be established.
ECDSA key fingerprint is SHA256:QQYvT8PFYzVL8oD5fIySTEH5LjPCN8BtayCDLsvp42k.
Are you sure you want to continue connecting (yes/no)?
```

```sh
# 登录端进行修改
$ cat >> ~/.ssh/config <<EOF
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
EOF

# 别忘了修改权限
$ chmod 0600 ~/.ssh/config
```

OR：

```sh
# 服务端进行修改
$ vi /etc/ssh/sshd_config
IgnoreUserKnownHosts yes

# 别忘了重启 sshd
$ systemctl restart sshd.service
```

* ssh 登录时提示 “Permission denied (publickey,gssapi-keyex,gssapi-with-mic).”

DigitalOcean 经常出现此问题，原因是在网页中添加客户端的 SSH keys 可能并未生效，最稳妥的方法是将客户端的公钥手动添加到服务端的 authorized_key 中。

## 参考

* [ssh-agent 命令](http://man.linuxde.net/ssh-agent)
* [SSH agent 转发](http://wiki.jikexueyuan.com/project/github-developer-guides/using-ssh-agent.html)

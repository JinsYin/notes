# Linux SSH

## 问题整理

* ssh 登录时提示　“Permission denied (publickey,gssapi-keyex,gssapi-with-mic).”

解决办法：

```bash
$ tee ~/.ssh/config << EOF
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
EOF
$
$ chmod 0600 ~/.ssh/config
```


> http://man.linuxde.net/ssh-agent
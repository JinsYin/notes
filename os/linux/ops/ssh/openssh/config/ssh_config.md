# SSH 客户端配置

```bash
$ man 5 ssh_config
```

## 配置选项

| 配置选项              | 默认值 | 描述                                                                     |
| --------------------- | ------ | ------------------------------------------------------------------------ |
| StrictHostKeyChecking | `ask`  | 登录远程机器时强制检查主机密钥是否添加到本机的 `~/.ssh/known_hosts` 文件 |

> 默认配置文件：`/etc/ssh/ssh_config`

### StrictHostKeyChecking

* `yes`

登录前必须手动将远程机器的密钥添加到 `~/.ssh/known_hosts`（OpenSSH 绝不会自动添加），否则将拒绝连接。远程机器的密钥改变也会拒绝连接。

```bash
$ ssh 192.168.1.172
No ECDSA host key is known for 192.168.1.172 and you have requested strict checking.
Host key verification failed.
```

* `ask`

登录时必须手动键入 `yes` 才能将远程机器的密钥添加到本机的 `~/.ssh/known_hosts` 文件中，否则将无法登录远程机器。

```bash
$ ssh 192.168.1.172
The authenticity of host '192.168.1.172 (192.168.1.172)' can't be established.
ECDSA key fingerprint is SHA256:qUjc7UrycpKj/c67ZDIc+236DLpKl+mCi8bKSHLdT48.
ECDSA key fingerprint is MD5:76:ae:24:46:a8:aa:74:c5:25:b3:c2:1d:35:2e:8f:3f.
Are you sure you want to continue connecting (yes/no)?
```

* `no`

首次登录时，OpenSSH 会自动将远程机器的密钥添加到本机的 `~/.ssh/known_hosts` 文件中。

```bash
$ ssh 192.168.1.172
Warning: Permanently added '192.168.1.172' (ECDSA) to the list of known hosts. # 第二次登录时将自动消失
root@192.168.1.172's password:
```

* 建议

```bash
sed -i '/StrictHostKeyChecking/ s|^#| |; /StrictHostKeyChecking/ s|ask|no|' /etc/ssh/ssh_config
```
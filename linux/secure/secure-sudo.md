# Linux sudo

## sudo 含义

在命令的前面添加 `sudo`，实际上是以 `root` 用户的身份来执行该命令。

```bash
[vagrant@node ~]$ whoami
vagrant
[vagrant@node ~]$
[vagrant@node ~]$ sudo whoami
root
```


## sudo 权限检查

判断当前用户是不是 root 用户，或者是否使用了 `sudo` 命令，除了使用 `whoami` 命令以外，还可以通过 `id` 命令来判断。

解释：root 用户的 UID 为 `0`、GID 也为 `0`。

```bash
[vagrant@node ~]$ id
uid=1000(vagrant) gid=1000(vagrant) groups=1000(vagrant) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
[vagrant@node ~]$ 
[vagrant@node ~]$ id -u
1000
[vagrant@node ~]$
[vagrant@node ~]$ id -g
1000
```

```bash
[vagrant@node ~]$ sudo id
uid=0(root) gid=0(root) groups=0(root) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
[vagrant@node ~]$ 
[vagrant@node ~]$ sudo id -u
0
[vagrant@node ~]$
[vagrant@node ~]$ id -g
0
```
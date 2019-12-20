# sudo

## 含义

在命令的前面添加 `sudo`，实际上是以 `root` 用户的身份来执行该命令。

```sh
[jinsyin@node ~]$ whoami      # jinsyin
[jinsyin@node ~]$ sudo whoami # root
```

## 权限检查

判断当前用户是不是 root 用户，或者是否使用了 `sudo` 命令，除了使用 `whoami` 命令以外，还可以通过 `id` 命令来判断。

* id 命令

```sh
$ id jinsyin
uid=1000(jinsyin) gid=1000(jinsyin) groups=1000(jinsyin)

$ id -u jinsyin # uid=1000

$ id -g jinsyin # gid=1000
```

```sh
# id root
$ sudo id
uid=0(root) gid=0(root) groups=0(root)

# id -u root
$ sudo id -u # uid=0

# id -g root
$ sudo id -g # gid=0
```

> `root` 用户的 UID 和 GID 都是 `0`

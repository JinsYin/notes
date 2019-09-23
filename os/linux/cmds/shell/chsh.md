# chsh

更改 **login shell**。

## 用法

```sh
chsh [options] [LOGIN]
```

## 选项

| 选项                                | 描述                                                                 |
| ----------------------------------- | -------------------------------------------------------------------- |
| `-s`/`--shell` <ins>SHELL</ins>     | 指定新的 **login shell**；<ins>SHELL</ins> 是 **login shell** 的路径 |
| `-R`/`--root` <ins>CHROOT_DIR</ins> |                                                                      |

## 示例

* 更改当前用户的 login shell

```sh
$ whoami
yin

# 要求输入 root 密码（注：使用 sudo 更改的是 root 用户的 login shell）
$ chsh -s /bin/zsh

# 检查
$ cat /etc/passwd | grep yin
yin:x:1000:1000:Yin,,,:/home/yin:/bin/zsh

# 检查
$ echo $SHELL
/bin/zsh
```

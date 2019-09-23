# file

`file` 用于判断文件类型

## 示例

```sh
$ file /etc
/etc: directory

$ file /dev/null
/dev/null: character special

$ file /dev/sda
/dev/sda: block special

$ file /etc/hosts
/etc/hosts: ASCII text

$ file /etc/resolv.conf
/etc/resolv.conf: symbolic link to '../run/resolvconf/resolv.conf'

$ file /bin/ls
/bin/ls: ELF 64-bit LSB  executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=bd39c07194a778ccc066fc963ca152bdfaa3f971, stripped

$ file /run/docker.sock
/run/docker.sock: socket
```

---
---
# type

`type COMMAND` 用于判断命令的类型。

## 命令类型

| 命令类型       | 描述                                |
| -------------- | ----------------------------------- |
| 可执行文件     | ～                                  |
| shell 内置命令 | 可以在运行的 shell 进程中执行的命令 |
| 别名           | ～                                  |

## 示例

```sh
$ type ps
ps is /bin/ps

$ type ll
ll is aliased to `ls -laF'

$ type wget
wget is /usr/local/bin/wget

$ type man
man is hashed (/usr/bin/man)
```

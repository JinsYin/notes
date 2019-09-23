# env

## PATH

`PATH` 环境变量指定当前用户可以直接命令访问的可执行文件路径，多个路径之间用 `:` 分割。

```sh
# macOS
$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Applications/Wireshark.app/Contents/MacOS:/Users/in/go/bin:/usr/local/bin:/usr/local/go/bin:/Users/in/go/bin
```

## EDITOR

`EDITOR` 环境变量指定当前用户的默认编辑器。

```sh
$ export EDITOR=vim
```
